/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';


class SpecificationFilter {
  SpecificationFilter({
    required this.enabled,
    required this.attributes,
    required this.customProperties,
  });

  bool enabled;
  List<Attribute> attributes;
  CustomProperties customProperties;

  factory SpecificationFilter.fromJson(Map<String, dynamic> json) => SpecificationFilter(
    enabled: json["Enabled"],
    attributes: List<Attribute>.from(json["Attributes"].map((x) => Attribute.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "Attributes": List<dynamic>.from(attributes.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}

class Attribute {
  Attribute({
    required this.name,
    required this.values,
    required this.id,
    required this.customProperties,
  });

  String name;
  List<Value> values;
  int id;
  CustomProperties customProperties;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json["Name"],
    values: List<Value>.from(json["Values"].map((x) => Value.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Values": List<dynamic>.from(values.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Value {
  Value({
    required this.name,
    required this.colorSquaresRgb,
    required this.selected,
    required this.id,
    required this.customProperties,
  });

  String name;
  dynamic colorSquaresRgb;
  bool selected;
  int id;
  CustomProperties customProperties;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    name: json["Name"],
    colorSquaresRgb: json["ColorSquaresRgb"],
    selected: json["Selected"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ColorSquaresRgb": colorSquaresRgb,
    "Selected": selected,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}