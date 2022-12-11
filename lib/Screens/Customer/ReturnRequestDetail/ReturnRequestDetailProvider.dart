/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/Model/GetReturnRequestModel.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/Model/ReturnRequestModel.dart';
import 'package:nopcommerce/Models/UploadFileModel.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestMassage.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/ReturnRequestService.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class ReturnRequestDetailProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isOpen = false;
  bool loadingPath = false;
  int selectedValue = 0;
  int selectedValues = 0;
  int selectedValue1 = 0;
  int selectAction=0;
  int selectReason=0;
  Map<int,int> selectQnt={};
  Map<int,List<int>> quantity={};
  Map<int,int> qnt={};
  Map<int,int> selectedIndex={};
  String selectedReason = '';
  String selectedAction = '';
  String? fileName;
  String? filePath;
  String? extension;
  String base64 = "";
  List<DropDownModel> reasonDropdown = [];
  List<DropDownModel> actionDropdown = [];
  List<PlatformFile>? paths;
  late UploadFileModel uploadFileModel;
   late ReturnRequestModel returnRequestModel;
  late GetReturnRequestModel getReturnRequestModel;
  TextEditingController returnRequest = new TextEditingController();
  HeaderInfoResponseModel headerModel = new HeaderInfoResponseModel(
      isAuthenticated: false,
      customerName: "",
      shoppingCartEnabled: false,
      shoppingCartItems: 0,
      wishlistEnabled: false,
      wishlistItems: 0,
      allowPrivateMessages: false,
      unreadPrivateMessages: "",
      alertMessage: "",
      registrationType: "",
      customProperties: CustomProperties()
  );

  pageLoadData({required BuildContext context}){
    isPageLoader = true;
    isAPILoader = true;
    selectedValue = 0;
    selectedValues = 0;
    selectedValue1 = 0;
    selectAction=0;
    selectReason=0;
    selectQnt={};
    returnRequest.text="";
    quantity={};
    qnt={};
    selectedIndex={};
    base64 = "";
    selectedReason = '';
    selectedAction = '';
    reasonDropdown = [];
    actionDropdown = [];
    notifyListeners();
  }

  getReturnRequestByOrderId({required BuildContext context,required int orderId}) async {

    Response response = await ReturnRequestService().getReturnRequest(context: context, param:"/$orderId");
    if (response.statusCode == 200) {
      getReturnRequestModel = getReturnRequestModelFromJson(response.body);
      reasonDropdown.clear();
      for (var Items in getReturnRequestModel.availableReturnReasons) {
        reasonDropdown.add(new DropDownModel(text: Items.name, value: Items.name));
      }
      selectedValue = getReturnRequestModel.availableReturnActions[0].id;
      actionDropdown.clear();
      for (var Items in getReturnRequestModel.availableReturnActions) {
        actionDropdown.add(new DropDownModel(text: Items.name, value: Items.name));
      }
      selectedValue1 = getReturnRequestModel.availableReturnActions[0].id;
      selectedValues = getReturnRequestModel.items[0].id;
      if(selectedReason==''){
        selectedReason = getReturnRequestModel.availableReturnReasons[0].name;
      }
      if(selectedAction==''){
        selectedAction = getReturnRequestModel.availableReturnActions[0].name;
      }
      isAPILoader = false;
    }
    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }
    isPageLoader=false;
    isAPILoader=false;
    notifyListeners();
  }

  reasonChange(String value)
  {
    selectedReason = value;
    for(var i in getReturnRequestModel.availableReturnReasons){
      if(i.name==selectedReason){
        selectReason=i.id;
      }
    }
  notifyListeners();
  }

  actionChange(String value)
  {
    selectedAction = value;
      for(var i in getReturnRequestModel.availableReturnActions){
        if(i.name==selectedAction){
          selectAction=i.id;

        }
      }
   notifyListeners();
  }

  openFileExplorer({required BuildContext context}) async {

    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      loadingPath = true;
      try {
        paths = (await FilePicker.platform.pickFiles(allowedExtensions: (extension?.isNotEmpty ?? false) ? extension?.replaceAll(' ', '').split(','): null,))?.files;
      } on PlatformException catch (e) {
        print("Pick File Eroor $e");
      } catch (ex) {
      }

      if(paths != null && paths != "")
      {
        loadingPath = false;
        fileName = paths != null ? paths!.map((e) => e.name).toString() : '...';
        filePath = paths != null ? paths!.map((e) => e.path).toString() : '...';
        filePath=filePath!.substring(1,filePath!.length-1);
        fileName=fileName!.substring(1,fileName!.length-1);
        List<int> bytes = File(filePath!).readAsBytesSync();
        base64 = base64Encode(bytes);
        if(base64.isNotEmpty){

          isAPILoader=true;
          notifyListeners();

          final body='{ '
              '"fileBase64String": "$base64",'
              '"fileName": "$fileName",'
              '}';
          Response response=await ReturnRequestService().uploadFileReturnRequest(context: context, body: body);
          if(response.statusCode==200){
            uploadFileModel=uploadFileModelFromJson(response.body);
            getReturnRequestModel.uploadedFileGuid=uploadFileModel.uploadedFileGuid;
            if(uploadFileModel.success){
              FlushBarMessage().successMessage(context: context, title: uploadFileModel.message);
            }
            isAPILoader=false;
          }
        }
      }
    }
    notifyListeners();
  }

  updateButtonClickEvent({required BuildContext context,required int orderId})async
  {
    isAPILoader=true;
    notifyListeners();
    Map<String, int> orderItemsQuantity = {};
    for (var items in getReturnRequestModel.items) {
      orderItemsQuantity["${items.id}"] = items.quantity;
    }
    final body='{ '
        '"uploadedFileGuid": "${getReturnRequestModel.uploadedFileGuid}",'
        '"returnRequestReasonId": "$selectReason",'
        '"returnRequestActionId": "$selectAction",'
        '"comments": "${returnRequest.text}",'
        '"orderItemsQuantity": $qnt,'
        '}';

    Response response = await ReturnRequestService().returnRequest(context: context, body: body, param: '/$orderId');
    if(response.statusCode==200){
     returnRequestModel =returnRequestModelFromJson(response.body);
     Navigator.push(context, PageTransition(type: selectedTransition, child: ReturnRequestMassage(returnRequestModel.result, returnRequestModel.customOrderNumber)));
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    isPageLoader=false;
    isAPILoader=false;
    notifyListeners();
   }
}

