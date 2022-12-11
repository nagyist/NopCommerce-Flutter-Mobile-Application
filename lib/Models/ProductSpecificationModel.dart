/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'CustomProperties.dart';

class ProductSpecificationModel {
  ProductSpecificationModel({
    required this.groups,
    required this.customProperties,
  });

  List<Group> groups;
  CustomProperties customProperties;

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) => ProductSpecificationModel(
    groups: List<Group>.from(json["Groups"].map((x) => Group.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Groups": List<dynamic>.from(groups.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}

class Group {
  Group({
    required this.name,
    required this.attributes,
    required this.id,
    required this.customProperties,
  });

  String name;
  List<AttributeGroup> attributes;
  int id;
  CustomProperties customProperties;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    name: json["Name"] == null ? null : json["Name"],
    attributes: List<AttributeGroup>.from(json["Attributes"].map((x) => AttributeGroup.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name == null ? null : name,
    "Attributes": List<AttributeGroup>.from(attributes.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AttributeGroup {
  AttributeGroup({
    required this.name,
    required this.id,
    required this.customProperties,
    required this.values,
  });

  String name;
  int id;
  CustomProperties customProperties;
  List<Value> values;

  factory AttributeGroup.fromJson(Map<String, dynamic> json) => AttributeGroup(
    name: json["Name"] == null ? null : json["Name"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    values: List<Value>.from(json["Values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Name": name == null ? null : name,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
    "Values": List<Value>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    required this.attributeTypeId,
    required this.valueRaw,
    required this.colorSquaresRgb,
    required this.customProperties,
  });

  int attributeTypeId;
  String valueRaw;
  dynamic colorSquaresRgb;
  CustomProperties customProperties;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    attributeTypeId: json["AttributeTypeId"],
    valueRaw: json["ValueRaw"],
    colorSquaresRgb: json["ColorSquaresRgb"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "AttributeTypeId": attributeTypeId,
    "ValueRaw": valueRaw,
    "ColorSquaresRgb": colorSquaresRgb,
    "CustomProperties": customProperties.toJson(),
  };
}
