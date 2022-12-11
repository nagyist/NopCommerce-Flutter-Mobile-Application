/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Screens/Customer/Login/Models/GetLoginResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/Login/Models/LoginResponseModel.dart';
import 'package:nopcommerce/Models/GetGuestToken.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Services/CustomerService.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/PingModel.dart';

class LoginProvider extends ChangeNotifier {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String token="";
  String currentVersion="";
  bool isApiLoader = false;
  bool isPageLoader = true;
  List<String> errors = [];
  late GetLoginResponseModel getLoginModel;
  late SharedPreferences preferences;
  int loginType=0;
  late GetTopicBlockModel getTopicBlockModel;


  pageLoad({required BuildContext context,required int loginType}) async
  {
    token="";
    isApiLoader = false;
    isPageLoader = true;
    errors.clear();
    this.loginType = loginType;
    preferences = await SharedPreferences.getInstance();
    print("loginType $loginType");
    notifyListeners();
    if(loginType != LoginTypeAttribute.Login)
    {
      getTopicBlock(context: context);
    }else{
      guestToken(context: context);
    }

  }

  guestToken({required BuildContext context}) async
  {
    Response response = await CommonService().getGuestToken(context: context);

    if (response.statusCode == 200) {
      GetGuestToken guestTokenModel = getGuestTokenFromJson(response.body);
      token = guestTokenModel.accessToken;
      preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN,token);
      getLogin(context: context);
    }
  }

  getLogin({required BuildContext context}) async
  {
    Response response = await CustomerService().getLoginData(context: context);
    if (response.statusCode == 200) {
      getLoginModel = getLoginResponseModelFromJson(response.body);

      emailController.clear();
      passwordController.clear();

      isPageLoader = false;
      notifyListeners();
    }
  }

  getTopicBlock({required BuildContext context}) async
  {
    Response response = await CommonService().getTopicBlock(context: context,topic: 'CheckoutAsGuestOrRegister');
    if (response.statusCode == 200) {
      getTopicBlockModel = getTopicBlockModelFromJson(response.body);
      notifyListeners();

      getLogin(context: context);
    }
  }

  loginClick({required BuildContext context}) async
  {
      errors.clear();
      isApiLoader = true;
      notifyListeners();

      final body='{ '
          '"usernameOrEmail": "${emailController.text.trim().toString()}",'
          '"password": "${passwordController.text.trim().toString()}"'
          '}';

      Response response = await CustomerService().userLogin(context: context, body: body);

      if(response.statusCode == 200){

        LoginResponseModel loginResponseModel = loginResponseModelFromJson(response.body);

        SharedPreferences preferences= await SharedPreferences.getInstance();
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN, loginResponseModel.accessToken);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_REFRESH_TOKEN, loginResponseModel.refreshToken);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN_EXPIRATION_DATE, loginResponseModel.refreshTokenExpiration.toString());
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, true);
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);

        navigatePage(context: context);

      }else if(response.statusCode == 400)
      {
        InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
        for(var er in errors.errors)
        {
          addError(error: er);
          notifyListeners();
        }
      }
      isApiLoader = false;
      notifyListeners();

  }

  void navigatePage({required BuildContext context})
  {
    Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));
  }

  void addError({required String error}) {
    if (!errors.contains(error))
    {
      errors.add(error);
      notifyListeners();
    }
  }

}