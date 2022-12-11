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
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Screens/Customer/Avatar/Models/GetAvatarResponseModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/AvatarService.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class AvatarProvider extends ChangeNotifier {

  bool isPageLoader = true;
  bool isAPILoader = false;
  bool isOpen = false;
  bool imageNetwork=true;
  bool size=true;
  String base64 = "";
  String imageName = "";
  File imageFile=new File("");
  late GetAvatarResponseModel getAvatarResponseModel;
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
    getAvatarData(context: context);
    notifyListeners();
  }

  getAvatarData({required BuildContext context})async{

    Response response=await AvatarService().getAvatar(context: context);
    if(response.statusCode==200){
      storage.setItem(StringConstants.CACHE_AVATAR, response.body);
      getAvatarResponseModel=getAvatarResponseModelFromJson(response.body);
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
      isAPILoader=false;
    }
    getHeaderData(context: context);
    notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {

    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();
  }

  getFromGallery() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (pickedFile != null) {
      PlatformFile file = pickedFile.files.first;
      imageFile = File(file.path!);
      final bytes = imageFile.readAsBytesSync().lengthInBytes;
      int minImageBytes=20;
      final imageFilePath = imageFile.readAsBytesSync();
      imageName = imageFile.path.split("/").last;
      base64 = base64Encode(imageFilePath);
      imageNetwork = false;
      if(LocalResourceProvider().getSettingByName("customerSettings.avatarMaximumSizeBytes") != "customerSettings.avatarMaximumSizeBytes")
      {
        minImageBytes = int.parse(LocalResourceProvider().getSettingByName("customerSettings.avatarMaximumSizeBytes"));
      }
      if(bytes > minImageBytes){
        size=false;
      }else{
        size=true;
      }
    }
    notifyListeners();
  }


  openFileExplorer({required BuildContext context}) async {

    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      getFromGallery();
    }
  }

  uploadButtonClickEvent({required BuildContext context,required String imgBase64,required String imageName})async
  {
    isAPILoader=true;
    notifyListeners();
    var body=''
        '{'
        '"avatarBase64String": "$imgBase64",'
        '"avatarFileName": "$imageName"}';
    Response response=await AvatarService().uploadAvatar(context: context, body: body);
    if(response.statusCode==200){
      getAvatarResponseModel=getAvatarResponseModelFromJson(response.body);
      FlushBarMessage().successMessage(context: context, title: StringConstants.AVATAR_UPLOAD);
      imageName = "";
      imgBase64 = "";
      isAPILoader=false;
      notifyListeners();
    }else if(response.statusCode==400){
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: errors.errors.join("\n"));
    }
    else{
      isAPILoader=false;
      notifyListeners();
    }
  }

  deleteButtonClickEvent({required BuildContext context})async
  {
    isAPILoader=true;
    notifyListeners();
    Response response = await AvatarService().deleteAvatar(context: context);
    if(response.statusCode==200){
      imageName = "";
      base64 = "";
      getAvatarData(context: context);
      imageFile=File("");
      isAPILoader=false;
    }
    notifyListeners();
  }

  loadCacheData({required BuildContext context})async{
    isPageLoader = true;
    isAPILoader = false;
    imageFile=File("");
    imageNetwork=true;
    size=true;
    imageName = "";
    base64 = "";
    isOpen = false;

    await getCacheAvatarData(context:context);
    await getCacheHeader(context: context);
  }

  getCacheAvatarData({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_AVATAR);
    if(res != null)
    {
      getAvatarResponseModel = getAvatarResponseModelFromJson(res);
      isPageLoader = false;
      notifyListeners();
      return getAvatarResponseModel;
    }else{
      return null;
    }
  }

  getCacheHeader({required BuildContext context}) async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_HEADER);
    if(res != null)
    {
      headerModel = headerInfoResponseModelFromJson(res);
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: "Notification", content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      return headerModel;
    }else{
      return null;
    }
  }
}