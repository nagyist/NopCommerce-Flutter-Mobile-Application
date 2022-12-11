/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



import 'CustomProperties.dart';
import 'CustomerAttributeValueModel.dart';

class CustomerAttributeModel {
  CustomerAttributeModel({
    required this.name,
    required this.isRequired,
    required this.defaultValue,
    required this.attributeControlType,
    required this.values,
    required this.id,
    required this.customProperties,
  });

  String name;
  bool isRequired;
  dynamic defaultValue;
  String attributeControlType;
  List<CustomerAttributeValueModel> values;
  int id;
  CustomProperties customProperties;

  factory CustomerAttributeModel.fromJson(Map<String, dynamic> json) => CustomerAttributeModel(
    name: json["Name"],
    isRequired: json["IsRequired"],
    defaultValue: json["DefaultValue"] == null ? null : json["DefaultValue"],
    attributeControlType: json["AttributeControlType"],
    values: List<CustomerAttributeValueModel>.from(json["Values"].map((x) => CustomerAttributeValueModel.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "IsRequired": isRequired,
    "DefaultValue": defaultValue == null ? null : defaultValue,
    "AttributeControlType": attributeControlType,
    "Values": List<dynamic>.from(values.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}