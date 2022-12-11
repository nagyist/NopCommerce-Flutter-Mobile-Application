/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetLanguagesModel getLanguagesModelFromJson(String str) => GetLanguagesModel.fromJson(json.decode(str));

String getLanguagesModelToJson(GetLanguagesModel data) => json.encode(data.toJson());

class GetLanguagesModel {
  GetLanguagesModel({
    required this.availableLanguages,
    required this.currentLanguageId,
    required this.useImages,
    required this.customProperties,
  });

  List<AvailableLanguage> availableLanguages;
  int currentLanguageId;
  bool useImages;
  CustomProperties customProperties;

  factory GetLanguagesModel.fromJson(Map<String, dynamic> json) => GetLanguagesModel(
    availableLanguages: List<AvailableLanguage>.from(json["AvailableLanguages"].map((x) => AvailableLanguage.fromJson(x))),
    currentLanguageId: json["CurrentLanguageId"],
    useImages: json["UseImages"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "AvailableLanguages": List<dynamic>.from(availableLanguages.map((x) => x.toJson())),
    "CurrentLanguageId": currentLanguageId,
    "UseImages": useImages,
    "CustomProperties": customProperties.toJson(),
  };
}

class AvailableLanguage {
  AvailableLanguage({
    required this.name,
    required this.flagImageFileName,
    required this.id,
    required this.customProperties,
  });

  String name;
  String flagImageFileName;
  int id;
  CustomProperties customProperties;

  factory AvailableLanguage.fromJson(Map<String, dynamic> json) => AvailableLanguage(
    name: json["Name"],
    flagImageFileName: json["FlagImageFileName"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "FlagImageFileName": flagImageFileName,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}