/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'AttributeValueModel.dart';
import 'CustomProperties.dart';

class CheckoutAttribute {
  CheckoutAttribute({
    required this.name,
    required this.defaultValue,
    required this.textPrompt,
    required this.isRequired,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.allowedFileExtensions,
    required this.attributeControlType,
    required this.values,
    required this.id,
    required this.customProperties,
  });

  String name;
  dynamic defaultValue;
  dynamic textPrompt;
  bool isRequired;
  dynamic selectedDay;
  dynamic selectedMonth;
  dynamic selectedYear;
  List<dynamic> allowedFileExtensions;
  String attributeControlType;
  List<Value> values;
  int id;
  CustomProperties customProperties;

  factory CheckoutAttribute.fromJson(Map<String, dynamic> json) => CheckoutAttribute(
    name: json["Name"],
    defaultValue: json["DefaultValue"],
    textPrompt: json["TextPrompt"],
    isRequired: json["IsRequired"],
    selectedDay: json["SelectedDay"],
    selectedMonth: json["SelectedMonth"],
    selectedYear: json["SelectedYear"],
    allowedFileExtensions: List<dynamic>.from(json["AllowedFileExtensions"].map((x) => x)),
    attributeControlType: json["AttributeControlType"],
    values: List<Value>.from(json["Values"].map((x) => Value.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "DefaultValue": defaultValue,
    "TextPrompt": textPrompt,
    "IsRequired": isRequired,
    "SelectedDay": selectedDay,
    "SelectedMonth": selectedMonth,
    "SelectedYear": selectedYear,
    "AllowedFileExtensions": List<dynamic>.from(allowedFileExtensions.map((x) => x)),
    "AttributeControlType": attributeControlType,
    "Values": List<dynamic>.from(values.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}