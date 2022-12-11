/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetCustomerNavigationModel getCustomerNavigationModelFromJson(String str) => GetCustomerNavigationModel.fromJson(json.decode(str));

String getCustomerNavigationModelToJson(GetCustomerNavigationModel data) => json.encode(data.toJson());

class GetCustomerNavigationModel {
  GetCustomerNavigationModel({
    required this.customerNavigationItems,
    required this.selectedTab,
    required this.customProperties,
  });

  List<CustomerNavigationItem> customerNavigationItems;
  String selectedTab;
  CustomProperties customProperties;

  factory GetCustomerNavigationModel.fromJson(Map<String, dynamic> json) => GetCustomerNavigationModel(
    customerNavigationItems: List<CustomerNavigationItem>.from(json["CustomerNavigationItems"].map((x) => CustomerNavigationItem.fromJson(x))),
    selectedTab: json["SelectedTab"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomerNavigationItems": List<dynamic>.from(customerNavigationItems.map((x) => x.toJson())),
    "SelectedTab": selectedTab,
    "CustomProperties": customProperties.toJson(),
  };
}

class CustomerNavigationItem {
  CustomerNavigationItem({
    required this.routeName,
    required this.title,
    required this.tab,
    required this.itemClass,
  });

  String routeName;
  String title;
  String tab;
  String itemClass;

  factory CustomerNavigationItem.fromJson(Map<String, dynamic> json) => CustomerNavigationItem(
    routeName: json["RouteName"],
    title: json["Title"],
    tab: json["Tab"],
    itemClass: json["ItemClass"],
  );

  Map<String, dynamic> toJson() => {
    "RouteName": routeName,
    "Title": title,
    "Tab": tab,
    "ItemClass": itemClass,
  };
}
