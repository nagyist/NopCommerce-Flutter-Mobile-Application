/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetTopMenuModel getTopMenuModelFromJson(String str) => GetTopMenuModel.fromJson(json.decode(str));

String getTopMenuModelToJson(GetTopMenuModel data) => json.encode(data.toJson());

class GetTopMenuModel {
  GetTopMenuModel({
    required this.categories,
    required this.topics,
    required this.blogEnabled,
    required this.newProductsEnabled,
    required this.forumEnabled,
    required this.displayHomepageMenuItem,
    required this.displayNewProductsMenuItem,
    required this.displayProductSearchMenuItem,
    required this.displayCustomerInfoMenuItem,
    required this.displayBlogMenuItem,
    required this.displayForumsMenuItem,
    required this.displayContactUsMenuItem,
    required this.useAjaxMenu,
    required this.hasOnlyCategories,
  });

  List<Category> categories;
  List<Topic> topics;
  bool blogEnabled;
  bool newProductsEnabled;
  bool forumEnabled;
  bool displayHomepageMenuItem;
  bool displayNewProductsMenuItem;
  bool displayProductSearchMenuItem;
  bool displayCustomerInfoMenuItem;
  bool displayBlogMenuItem;
  bool displayForumsMenuItem;
  bool displayContactUsMenuItem;
  bool useAjaxMenu;
  bool hasOnlyCategories;

  factory GetTopMenuModel.fromJson(Map<String, dynamic> json) => GetTopMenuModel(
    categories: List<Category>.from(json["Categories"].map((x) => Category.fromJson(x))),
    topics: List<Topic>.from(json["Topics"].map((x) => Topic.fromJson(x))),
    blogEnabled: json["BlogEnabled"],
    newProductsEnabled: json["NewProductsEnabled"],
    forumEnabled: json["ForumEnabled"],
    displayHomepageMenuItem: json["DisplayHomepageMenuItem"],
    displayNewProductsMenuItem: json["DisplayNewProductsMenuItem"],
    displayProductSearchMenuItem: json["DisplayProductSearchMenuItem"],
    displayCustomerInfoMenuItem: json["DisplayCustomerInfoMenuItem"],
    displayBlogMenuItem: json["DisplayBlogMenuItem"],
    displayForumsMenuItem: json["DisplayForumsMenuItem"],
    displayContactUsMenuItem: json["DisplayContactUsMenuItem"],
    useAjaxMenu: json["UseAjaxMenu"],
    hasOnlyCategories: json["HasOnlyCategories"],
  );

  Map<String, dynamic> toJson() => {
    "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "Topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    "BlogEnabled": blogEnabled,
    "NewProductsEnabled": newProductsEnabled,
    "ForumEnabled": forumEnabled,
    "DisplayHomepageMenuItem": displayHomepageMenuItem,
    "DisplayNewProductsMenuItem": displayNewProductsMenuItem,
    "DisplayProductSearchMenuItem": displayProductSearchMenuItem,
    "DisplayCustomerInfoMenuItem": displayCustomerInfoMenuItem,
    "DisplayBlogMenuItem": displayBlogMenuItem,
    "DisplayForumsMenuItem": displayForumsMenuItem,
    "DisplayContactUsMenuItem": displayContactUsMenuItem,
    "UseAjaxMenu": useAjaxMenu,
    "HasOnlyCategories": hasOnlyCategories,
  };
}

class Category {
  Category({
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
  List<Category> subCategories;
  bool haveSubCategories;
  dynamic route;
  int id;
  CustomProperties customProperties;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["Name"],
    seName: json["SeName"],
    numberOfProducts: json["NumberOfProducts"],
    includeInTopMenu: json["IncludeInTopMenu"],
    subCategories: List<Category>.from(json["SubCategories"].map((x) => Category.fromJson(x))),
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
    "SubCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "HaveSubCategories": haveSubCategories,
    "Route": route,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Topic {
  Topic({
    required this.name,
    required this.seName,
    required this.id,
  });

  String name;
  String seName;
  int id;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    name: json["Name"],
    seName: json["SeName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
    "Id": id,
  };
}
