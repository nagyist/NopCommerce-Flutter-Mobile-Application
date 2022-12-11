/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Common/FileConfig.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/GdprTools/Models/DeleteGdprToolsResponseModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/GdprToolService.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class GdprToolsProvider extends ChangeNotifier {

  bool isPageLoader = false;
  bool isAPILoader = false;
  bool isDownloadLoader=false;
  late Directory? downloadsDirectory;
  late DeleteGdprToolsResponseModel deleteGdprToolsResponseModel;
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
     isDownloadLoader=false;
     isPageLoader = true;
     isAPILoader = true;
     getHeaderData(context: context);
     notifyListeners();
  }

  getHeaderData({required BuildContext context}) async {
    Response response = await CommonService().getHeaderData(context: context);
    if (response.statusCode == 200) {
      headerModel = headerInfoResponseModelFromJson(response.body);
      if (headerModel.alertMessage != "") {
        DialogBoxWidget().confirmationDialogBox(context: context,
            title: "Notification",
            content: headerModel.alertMessage,
            cancelText: "Cancel",
            submitText: "Ok",
            isCancelable: true,
            onSubmit: () {});
      }
    }
    isPageLoader = false;
    isAPILoader=false;
    notifyListeners();
  }

  exportButtonClickEvent({required BuildContext context}) async
  {
    bool permissionGranted = await FileConfig().permissionCheck(context: context, messageType: StringConstants.STORAGE_PERMISSION_MESSAGE);
    if(permissionGranted)
    {
      isAPILoader = true;
      notifyListeners();
      Response response = await GdprToolService().exportGdpr(context: context);
      if(response.statusCode == 200){
        String base64 = base64Encode(response.bodyBytes);
        var fileType =response.headers["content-disposition"].toString().split(";");
        var separateName = fileType[1].split("=");
        var fileName = separateName[1].split(".");

        FileConfig().saveFile(context: context, base64: base64, fileName: fileName[0], fileType: fileName[1]);
        isAPILoader = false;
      }
    }
    notifyListeners();
  }

  deleteButtonClickEvent({required BuildContext context})async
  {
    isAPILoader = true;
    notifyListeners();
    Response response=await GdprToolService().deleteGdprTool(context: context);
    if (response.statusCode == 200) {
      deleteGdprToolsResponseModel=deleteGdprToolsResponseModelFromJson(response.body);
      isAPILoader = false;
      FlushBarMessage().successMessage(context: context, title: deleteGdprToolsResponseModel.result);
    }
    notifyListeners();
  }

}