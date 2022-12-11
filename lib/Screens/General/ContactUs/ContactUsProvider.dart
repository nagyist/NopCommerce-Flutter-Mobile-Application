/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Screens/General/ContactUs/Model/ContactUsModel.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/CacheDatabase.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';

import '../LocalResourceProvider.dart';

class ContactUsProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
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
  late GetContactUsModel getContactUsModel;
  late GetTopicBlockModel getTopicBlockModel;

  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController enquiryController = new TextEditingController();

  pageLoadData({required BuildContext context}) async
  {
    getContactUsData(context: context);
  }

  loadCacheData({required BuildContext context}) async
  {
    isPageLoader = true;
    isAPILoader = false;
    fullNameController.text="";
    emailController.text = "";
    subjectController.text="";
    enquiryController.text="";

    await getCacheContactUs();

    await getCachePrivacyTopicBlock();

    await getCacheHeader(context: context);

  }

  getCacheContactUs() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_CONTACTUS);
    if(res != null)
    {
      getContactUsModel = getContactUsModelFromJson(res);
      if(getContactUsModel.fullName != null)
      {
        fullNameController.text = getContactUsModel.fullName;
      }
      if(getContactUsModel.email != null)
      {
        emailController.text = getContactUsModel.email;
      }
      if(getContactUsModel.subject != null && getContactUsModel.subjectEnabled)
      {
        subjectController.text = getContactUsModel.subject;
      }
      if(getContactUsModel.enquiry != null)
      {
        enquiryController.text = getContactUsModel.enquiry;
      }
      notifyListeners();
      return getContactUsModel;
    }
    else{
      return null;
    }
  }

  getCachePrivacyTopicBlock() async {
    await storage.ready;
    String res = storage.getItem(StringConstants.CACHE_CONTACTUS_TOPIC_BLOCK);

    if(res != null)
    {
      getTopicBlockModel = getTopicBlockModelFromJson(res);
      isAPILoader = false;
      isPageLoader = false;
      notifyListeners();
      return getTopicBlockModel;
    }
    else{
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
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
      return headerModel;
    }else{
      return null;
    }
  }
  getContactUsData({required BuildContext context}) async
  {
    Response response = await CommonService().getContactUs(context: context);
    storage.setItem(StringConstants.CACHE_CONTACTUS, response.body);
    if(response.statusCode == 200)
    {
      getContactUsModel = getContactUsModelFromJson(response.body);
      if(getContactUsModel.fullName != null)
      {
       fullNameController.text = getContactUsModel.fullName;
      }
      if(getContactUsModel.email != null)
      {
        emailController.text = getContactUsModel.email;
      }
      if(getContactUsModel.subject != null && getContactUsModel.subjectEnabled)
      {
        subjectController.text = getContactUsModel.subject;
      }
      if(getContactUsModel.enquiry != null)
      {
        enquiryController.text = getContactUsModel.enquiry;
      }
      notifyListeners();
    }
    getTopicBlock(context: context);
  }

  getTopicBlock({required BuildContext context}) async
  {
    Response response = await CommonService().getTopicBlock(context: context,topic: "ContactUs");
    storage.setItem(StringConstants.CACHE_CONTACTUS_TOPIC_BLOCK, response.body);
    if(response.statusCode == 200)
    {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
      notifyListeners();
    }
    getHeaderData(context: context);
  }

  getHeaderData({required BuildContext context})async {
    Response response = await CommonService().getHeaderData(context: context);
    storage.setItem(StringConstants.CACHE_HEADER, response.body);
    if(response.statusCode == 200)
    {
      headerModel = headerInfoResponseModelFromJson(response.body);
      isPageLoader = false;
      if(headerModel.alertMessage != "")
      {
        DialogBoxWidget().confirmationDialogBox(context: context, title: LocalResourceProvider().getResourseByKey("common.notification"), content: headerModel.alertMessage, cancelText: "Cancel", submitText: "Ok", isCancelable: true, onSubmit: (){});
      }
      notifyListeners();
    }
    isAPILoader = false;
    isPageLoader = false;
    notifyListeners();
  }

  submitContactUsData({required BuildContext context}) async
  {
    isAPILoader = true;
    notifyListeners();

    final body = '{ '
          '"fullName": "${fullNameController.text.toString()}",'
          '"email": "${emailController.text.toString()}",'
          '"subject": "${subjectController.text.toString()}",'
          '"enquiry": "${enquiryController.text.toString()}"'
        '}';

    Response response = await CommonService().postContactUs(context: context, body: body);
    if(response.statusCode == 200)
    {
      isAPILoader = false;
      notifyListeners();
      Navigator.pop(context);
      FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey("contactus.yourEnquiryHasBeenSent"));

    }else if(response.statusCode == 400)
    {
      InvalidResponseModel invalidResponseModel = invalidResponseModelFromJson(response.body);
      FlushBarMessage().failedMessage(context: context, title: invalidResponseModel.errors.join("\n"));
    }

    isAPILoader = false;
    notifyListeners();
  }
}