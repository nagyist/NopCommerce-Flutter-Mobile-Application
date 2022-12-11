/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nopcommerce/Models/RefreshTokenResponseModel.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  /// url = API url to call, isWithoutToken = true if guest token is being used.
  httpGet({required BuildContext context, required String url,required bool isWithoutToken}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    if (isWithoutToken) {
      header = {
        "Content-Type": "application/json",
        "X-API-KEY": APIConstants.STORE_KEY
      };
    }else{
      header = {
        "Content-Type": "application/json",
        "X-API-KEY": APIConstants.STORE_KEY,
        'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
      };
    }

    var response = await http.get(Uri.parse(url), headers: header);
    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpGet(context: context, url: url, isWithoutToken: isWithoutToken);
      }
       return response;
    }else{
       return response;
    }
  }

  httpPost({required BuildContext context, required String url,required var body}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    header = {
      "Content-Type": "application/json",
      "X-API-KEY": APIConstants.STORE_KEY,
      'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
    };

    var response = await http.post(Uri.parse(url), headers: header,body: body);
    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpPost(context: context, url: url, body: body);
      }
      return response;
    }else{
      return response;
    }
  }

  httpPut({required BuildContext context, required String url,required var body}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    header = {
      "Content-Type": "application/json",
      "X-API-KEY": APIConstants.STORE_KEY,
      'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
    };

    var response = await http.put(Uri.parse(url), headers: header,body: body);
    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpPut(context: context, url: url, body: body);
      }
      return response;
    }else{
      return response;
    }
  }

  httpDelete({required BuildContext context, required String url,required var body}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    header = {
      "Content-Type": "application/json",
      "X-API-KEY": APIConstants.STORE_KEY,
      'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
    };

    var response = await http.delete(Uri.parse(url), headers: header,body: body);

    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpDelete(context: context, url: url, body: body);
      }
      return response;
    }else{
      return response;
    }
  }

  httpDeleteWithoutBody({required BuildContext context, required String url}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    header = {
      "Content-Type": "application/json",
      "X-API-KEY": APIConstants.STORE_KEY,
      'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
    };

    var response = await http.delete(Uri.parse(url), headers: header);

    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpDeleteWithoutBody(context: context, url: url);
      }
      return response;
    }else{
      return response;
    }
  }

  httpPostWithoutBody({required BuildContext context, required String url}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    url = APIConstants.BASE_URL + url;
    Map<String, String> header;

    header = {
      "Content-Type": "application/json",
      "X-API-KEY": APIConstants.STORE_KEY,
      'Authorization': 'Bearer ' + preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN)!
    };
    var response = await http.post(Uri.parse(url), headers: header);
    if(response.statusCode == 401)
    {
      bool res = await generateRefreshToken(context: context);
      if(res)
      {
        this.httpPostWithoutBody(context: context, url: url);
      }
      return response;
    }else{
      return response;
    }
  }

  generateRefreshToken({required BuildContext context}) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? oldTime = preferences.getString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN_EXPIRATION_DATE);
    DateTime refreshTime = DateTime.parse(oldTime!);
    DateTime currentTime = DateTime.now();

    if(currentTime.isAfter(refreshTime)){

      final body = '{ '
        '"refreshToken": "${preferences.getString("refreshtoken")}",'
      '}';
      Response response = await httpPost(context: context, url: APIConstants.REFRESH_TOKEN_API, body: body);
      if(response.statusCode == 200) {
        RefreshTokenResponseModel refreshTokenResponseModel = refreshTokenResponseModelFromJson(response.body);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN, refreshTokenResponseModel.accessToken);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_REFRESH_TOKEN, refreshTokenResponseModel.refreshToken);
        preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_TOKEN_EXPIRATION_DATE, refreshTokenResponseModel.refreshTokenExpiration.toString());

        return true;
      }else{
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, false);
        preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);

        Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login,)));
        return false;
      }
    }else{
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN, false);
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN, false);

      Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login,)));
      return false;
    }
  }
}