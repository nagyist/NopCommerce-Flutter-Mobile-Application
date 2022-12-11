/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

List<GetCatalogRootModel> getCatalogRootModelFromJson(String str) => List<GetCatalogRootModel>.from(json.decode(str).map((x) => GetCatalogRootModel.fromJson(x)));

String getCatalogRootModelToJson(List<GetCatalogRootModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCatalogRootModel {
  GetCatalogRootModel({
    required this.name,
    required this.seName,
    required this.numberOfProducts,
    required this.includeInTopMenu,
    required this.subCategories,
    required this.haveSubCategories,
    required this.route,
    required this.id,
    required this.customProperties,
  });

  String name;
  String seName;
  dynamic numberOfProducts;
  bool includeInTopMenu;
  List<dynamic> subCategories;
  bool haveSubCategories;
  String route;
  int id;
  CustomProperties customProperties;

  factory GetCatalogRootModel.fromJson(Map<String, dynamic> json) => GetCatalogRootModel(
    name: json["Name"],
    seName: json["SeName"],
    numberOfProducts: json["NumberOfProducts"],
    includeInTopMenu: json["IncludeInTopMenu"],
    subCategories: List<dynamic>.from(json["SubCategories"].map((x) => x)),
    haveSubCategories: json["HaveSubCategories"],
    route: json["Route"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
    "NumberOfProducts": numberOfProducts,
    "IncludeInTopMenu": includeInTopMenu,
    "SubCategories": List<dynamic>.from(subCategories.map((x) => x)),
    "HaveSubCategories": haveSubCategories,
    "Route": route,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}