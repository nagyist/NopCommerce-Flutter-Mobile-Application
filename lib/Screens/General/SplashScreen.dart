/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/ThemeAttributes.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/General/SplashScreen/SplashScreen.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/PingModel.dart';
import '../../Services/CommonService.dart';
import '../../Utils/Strings.dart';
import 'AppSettings/AppSettings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String currentVersion="";

  @override
  void initState() {
    super.initState();

    getPing();

  }

  getPing() async
  {
    SharedPreferences preferences= await SharedPreferences.getInstance();

    Response response = await CommonService().getPing(context: context);

    if (response.statusCode == 200) {
      PingModel pingModel = pingModelFromJson(response.body);
      currentVersion = pingModel.currentVersion;
      preferences.setString(SharedPreferencesValues.SHARED_PREFERENCE_CURRENT_VERSION,currentVersion);
      inItFunction();
    }else {
      FlushBarMessage().failedMessage(context: context, title: StringConstants.ERROR_MESSAGE_500);
    }
  }

  inItFunction() async
  {
    SharedPreferences preferences= await SharedPreferences.getInstance();

    if(preferences.getInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID) == null)
    {
      preferences.setInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID, 1);
    }

   // Timer(const Duration(seconds: 3), () {

      if(preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOAD_LOCAL_DATA) == null || preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOAD_LOCAL_DATA) != true)
      {
        Navigator.push(context, PageTransition(type: selectedTransition, child: AppSettings()));

      }else{
        if(preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN) != null && preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOGIN) == true|| preferences.getBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_WITHOUT_LOGIN) == true)
        {
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));

        }else {
          Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login,)));
        }
      }

  //  });
  }




  @override
  Widget build(BuildContext context) {

    if(selectedTheme == ThemeAttributes.Flexo)
    {
      return const FlexoSplashScreen();

    }else{
      return const FlexoSplashScreen();
    }
  }
}
