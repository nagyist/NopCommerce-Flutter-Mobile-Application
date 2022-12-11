/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/General/ContactUs/ContactUsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/TopicBlock/TopicBlockComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class FlexoContactUs extends StatelessWidget {
  final GlobalKey<FormState> form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var contactUsProvider = context.watch<ContactUsProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.contactus"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: contactUsProvider.headerModel,headerLoader: contactUsProvider.isPageLoader),
        body: contactUsProvider.isPageLoader || localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :
        Column(
          children: [
            contactUsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            contactUsProvider.getContactUsModel.successfullySent?
            Container(
              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().contentText16(text: contactUsProvider.getContactUsModel.result,),
                  ),
                ],
              ),
            ) :
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      TopicBlockComponent(getTopicBlockModel: contactUsProvider.getTopicBlockModel),

                      Form(
                        key: form ,
                        child: Container(
                          width: FlexoValues.deviceWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: FlexoValues.heightSpace1Px,),

                              TextFieldWidget(
                                width: FlexoValues.controlsWidth,
                                icon: Ionicons.person_outline,
                                controller: contactUsProvider.fullNameController,
                                keyBoardType: TextInputType.name,
                                heading: localResourceProvider.getResourseByKey("contactus.fullName"),
                                hintText: localResourceProvider.getResourseByKey("contactus.fullName.hint"),
                                required: true,
                                errorMsg: localResourceProvider.getResourseByKey("contactus.fullName.required"),
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              TextFieldWidget(
                                textFieldType: TextFieldType.Email,
                                width: FlexoValues.controlsWidth,
                                icon: Ionicons.mail_outline,
                                controller: contactUsProvider.emailController,
                                keyBoardType: TextInputType.emailAddress,
                                heading: localResourceProvider.getResourseByKey("contactus.email"),
                                hintText: localResourceProvider.getResourseByKey("contactus.email.hint"),
                                required: true,
                                errorMsgForEmail: localResourceProvider.getResourseByKey("common.wrongEmail"),
                                errorMsg: localResourceProvider.getResourseByKey("contactus.email.required"),
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              contactUsProvider.getContactUsModel.subjectEnabled?
                              Container(
                                width: FlexoValues.controlsWidth,
                                child: Column(
                                  children: [

                                    TextFieldWidget(
                                      width: FlexoValues.controlsWidth,
                                      icon: Ionicons.chatbox_outline,
                                      controller: contactUsProvider.subjectController,
                                      keyBoardType: TextInputType.name,
                                      heading: localResourceProvider.getResourseByKey("contactus.subject"),
                                      hintText: localResourceProvider.getResourseByKey("contactus.subject.hint"),
                                      required: true,
                                      errorMsg: localResourceProvider.getResourseByKey("contactus.subject.required"),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px,),
                                  ],
                                ),
                              ):Container(),

                              TextFieldWidget(
                                width: FlexoValues.controlsWidth,
                                controller: contactUsProvider.enquiryController,
                                maxLine: 5,
                                keyBoardType: TextInputType.name,
                                heading: localResourceProvider.getResourseByKey("contactus.enquiry"),
                                hintText: localResourceProvider.getResourseByKey("contactus.enquiry.hint"),
                                required: true,
                                errorMsg: localResourceProvider.getResourseByKey("contactus.enquiry.required"),
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("contactus.button").toString().toUpperCase(),
                                  width: FlexoValues.controlsWidth,
                                  onClick: () async
                                  {
                                    KeyboardUtil.hideKeyboard(context);
                                    if(await CheckConnectivity().checkInternet(context))
                                    {
                                      if(form.currentState!.validate()){
                                        contactUsProvider.submitContactUsData(context: context);
                                      }
                                    }
                                  },
                                  isApiLoad: false
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
