/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/ResourseModel.dart';
import 'package:nopcommerce/SQLiteDatabase/DBHelper.dart';
import 'package:nopcommerce/Utils/SharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/SettingsResponseModel.dart';

class LocalResourceProvider extends ChangeNotifier {

  bool isLocalDataLoad = false;
  static List<SettingModel> settingsList=[];
  static List<ResourceModel> resourseList = [];

  loadLocalResources() async
  {
    isLocalDataLoad = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    resourseList.clear();
    resourseList = await DBHelper().getResourseLanguageIdData(languageId: preferences.getInt(SharedPreferencesValues.SHARED_PREFERENCE_LANGUAGE_ID)!);
    loadLocalSettings();
  }

  loadLocalSettings() async
  {
    settingsList.clear();
    settingsList = await DBHelper().getAllSettingsData();
    isLocalDataLoad = false;
    notifyListeners();
  }

  getResourseByKey(String key)
  {
    List<ResourceModel> list = resourseList.where((element) => element.key.toLowerCase() == key.toLowerCase()).toList();
    if(list.isEmpty)
    {
      return key;
    }else {
      return list[0].value;
    }
  }

  getSettingByName(String name) {

    List<SettingModel> list = settingsList.where((element) => element.name.toLowerCase() == name.toLowerCase()).toList();
    if (list.isEmpty) {
      return name;
    } else {
      return list[0].value;
    }
  }
}