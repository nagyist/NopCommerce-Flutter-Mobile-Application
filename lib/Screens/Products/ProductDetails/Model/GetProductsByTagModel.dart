/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Models/SpecificationFilterModel.dart';

GetProductsByTagModel getProductsByTagModelFromJson(String str) => GetProductsByTagModel.fromJson(json.decode(str));

String getProductsByTagModelToJson(GetProductsByTagModel data) => json.encode(data.toJson());

class GetProductsByTagModel {
  GetProductsByTagModel({
    required this.tagName,
    required this.tagSeName,
    required this.catalogProductsModel,
    required this.id,
    required this.customProperties,
  });

  String tagName;
  String tagSeName;
  CatalogProductsModel catalogProductsModel;
  int id;
  CustomProperties customProperties;

  factory GetProductsByTagModel.fromJson(Map<String, dynamic> json) => GetProductsByTagModel(
    tagName: json["TagName"],
    tagSeName: json["TagSeName"],
    catalogProductsModel: CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "TagName": tagName,
    "TagSeName": tagSeName,
    "CatalogProductsModel": catalogProductsModel.toJson(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class CatalogProductsModel {
  CatalogProductsModel({
    required this.useAjaxLoading,
    required this.warningMessage,
    required this.noResultMessage,
    required this.priceRangeFilter,
    required this.specificationFilter,
    required this.manufacturerFilter,
    required this.allowProductSorting,
    required this.availableSortOptions,
    required this.allowProductViewModeChanging,
    required this.availableViewModes,
    required this.allowCustomersToSelectPageSize,
    required this.pageSizeOptions,
    required this.orderBy,
    required this.viewMode,
    required this.products,
    required this.pageIndex,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.firstItem,
    required this.lastItem,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.customProperties,
  });

  bool useAjaxLoading;
  dynamic warningMessage;
  dynamic noResultMessage;
  PriceRangeFilter priceRangeFilter;
  SpecificationFilter specificationFilter;
  ManufacturerFilter manufacturerFilter;
  bool allowProductSorting;
  List<AvailableSortOption> availableSortOptions;
  bool allowProductViewModeChanging;
  List<AvailableSortOption> availableViewModes;
  bool allowCustomersToSelectPageSize;
  List<AvailableSortOption> pageSizeOptions;
  dynamic orderBy;
  String viewMode;
  List<ProductBoxModel> products;
  int pageIndex;
  int pageNumber;
  int pageSize;
  int totalItems;
  int totalPages;
  int firstItem;
  int lastItem;
  bool hasPreviousPage;
  bool hasNextPage;
  CustomProperties customProperties;

  factory CatalogProductsModel.fromJson(Map<String, dynamic> json) => CatalogProductsModel(
    useAjaxLoading: json["UseAjaxLoading"],
    warningMessage: json["WarningMessage"],
    noResultMessage: json["NoResultMessage"],
    priceRangeFilter: PriceRangeFilter.fromJson(json["PriceRangeFilter"]),
    specificationFilter: SpecificationFilter.fromJson(json["SpecificationFilter"]),
    manufacturerFilter: ManufacturerFilter.fromJson(json["ManufacturerFilter"]),
    allowProductSorting: json["AllowProductSorting"],
    availableSortOptions: List<AvailableSortOption>.from(json["AvailableSortOptions"].map((x) => AvailableSortOption.fromJson(x))),
    allowProductViewModeChanging: json["AllowProductViewModeChanging"],
    availableViewModes: List<AvailableSortOption>.from(json["AvailableViewModes"].map((x) => AvailableSortOption.fromJson(x))),
    allowCustomersToSelectPageSize: json["AllowCustomersToSelectPageSize"],
    pageSizeOptions: List<AvailableSortOption>.from(json["PageSizeOptions"].map((x) => AvailableSortOption.fromJson(x))),
    orderBy: json["OrderBy"],
    viewMode: json["ViewMode"],
    products: List<ProductBoxModel>.from(json["Products"].map((x) => ProductBoxModel.fromJson(x))),
    pageIndex: json["PageIndex"],
    pageNumber: json["PageNumber"],
    pageSize: json["PageSize"],
    totalItems: json["TotalItems"],
    totalPages: json["TotalPages"],
    firstItem: json["FirstItem"],
    lastItem: json["LastItem"],
    hasPreviousPage: json["HasPreviousPage"],
    hasNextPage: json["HasNextPage"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "UseAjaxLoading": useAjaxLoading,
    "WarningMessage": warningMessage,
    "NoResultMessage": noResultMessage,
    "PriceRangeFilter": priceRangeFilter.toJson(),
    "SpecificationFilter": specificationFilter.toJson(),
    "ManufacturerFilter": manufacturerFilter.toJson(),
    "AllowProductSorting": allowProductSorting,
    "AvailableSortOptions": List<dynamic>.from(availableSortOptions.map((x) => x.toJson())),
    "AllowProductViewModeChanging": allowProductViewModeChanging,
    "AvailableViewModes": List<dynamic>.from(availableViewModes.map((x) => x.toJson())),
    "AllowCustomersToSelectPageSize": allowCustomersToSelectPageSize,
    "PageSizeOptions": List<dynamic>.from(pageSizeOptions.map((x) => x.toJson())),
    "OrderBy": orderBy,
    "ViewMode": viewMode,
    "Products": List<dynamic>.from(products.map((x) => x.toJson())),
    "PageIndex": pageIndex,
    "PageNumber": pageNumber,
    "PageSize": pageSize,
    "TotalItems": totalItems,
    "TotalPages": totalPages,
    "FirstItem": firstItem,
    "LastItem": lastItem,
    "HasPreviousPage": hasPreviousPage,
    "HasNextPage": hasNextPage,
    "CustomProperties": customProperties.toJson(),
  };
}

class AvailableSortOption {
  AvailableSortOption({
    required this.disabled,
    required this.group,
    required this.selected,
    required this.text,
    required this.value,
  });

  bool disabled;
  dynamic group;
  bool selected;
  String text;
  String value;

  factory AvailableSortOption.fromJson(Map<String, dynamic> json) => AvailableSortOption(
    disabled: json["Disabled"],
    group: json["Group"],
    selected: json["Selected"],
    text: json["Text"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Disabled": disabled,
    "Group": group,
    "Selected": selected,
    "Text": text,
    "Value": value,
  };
}


class ManufacturerFilter {
  ManufacturerFilter({
    required this.enabled,
    required this.manufacturers,
    required this.customProperties,
  });

  bool enabled;
  List<dynamic> manufacturers;
  CustomProperties customProperties;

  factory ManufacturerFilter.fromJson(Map<String, dynamic> json) => ManufacturerFilter(
    enabled: json["Enabled"],
    manufacturers: List<dynamic>.from(json["Manufacturers"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "Manufacturers": List<dynamic>.from(manufacturers.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}

class PriceRangeFilter {
  PriceRangeFilter({
    required this.enabled,
    required this.selectedPriceRange,
    required this.availablePriceRange,
    required this.customProperties,
  });

  bool enabled;
  PriceRange selectedPriceRange;
  PriceRange availablePriceRange;
  CustomProperties customProperties;

  factory PriceRangeFilter.fromJson(Map<String, dynamic> json) => PriceRangeFilter(
    enabled: json["Enabled"],
    selectedPriceRange: PriceRange.fromJson(json["SelectedPriceRange"]),
    availablePriceRange: PriceRange.fromJson(json["AvailablePriceRange"]),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "SelectedPriceRange": selectedPriceRange.toJson(),
    "AvailablePriceRange": availablePriceRange.toJson(),
    "CustomProperties": customProperties.toJson(),
  };
}

class PriceRange {
  PriceRange({
    required this.from,
    required this.to,
    required this.customProperties,
  });

  double from;
  double to;
  CustomProperties customProperties;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    from: json["From"],
    to: json["To"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "From": from,
    "To": to,
    "CustomProperties": customProperties.toJson(),
  };
}
