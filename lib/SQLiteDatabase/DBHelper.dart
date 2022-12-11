/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Screens/General/Models/SettingsResponseModel.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/Models/CompareProductModel.dart';
import 'package:nopcommerce/Models/ResourseModel.dart';
import 'package:nopcommerce/Screens/General/Models/LocalStringResourceModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'nopcommerce.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE LocalStringResourse (Id INTEGER PRIMARY KEY AUTOINCREMENT, LanguageId INTEGER, ResourceName TEXT, ResourceValue TEXT)');
    await db.execute('CREATE TABLE AllSettings (Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Value TEXT)');
    await db.execute('CREATE TABLE CompareProducts (Id INTEGER PRIMARY KEY AUTOINCREMENT, ProductId INTEGER)');
  }

  Future<LocalStringResourceModel> addResourse({required LocalStringResourceModel model}) async {
    final Database db = await initDatabase();
    model.languageId = await db.insert('LocalStringResourse', model.toJson());
    return model;
  }

  Future<String> getResourseIdData({required int languageId,required String key}) async {

    final Database db = await initDatabase();
    List<Map> maps = await db.rawQuery('SELECT * FROM LocalStringResourse WHERE LanguageId=$languageId and ResourceName="'+key+'"');
    LocalStringResourceModel model = new LocalStringResourceModel(languageId: languageId, resourceName: key, resourceValue: key);
    String value="";
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        model = LocalStringResourceModel.fromJson(maps[i]);
        value = model.resourceValue;
      }
    }else{
      model = new LocalStringResourceModel(languageId: languageId, resourceName: key, resourceValue: key);
      value = model.resourceValue;
    }
    return value;
  }

  Future<List<ResourceModel>> getResourseLanguageIdData({required int languageId}) async {

    final Database db = await initDatabase();
    List<Map> maps = await db.rawQuery('SELECT * FROM LocalStringResourse WHERE LanguageId=$languageId');
    LocalStringResourceModel localModel = new LocalStringResourceModel(languageId: languageId, resourceName: "", resourceValue: "");
    List<ResourceModel> model=[];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        localModel = LocalStringResourceModel.fromJson(maps[i]);
        model.add(new ResourceModel(localModel.resourceName, localModel.resourceValue));
      }
    }
    return model;
  }

  Future<int> deleteAll() async {
    final Database db = await initDatabase();
    var dbClient =  db;
    return await dbClient.delete('LocalStringResourse');
  }

  Future<SettingModel> addAllSetting({required SettingModel model}) async {
    final Database db = await initDatabase();
    await db.insert('AllSettings', model.toJson());
    return model;
  }

  Future<int> deleteSettings() async {
    final Database db = await initDatabase();
    var dbClient = db;
    return await dbClient.delete('AllSettings');
  }

  Future<String> getSettingByName({required String name}) async {

    final Database db = await initDatabase();
    List<Map> maps = await db.rawQuery('SELECT * FROM AllSettings WHERE Name="$name"');
    SettingModel localModel = new SettingModel(name: name,value: "");
    String value="";
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        localModel = SettingModel.fromJson(maps[i]);
        value = localModel.value;
      }
    }
    return value;
  }

  Future<List<SettingModel>> getAllSettingsData() async {

    final Database db = await initDatabase();
    List<Map> maps = await db.rawQuery('SELECT * FROM AllSettings');
    List<SettingModel> model=[];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        model.add(SettingModel.fromJson(maps[i]));
      }
    }
    return model;
  }

  //Compare Products
  Future<CompareProductResourseModel> addCompareProduct({required CompareProductResourseModel model}) async {
    final Database db = await initDatabase();
    model.productId = await db.insert('CompareProducts', model.toJson());
    return model;
  }

  Future<List<CompareProductResourseModel>> getCompareProductsData() async {
    final Database db = await initDatabase();
    List<Map> maps = await db.rawQuery('SELECT ProductId FROM CompareProducts Group By ProductId');
    CompareProductResourseModel localModel = new CompareProductResourseModel(productId: 0);
    List<CompareProductResourseModel> model=[];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        localModel = CompareProductResourseModel.fromJson(maps[i]);
        model.add(new CompareProductResourseModel(productId: localModel.productId));
      }
    }
    return model;
  }

  Future<int> deleteAllCompareProductId() async {
    final Database db = await initDatabase();
    var dbClient = db;
    return await dbClient.delete('CompareProducts');
  }

  Future<int> deleteByProductId({required int productId}) async {

    final Database db = await initDatabase();
    return db.delete('CompareProducts',where: 'ProductId="$productId"');
  }
}