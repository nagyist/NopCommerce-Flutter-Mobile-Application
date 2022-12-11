/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/PictureBoxModel.dart';
import 'dart:convert';

List<GetHomepageCategoriesModel> getHomepageCategoriesModelFromJson(String str) => List<GetHomepageCategoriesModel>.from(json.decode(str).map((x) => GetHomepageCategoriesModel.fromJson(x)));

String getHomepageCategoriesModelToJson(List<GetHomepageCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHomepageCategoriesModel {
  GetHomepageCategoriesModel({
    required this.name,
    required this.description,
    required this.metaKeywords,
    required this.metaDescription,
    required this.metaTitle,
    required this.seName,
    required this.pictureModel,
    required this.displayCategoryBreadcrumb,
    required this.categoryBreadcrumb,
    required this.subCategories,
    required this.featuredProducts,
    required this.id,
  });

  String name;
  dynamic description;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String seName;
  PictureModel pictureModel;
  bool displayCategoryBreadcrumb;
  List<dynamic> categoryBreadcrumb;
  List<dynamic> subCategories;
  List<dynamic> featuredProducts;
  int id;

  factory GetHomepageCategoriesModel.fromJson(Map<dynamic, dynamic> json) => GetHomepageCategoriesModel(
    name: json["Name"],
    description: json["Description"],
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    pictureModel: PictureModel.fromJson(json["PictureModel"]),
    displayCategoryBreadcrumb: json["DisplayCategoryBreadcrumb"],
    categoryBreadcrumb: List<dynamic>.from(json["CategoryBreadcrumb"].map((x) => x)),
    subCategories: List<dynamic>.from(json["SubCategories"].map((x) => x)),
    featuredProducts: List<dynamic>.from(json["FeaturedProducts"].map((x) => x)),
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Description": description,
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "PictureModel": pictureModel.toJson(),
    "DisplayCategoryBreadcrumb": displayCategoryBreadcrumb,
    "CategoryBreadcrumb": List<dynamic>.from(categoryBreadcrumb.map((x) => x)),
    "SubCategories": List<dynamic>.from(subCategories.map((x) => x)),
    "FeaturedProducts": List<dynamic>.from(featuredProducts.map((x) => x)),
    "Id": id,
  };
}

List<GetLocalHomepageCategoriesModel> getLocalHomepageCategoriesModelFromJson(String str) => List<GetLocalHomepageCategoriesModel>.from(json.decode(str).map((x) => GetHomepageCategoriesModel.fromJson(x)));

String getLocalHomepageCategoriesModelToJson(List<GetLocalHomepageCategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetLocalHomepageCategoriesModel {
  GetLocalHomepageCategoriesModel({
    required this.id,
    required this.name,
    required this.imageurl,
  });

  String name;
  String imageurl;
  String id;

  factory GetLocalHomepageCategoriesModel.fromJson(Map<dynamic, dynamic> json) => GetLocalHomepageCategoriesModel(
    name: json["Name"],
    imageurl: json["ImageUrl"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ImageUrl": imageurl,
    "Id": id,
  };
}
