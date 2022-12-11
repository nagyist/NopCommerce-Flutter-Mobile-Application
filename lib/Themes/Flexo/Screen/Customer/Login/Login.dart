/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckout.dart';
import 'package:nopcommerce/Screens/Checkout/OnePageCheckout.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/Enum/UserRegistrationType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Screens/Customer/ForgotPassword/ForgotPassword.dart';
import 'package:nopcommerce/Screens/Customer/Register/Register.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/Login/LoginProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FormErrorsWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class FlexoLogin extends StatelessWidget {

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var loginProvider = context.watch<LoginProvider>();


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("PageTitle.Login"),backButton: loginProvider.loginType != LoginTypeAttribute.Login),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: loginProvider.isPageLoader ? Loaders.pageLoader() :
        StatefulBuilder(builder: (context, setState){
          return Container(
            width: FlexoValues.deviceWidth,
            height:FlexoValues.deviceHeight,
            child: Form(
              key: form,
              child: Column(
                children: [

                  loginProvider.isApiLoader ? Container(child: LinearProgressIndicator(color: FlexoColorConstants.LINEAR_LOADER_COLOR,),) : Container(),

                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: FlexoValues.deviceHeight * 0.08,),

                            Container(
                              width: FlexoValues.deviceWidth * 0.5,
                              child: Image.asset(FlexoAssetsPath.logo),
                            ),

                            SizedBox(height:FlexoValues.heightSpace5Px,),

                            SizedBox(
                              width: FlexoValues.loginControlsWidth,
                              child: FormErrorWidget(errors: loginProvider.errors),
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px,),

                            TextFieldWidget(
                              showRequiredIcon: false,
                              width: FlexoValues.loginControlsWidth,
                              controller: loginProvider.emailController,
                              heading: loginProvider.getLoginModel.usernamesEnabled ? localResourceProvider.getResourseByKey("account.login.fields.username") : localResourceProvider.getResourseByKey("account.login.fields.email"),
                              errorMsg: localResourceProvider.getResourseByKey("account.login.fields.email.required"),
                              required: true,
                              hintText: loginProvider.getLoginModel.usernamesEnabled ? localResourceProvider.getResourseByKey("account.login.fields.username") : localResourceProvider.getResourseByKey("account.login.fields.email"),
                              icon: Ionicons.person_outline,
                              keyBoardType: TextInputType.emailAddress,
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px,),

                            TextFieldWidget(
                              textFieldType: TextFieldType.Password,
                              width: FlexoValues.loginControlsWidth,
                              controller: loginProvider.passwordController,
                              heading: localResourceProvider.getResourseByKey("account.login.fields.password"),
                              required: false,
                              showRequiredIcon: false,
                              hintText: localResourceProvider.getResourseByKey("account.login.fields.password"),
                              icon: Ionicons.lock_open_outline,
                              keyBoardType: TextInputType.emailAddress,
                            ),

                            SizedBox(height: FlexoValues.heightSpace3Px,),

                            ButtonWidget().getButton(
                                text: localResourceProvider.getResourseByKey("account.login.loginButton").toString().toUpperCase(),
                                width: FlexoValues.loginControlsWidth,
                                isApiLoad: false,
                                onClick: () async
                                {
                                  KeyboardUtil.hideKeyboard(context);
                                  if(form.currentState!.validate()){
                                    loginProvider.loginClick(context: context);
                                  }
                                }),

                            SizedBox(height: FlexoValues.heightSpace3Px,),

                            GestureDetector(
                              child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("account.login.forgotPassword")),
                              onTap: ()
                              {
                                Navigator.push(context, PageTransition(type: selectedTransition, child: ForgotPassword()));
                              },
                            ),

                            SizedBox(height: FlexoValues.heightSpace3Px,),

                            loginProvider.getLoginModel.registrationType == UserRegistrationType.Disabled ?
                            Container(
                              width: FlexoValues.loginControlsWidth,
                              child: Column(
                                children: [
                                  Container(
                                    child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("Account.Register.Result.Disabled"),),
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,)
                                ],
                              ),
                            ) :
                            loginProvider.loginType == LoginTypeAttribute.Checkout ?
                            Container(
                              width: FlexoValues.loginControlsWidth,
                              child: Column(
                                children: [
                                  Container(
                                    width: FlexoValues.controlsWidth,
                                    child: RichText(
                                      text: HTML.toTextSpan(
                                          context,
                                          '${loginProvider.getTopicBlockModel.body.replaceAll("<li>", "\n• ").replaceAll("</li>", "")}',
                                          defaultTextStyle: TextStyle(
                                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                            fontSize: 15,
                                          ),
                                          linksCallback: (url)
                                          {
                                            launch(url!);
                                          }
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),

                                  ButtonWidget().getBorderButton(
                                      text: localResourceProvider.getResourseByKey("account.login.checkoutAsGuest").toString().toUpperCase(),
                                      width: FlexoValues.loginControlsWidth,
                                      isApiLoad: context.watch<LoginProvider>().isApiLoader,
                                      onClick: () async
                                      {
                                        if(localResourceProvider.getSettingByName("orderSettings.onePageCheckoutEnabled")=='True'){
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: OnePageCheckout()));
                                        }else{
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckout()));
                                        }
                                      }),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),

                                  ButtonWidget().getBorderButton(
                                      text: localResourceProvider.getResourseByKey("account.register").toString().toUpperCase(),
                                      width: FlexoValues.loginControlsWidth,
                                      isApiLoad: false,
                                      onClick: () async
                                      {
                                        Navigator.push(context, PageTransition(type: selectedTransition, child: Register(loginType: LoginTypeAttribute.Checkout,)));
                                      }),
                                ],
                              ),
                            ) :
                            Container(
                              child: Column(
                                children: [
                                  ButtonWidget().getBorderButton(
                                      text: localResourceProvider.getResourseByKey("account.register").toString().toUpperCase(),
                                      width: FlexoValues.loginControlsWidth,
                                      isApiLoad: false,
                                      onClick: () async
                                      {
                                        Navigator.push(context, PageTransition(type: selectedTransition, child: Register(loginType: LoginTypeAttribute.Login)));
                                      }),

                                  SizedBox(height: FlexoValues.widthSpace4Px,),

                                  ButtonWidget().getBorderButton(
                                      text: loginProvider.preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN) == null || loginProvider.preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN) == false ?
                                      localResourceProvider.getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.continueWithoutLogin").toString().toUpperCase() :localResourceProvider.getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.goToHomepage").toString().toUpperCase(),
                                      width: FlexoValues.loginControlsWidth,
                                      isApiLoad: context.watch<LoginProvider>().isApiLoader,
                                      onClick: () async
                                      {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        if(preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN) == null || preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN) == false) {
                                          preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, true);
                                        }
                                        navigatePage(context);
                                      }),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace4Px,),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ),
    );
  }
  navigatePage(BuildContext context) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
  }
}
