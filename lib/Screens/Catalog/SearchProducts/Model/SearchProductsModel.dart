/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';
import '../../../../Models/ProductCatalogModel.dart';

SearchProductModel searchProductModelFromJson(String str) => SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) => json.encode(data.toJson());

class SearchProductModel {
  SearchProductModel({
    required this.q,
    required this.cid,
    required this.isc,
    required this.mid,
    required this.vid,
    required this.sid,
    required this.advs,
    required this.asv,
    required this.catalogProductsModel,
    required this.availableCategories,
    required this.availableManufacturers,
    required this.availableVendors,
    required this.customProperties,
  });

  String q;
  int cid;
  bool isc;
  int mid;
  int vid;
  bool sid;
  bool advs;
  bool asv;
  CatalogProductsModel catalogProductsModel;
  List<AvailableOption> availableCategories;
  List<AvailableOption> availableManufacturers;
  List<AvailableOption> availableVendors;
  CustomProperties customProperties;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
    q: json["q"],
    cid: json["cid"],
    isc: json["isc"],
    mid: json["mid"],
    vid: json["vid"],
    sid: json["sid"],
    advs: json["advs"],
    asv: json["asv"],
    catalogProductsModel: CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
    availableCategories: List<AvailableOption>.from(json["AvailableCategories"].map((x) => AvailableOption.fromJson(x))),
    availableManufacturers: List<AvailableOption>.from(json["AvailableManufacturers"].map((x) => AvailableOption.fromJson(x))),
    availableVendors: List<AvailableOption>.from(json["AvailableVendors"].map((x) => AvailableOption.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "cid": cid,
    "isc": isc,
    "mid": mid,
    "vid": vid,
    "sid": sid,
    "advs": advs,
    "asv": asv,
    "CatalogProductsModel": catalogProductsModel.toJson(),
    "AvailableCategories": List<dynamic>.from(availableCategories.map((x) => x.toJson())),
    "AvailableManufacturers": List<dynamic>.from(availableManufacturers.map((x) => x.toJson())),
    "AvailableVendors": List<dynamic>.from(availableVendors.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}
