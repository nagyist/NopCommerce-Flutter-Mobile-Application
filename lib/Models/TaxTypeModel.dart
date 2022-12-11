/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

TaxTypeModel taxTypeModelFromJson(String str) => TaxTypeModel.fromJson(json.decode(str));

String taxTypeModelToJson(TaxTypeModel data) => json.encode(data.toJson());

class TaxTypeModel {
  TaxTypeModel({
    required this.availableTaxTypes,
    required this.currentTaxType,
  });

  List<AvailableTaxType> availableTaxTypes;
  String currentTaxType;

  factory TaxTypeModel.fromJson(Map<String, dynamic> json) => TaxTypeModel(
    availableTaxTypes: List<AvailableTaxType>.from(json["AvailableTaxTypes"].map((x) => AvailableTaxType.fromJson(x))),
    currentTaxType: json["CurrentTaxType"],
  );

  Map<String, dynamic> toJson() => {
    "AvailableTaxTypes": List<dynamic>.from(availableTaxTypes.map((x) => x.toJson())),
    "CurrentTaxType": currentTaxType,
  };
}

class AvailableTaxType {
  AvailableTaxType({
    required this.name,
    required this.displayText,
    required this.id,
    required this.customProperties,
  });

  String name;
  String displayText;
  int id;
  CustomProperties customProperties;

  factory AvailableTaxType.fromJson(Map<String, dynamic> json) => AvailableTaxType(
    name: json["Name"],
    displayText: json["DisplayText"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "DisplayText": displayText,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}