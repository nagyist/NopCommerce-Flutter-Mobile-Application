/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Enum/TopicType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import '../LocalResourceProvider.dart';

class TopicBlockDetailsProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
  String topicTitle = "";
  String topicBody = "";
  String name="";
  String seName="";
  int topicId=0;
  String topicType="";
  late GetTopicBlockModel getTopicBlockModel;
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

  pageLoadData({required BuildContext context, required String topicTitle, required String topicBody}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    this.topicTitle = topicTitle;
    this.topicBody = topicBody;
    notifyListeners();

    getHeaderData(context: context);
  }

  pageLoadDataById({required BuildContext context, required String name, required String seName, required int topicId, required String topicType}) async
  {
    isPageLoader = true;
    this.name = name;
    this.seName = seName;
    this.topicId = topicId;
    this.topicType = topicType;
    notifyListeners();

    getTopicBlocData(context: context);
  }
  
  getTopicBlocData({required BuildContext context}) async
  {
    Response response;
    if(topicType == TopicType.Id)
    {
      response = await CommonService().getTopicBlockById(context: context, topicId: topicId);
    }else{
      response = await CommonService().getTopicBlock(context: context, topic: seName);
    }
    if(response.statusCode == 200)
    {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
      topicTitle = getTopicBlockModel.title;
      topicBody = getTopicBlockModel.body;
      notifyListeners();
    }
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    if(response.statusCode == 200)
    {
      storage.setItem(StringConstants.CACHE_HEADER, response.body);
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }else{
      isPageLoader = false;
      storage.setItem(StringConstants.CACHE_HEADER, null);
      notifyListeners();
    }
    notifyListeners();
  }

}