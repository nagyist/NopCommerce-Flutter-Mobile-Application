/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetFooterInfoModel getFooterInfoModelFromJson(String str) => GetFooterInfoModel.fromJson(json.decode(str));

String getFooterInfoModelToJson(GetFooterInfoModel data) => json.encode(data.toJson());

class GetFooterInfoModel {
  GetFooterInfoModel({
    required this.storeName,
    required this.wishlistEnabled,
    required this.shoppingCartEnabled,
    required this.sitemapEnabled,
    required this.searchEnabled,
    required this.newsEnabled,
    required this.blogEnabled,
    required this.compareProductsEnabled,
    required this.forumEnabled,
    required this.recentlyViewedProductsEnabled,
    required this.newProductsEnabled,
    required this.allowCustomersToApplyForVendorAccount,
    required this.allowCustomersToCheckGiftCardBalance,
    required this.displayTaxShippingInfoFooter,
    required this.hidePoweredByNopCommerce,
    required this.workingLanguageId,
    required this.topics,
    required this.displaySitemapFooterItem,
    required this.displayContactUsFooterItem,
    required this.displayProductSearchFooterItem,
    required this.displayNewsFooterItem,
    required this.displayBlogFooterItem,
    required this.displayForumsFooterItem,
    required this.displayRecentlyViewedProductsFooterItem,
    required this.displayCompareProductsFooterItem,
    required this.displayNewProductsFooterItem,
    required this.displayCustomerInfoFooterItem,
    required this.displayCustomerOrdersFooterItem,
    required this.displayCustomerAddressesFooterItem,
    required this.displayShoppingCartFooterItem,
    required this.displayWishlistFooterItem,
    required this.displayApplyVendorAccountFooterItem,
    required this.customProperties,
  });

  String storeName;
  bool wishlistEnabled;
  bool shoppingCartEnabled;
  bool sitemapEnabled;
  bool searchEnabled;
  bool newsEnabled;
  bool blogEnabled;
  bool compareProductsEnabled;
  bool forumEnabled;
  bool recentlyViewedProductsEnabled;
  bool newProductsEnabled;
  bool allowCustomersToApplyForVendorAccount;
  bool allowCustomersToCheckGiftCardBalance;
  bool displayTaxShippingInfoFooter;
  bool hidePoweredByNopCommerce;
  int workingLanguageId;
  List<Topic_Footer> topics;
  bool displaySitemapFooterItem;
  bool displayContactUsFooterItem;
  bool displayProductSearchFooterItem;
  bool displayNewsFooterItem;
  bool displayBlogFooterItem;
  bool displayForumsFooterItem;
  bool displayRecentlyViewedProductsFooterItem;
  bool displayCompareProductsFooterItem;
  bool displayNewProductsFooterItem;
  bool displayCustomerInfoFooterItem;
  bool displayCustomerOrdersFooterItem;
  bool displayCustomerAddressesFooterItem;
  bool displayShoppingCartFooterItem;
  bool displayWishlistFooterItem;
  bool displayApplyVendorAccountFooterItem;
  CustomProperties customProperties;

  factory GetFooterInfoModel.fromJson(Map<String, dynamic> json) => GetFooterInfoModel(
    storeName: json["StoreName"],
    wishlistEnabled: json["WishlistEnabled"],
    shoppingCartEnabled: json["ShoppingCartEnabled"],
    sitemapEnabled: json["SitemapEnabled"],
    searchEnabled: json["SearchEnabled"],
    newsEnabled: json["NewsEnabled"],
    blogEnabled: json["BlogEnabled"],
    compareProductsEnabled: json["CompareProductsEnabled"],
    forumEnabled: json["ForumEnabled"],
    recentlyViewedProductsEnabled: json["RecentlyViewedProductsEnabled"],
    newProductsEnabled: json["NewProductsEnabled"],
    allowCustomersToApplyForVendorAccount: json["AllowCustomersToApplyForVendorAccount"],
    allowCustomersToCheckGiftCardBalance: json["AllowCustomersToCheckGiftCardBalance"],
    displayTaxShippingInfoFooter: json["DisplayTaxShippingInfoFooter"],
    hidePoweredByNopCommerce: json["HidePoweredByNopCommerce"],
    workingLanguageId: json["WorkingLanguageId"],
    topics: List<Topic_Footer>.from(json["Topics"].map((x) => Topic_Footer.fromJson(x))),
    displaySitemapFooterItem: json["DisplaySitemapFooterItem"],
    displayContactUsFooterItem: json["DisplayContactUsFooterItem"],
    displayProductSearchFooterItem: json["DisplayProductSearchFooterItem"],
    displayNewsFooterItem: json["DisplayNewsFooterItem"],
    displayBlogFooterItem: json["DisplayBlogFooterItem"],
    displayForumsFooterItem: json["DisplayForumsFooterItem"],
    displayRecentlyViewedProductsFooterItem: json["DisplayRecentlyViewedProductsFooterItem"],
    displayCompareProductsFooterItem: json["DisplayCompareProductsFooterItem"],
    displayNewProductsFooterItem: json["DisplayNewProductsFooterItem"],
    displayCustomerInfoFooterItem: json["DisplayCustomerInfoFooterItem"],
    displayCustomerOrdersFooterItem: json["DisplayCustomerOrdersFooterItem"],
    displayCustomerAddressesFooterItem: json["DisplayCustomerAddressesFooterItem"],
    displayShoppingCartFooterItem: json["DisplayShoppingCartFooterItem"],
    displayWishlistFooterItem: json["DisplayWishlistFooterItem"],
    displayApplyVendorAccountFooterItem: json["DisplayApplyVendorAccountFooterItem"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "StoreName": storeName,
    "WishlistEnabled": wishlistEnabled,
    "ShoppingCartEnabled": shoppingCartEnabled,
    "SitemapEnabled": sitemapEnabled,
    "SearchEnabled": searchEnabled,
    "NewsEnabled": newsEnabled,
    "BlogEnabled": blogEnabled,
    "CompareProductsEnabled": compareProductsEnabled,
    "ForumEnabled": forumEnabled,
    "RecentlyViewedProductsEnabled": recentlyViewedProductsEnabled,
    "NewProductsEnabled": newProductsEnabled,
    "AllowCustomersToApplyForVendorAccount": allowCustomersToApplyForVendorAccount,
    "AllowCustomersToCheckGiftCardBalance": allowCustomersToCheckGiftCardBalance,
    "DisplayTaxShippingInfoFooter": displayTaxShippingInfoFooter,
    "HidePoweredByNopCommerce": hidePoweredByNopCommerce,
    "WorkingLanguageId": workingLanguageId,
    "Topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    "DisplaySitemapFooterItem": displaySitemapFooterItem,
    "DisplayContactUsFooterItem": displayContactUsFooterItem,
    "DisplayProductSearchFooterItem": displayProductSearchFooterItem,
    "DisplayNewsFooterItem": displayNewsFooterItem,
    "DisplayBlogFooterItem": displayBlogFooterItem,
    "DisplayForumsFooterItem": displayForumsFooterItem,
    "DisplayRecentlyViewedProductsFooterItem": displayRecentlyViewedProductsFooterItem,
    "DisplayCompareProductsFooterItem": displayCompareProductsFooterItem,
    "DisplayNewProductsFooterItem": displayNewProductsFooterItem,
    "DisplayCustomerInfoFooterItem": displayCustomerInfoFooterItem,
    "DisplayCustomerOrdersFooterItem": displayCustomerOrdersFooterItem,
    "DisplayCustomerAddressesFooterItem": displayCustomerAddressesFooterItem,
    "DisplayShoppingCartFooterItem": displayShoppingCartFooterItem,
    "DisplayWishlistFooterItem": displayWishlistFooterItem,
    "DisplayApplyVendorAccountFooterItem": displayApplyVendorAccountFooterItem,
    "CustomProperties": customProperties.toJson(),
  };
}

class Topic_Footer {
  Topic_Footer({
    required this.name,
    required this.seName,
    required this.includeInFooterColumn1,
    required this.includeInFooterColumn2,
    required this.includeInFooterColumn3,
    required this.id,
    required this.customProperties,
  });

  String name;
  String seName;
  bool includeInFooterColumn1;
  bool includeInFooterColumn2;
  bool includeInFooterColumn3;
  int id;
  CustomProperties customProperties;

  factory Topic_Footer.fromJson(Map<String, dynamic> json) => Topic_Footer(
    name: json["Name"],
    seName: json["SeName"],
    includeInFooterColumn1: json["IncludeInFooterColumn1"],
    includeInFooterColumn2: json["IncludeInFooterColumn2"],
    includeInFooterColumn3: json["IncludeInFooterColumn3"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
    "IncludeInFooterColumn1": includeInFooterColumn1,
    "IncludeInFooterColumn2": includeInFooterColumn2,
    "IncludeInFooterColumn3": includeInFooterColumn3,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
