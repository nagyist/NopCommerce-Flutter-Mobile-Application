/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Screens/General/Models/SettingsResponseModel.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Screens/General/Models/LocalStringResourceModel.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/SQFliteDatabase.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier{
  bool isLoadSettings = true;

  inItMethod({required BuildContext context,required StateSetter setState}) async
  {
    if(await CheckConnectivity().checkInternet(context)){
      getAllSettingsData(context: context,setState: setState);
      getAllLocalResourseLanguages(context: context,setState: setState);
    }
  }

  void getAllLocalResourseLanguages({required BuildContext context,required StateSetter setState}) async
  {
    SQFLiteDatabase().dbHelper.deleteAll();
    Response response = await CommonService().getLocalResource(context: context);
    if(response.statusCode == 200)
    {
      List<LocalStringResourceModel> localStringResourseModel = localStringResourseModelFromJson(response.body);
      for(var item in localStringResourseModel)
      {
        await SQFLiteDatabase().dbHelper.addResourse(model: item);
      }

      SharedPreferences preferences= await SharedPreferences.getInstance();
      preferences.setBool(SharedPreferencesValues.SHARED_PREFERENCE_IS_LOAD_LOCAL_DATA, true);
      setState((){
        isLoadSettings = false;
      });

      navigateLoginScreen(context: context);

    }

    notifyListeners();

  }

  navigateLoginScreen({required BuildContext context})
  {
    Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Login,)));
  }

  void getAllSettingsData({required BuildContext context,required StateSetter setState}) async
  {
    SQFLiteDatabase().dbHelper.deleteSettings();

    Response response = await CommonService().getSettings(context: context);
    if(response.statusCode == 200)
    {
      List<SettingModel> allSettings = allSettingModelFromJson(response.body);
      for(var item in allSettings)
      {
        await SQFLiteDatabase().dbHelper.addAllSetting(model: item);
      }
    }


  }
  Future<bool> handleWillPop(BuildContext context) async {
    FlushBarMessage().warningMessage(context: context,title: "Please wait while downloading data");
    return false;
  }
}