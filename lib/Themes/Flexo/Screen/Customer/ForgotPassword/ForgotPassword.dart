/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/ForgotPassword/ForgotPasswordProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FormErrorsWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class FlexoForgotPassWord extends StatelessWidget {

  static GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var forgotPasswordProvider = context.watch<ForgotPasswordProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ? "" :localResourceProvider.getResourseByKey("account.passwordRecovery") ),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      body: forgotPasswordProvider.isPageLoader ? Loaders.pageLoader() :  Column(
        children: [
          forgotPasswordProvider.isAPILoader ? Loaders.apiLoader() : Container(),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Form(
                      key: form,
                      child: Container(
                        width:FlexoValues.deviceWidth,
                        child: Column(
                          children: [

                            SizedBox(height:FlexoValues.deviceHeight * 0.08,),

                            Container(
                              width:FlexoValues.deviceWidth * 0.5,
                              child: Image.asset(FlexoAssetsPath.logo),
                            ),

                            SizedBox(height: FlexoValues.heightSpace5Px,),

                            SizedBox(
                              width: FlexoValues.loginControlsWidth,
                              child: FormErrorWidget(errors: forgotPasswordProvider.errors),
                            ),

                            SizedBox(height:FlexoValues.heightSpace3Px,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth * 0.075),
                              child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey('account.passwordRecovery.tooltip')),
                            ),

                            SizedBox(height:FlexoValues.heightSpace2Px,),

                            TextFieldWidget(
                              width: FlexoValues.loginControlsWidth,
                              controller: ForgotPasswordProvider.emailAddress,
                              errorMsg:localResourceProvider.getResourseByKey('account.passwordRecovery.email.required'),
                              required: true,
                              hintText: localResourceProvider.getResourseByKey('account.passwordRecovery.email'),
                              icon: Ionicons.mail_outline,
                            ),

                            SizedBox(height:FlexoValues.heightSpace2Px,),

                            ButtonWidget().getButton(text:localResourceProvider.getResourseByKey('account.passwordRecovery.changePasswordButton').toString().toUpperCase(),
                                width: FlexoValues.loginControlsWidth,
                                onClick: ()async{
                                  KeyboardUtil.hideKeyboard(context);
                                  if(await CheckConnectivity().checkInternet(context)){
                                    if(form.currentState!.validate())
                                    {
                                      forgotPasswordProvider.forgotPasswordClick(context: context);
                                    }
                                  }
                                }, isApiLoad:forgotPasswordProvider.isAPILoader)
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




