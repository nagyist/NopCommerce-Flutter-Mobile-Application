/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/CustomProperties.dart';

GetPopularProductTagsModel getPopularProductTagsModelFromJson(String str) => GetPopularProductTagsModel.fromJson(json.decode(str));

String getPopularProductTagsModelToJson(GetPopularProductTagsModel data) => json.encode(data.toJson());

class GetPopularProductTagsModel {
  GetPopularProductTagsModel({
    required this.totalTags,
    required this.tags,
    required this.customProperties,
  });

  int totalTags;
  List<Tag> tags;
  CustomProperties customProperties;

  factory GetPopularProductTagsModel.fromJson(Map<String, dynamic> json) => GetPopularProductTagsModel(
    totalTags: json["TotalTags"],
    tags: List<Tag>.from(json["Tags"].map((x) => Tag.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "TotalTags": totalTags,
    "Tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}

class Tag {
  Tag({
    required this.name,
    required this.seName,
    required this.productCount,
    required this.id,
    required this.customProperties,
  });

  String name;
  String seName;
  int productCount;
  int id;
  CustomProperties customProperties;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    name: json["Name"],
    seName: json["SeName"],
    productCount: json["ProductCount"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
    "ProductCount": productCount,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
