/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/AllowedQuantityModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';
import 'package:nopcommerce/Models/ProductSpecificationModel.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Models/PictureBoxModel.dart';

GetProductDetailsModel getProductDetailsModelFromJson(String str) => GetProductDetailsModel.fromJson(json.decode(str));

String getProductDetailsModelToJson(GetProductDetailsModel data) => json.encode(data.toJson());

class GetProductDetailsModel {
  GetProductDetailsModel({
    required this.defaultPictureZoomEnabled,
    required this.defaultPictureModel,
    required this.pictureModels,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.metaKeywords,
    required this.metaDescription,
    required this.metaTitle,
    required this.seName,
    required this.visibleIndividually,
    required this.productType,
    required this.showSku,
    required this.sku,
    required this.showManufacturerPartNumber,
    required this.manufacturerPartNumber,
    required this.showGtin,
    required this.gtin,
    required this.showVendor,
    required this.vendorModel,
    required this.hasSampleDownload,
    required this.giftCard,
    required this.isShipEnabled,
    required this.isFreeShipping,
    required this.freeShippingNotificationEnabled,
    required this.deliveryDate,
    required this.isRental,
    required this.rentalStartDate,
    required this.rentalEndDate,
    required this.availableEndDate,
    required this.manageInventoryMethod,
    required this.stockAvailability,
    required this.displayBackInStockSubscription,
    required this.emailAFriendEnabled,
    required this.compareProductsEnabled,
    required this.pageShareCode,
    required this.productPrice,
    required this.addToCart,
    required this.breadcrumb,
    required this.productTags,
    required this.productAttributes,
    required this.productSpecificationModel,
    required this.productManufacturers,
    required this.productReviewOverview,
    required this.productEstimateShipping,
    required this.tierPrices,
    required this.associatedProducts,
    required this.displayDiscontinuedMessage,
    required this.currentStoreName,
    required this.inStock,
    required this.allowAddingOnlyExistingAttributeCombinations,
    required this.id,
    required this.customProperties,
  });

  bool defaultPictureZoomEnabled;
  PictureModel defaultPictureModel;
  List<PictureModel> pictureModels;
  String name;
  String shortDescription;
  String fullDescription;
  dynamic metaKeywords;
  String metaDescription;
  dynamic metaTitle;
  String seName;
  bool visibleIndividually;
  String productType;
  bool showSku;
  String sku;
  bool showManufacturerPartNumber;
  dynamic manufacturerPartNumber;
  bool showGtin;
  dynamic gtin;
  bool showVendor;
  VendorModel vendorModel;
  bool hasSampleDownload;
  GiftCard giftCard;
  bool isShipEnabled;
  bool isFreeShipping;
  bool freeShippingNotificationEnabled;
  dynamic deliveryDate;
  bool isRental;
  dynamic rentalStartDate;
  dynamic rentalEndDate;
  dynamic availableEndDate;
  String manageInventoryMethod;
  String stockAvailability;
  bool displayBackInStockSubscription;
  bool emailAFriendEnabled;
  bool compareProductsEnabled;
  String pageShareCode;
  ProductPrice productPrice;
  AddToCart addToCart;
  Breadcrumb breadcrumb;
  List<VendorModel> productTags;
  List<ProductAttribute> productAttributes;
  ProductSpecificationModel productSpecificationModel;
  List<VendorModel> productManufacturers;
  ProductReviewOverview productReviewOverview;
  ProductEstimateShipping productEstimateShipping;
  List<TierPrice> tierPrices;
  List<GetProductDetailsModel> associatedProducts;
  bool displayDiscontinuedMessage;
  String currentStoreName;
  bool inStock;
  bool allowAddingOnlyExistingAttributeCombinations;
  int id;
  CustomProperties customProperties;

  factory GetProductDetailsModel.fromJson(Map<String, dynamic> json) => GetProductDetailsModel(
    defaultPictureZoomEnabled: json["DefaultPictureZoomEnabled"],
    defaultPictureModel: PictureModel.fromJson(json["DefaultPictureModel"]),
    pictureModels: List<PictureModel>.from(json["PictureModels"].map((x) => PictureModel.fromJson(x))),
    name: json["Name"],
    shortDescription: json["ShortDescription"],
    fullDescription: json["FullDescription"],
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    visibleIndividually: json["VisibleIndividually"],
    productType: json["ProductType"],
    showSku: json["ShowSku"],
    sku: json["Sku"],
    showManufacturerPartNumber: json["ShowManufacturerPartNumber"],
    manufacturerPartNumber: json["ManufacturerPartNumber"],
    showGtin: json["ShowGtin"],
    gtin: json["Gtin"],
    showVendor: json["ShowVendor"],
    vendorModel: VendorModel.fromJson(json["VendorModel"]),
    hasSampleDownload: json["HasSampleDownload"],
    giftCard: GiftCard.fromJson(json["GiftCard"]),
    isShipEnabled: json["IsShipEnabled"],
    isFreeShipping: json["IsFreeShipping"],
    freeShippingNotificationEnabled: json["FreeShippingNotificationEnabled"],
    deliveryDate: json["DeliveryDate"],
    isRental: json["IsRental"],
    rentalStartDate: json["RentalStartDate"],
    rentalEndDate: json["RentalEndDate"],
    availableEndDate: json["AvailableEndDate"],
    manageInventoryMethod: json["ManageInventoryMethod"],
    stockAvailability: json["StockAvailability"],
    displayBackInStockSubscription: json["DisplayBackInStockSubscription"],
    emailAFriendEnabled: json["EmailAFriendEnabled"],
    compareProductsEnabled: json["CompareProductsEnabled"],
    pageShareCode: json["PageShareCode"],
    productPrice: ProductPrice.fromJson(json["ProductPrice"]),
    addToCart: AddToCart.fromJson(json["AddToCart"]),
    breadcrumb: Breadcrumb.fromJson(json["Breadcrumb"]),
    productTags: List<VendorModel>.from(json["ProductTags"].map((x) => VendorModel.fromJson(x))),
    productAttributes: List<ProductAttribute>.from(json["ProductAttributes"].map((x) => ProductAttribute.fromJson(x))),
    productSpecificationModel: ProductSpecificationModel.fromJson(json["ProductSpecificationModel"]),
    productManufacturers: List<VendorModel>.from(json["ProductManufacturers"].map((x) => VendorModel.fromJson(x))),
    productReviewOverview: ProductReviewOverview.fromJson(json["ProductReviewOverview"]),
    productEstimateShipping: ProductEstimateShipping.fromJson(json["ProductEstimateShipping"]),
    tierPrices: List<TierPrice>.from(json["TierPrices"].map((x) => TierPrice.fromJson(x))),
    associatedProducts: List<GetProductDetailsModel>.from(json["AssociatedProducts"].map((x) => GetProductDetailsModel.fromJson(x))),
    displayDiscontinuedMessage: json["DisplayDiscontinuedMessage"],
    currentStoreName: json["CurrentStoreName"],
    inStock: json["InStock"],
    allowAddingOnlyExistingAttributeCombinations: json["AllowAddingOnlyExistingAttributeCombinations"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "DefaultPictureZoomEnabled": defaultPictureZoomEnabled,
    "DefaultPictureModel": defaultPictureModel.toJson(),
    "PictureModels": List<dynamic>.from(pictureModels.map((x) => x.toJson())),
    "Name": name,
    "ShortDescription": shortDescription,
    "FullDescription": fullDescription,
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "VisibleIndividually": visibleIndividually,
    "ProductType": productType,
    "ShowSku": showSku,
    "Sku": sku,
    "ShowManufacturerPartNumber": showManufacturerPartNumber,
    "ManufacturerPartNumber": manufacturerPartNumber,
    "ShowGtin": showGtin,
    "Gtin": gtin,
    "ShowVendor": showVendor,
    "VendorModel": vendorModel.toJson(),
    "HasSampleDownload": hasSampleDownload,
    "GiftCard": giftCard.toJson(),
    "IsShipEnabled": isShipEnabled,
    "IsFreeShipping": isFreeShipping,
    "FreeShippingNotificationEnabled": freeShippingNotificationEnabled,
    "DeliveryDate": deliveryDate,
    "IsRental": isRental,
    "RentalStartDate": rentalStartDate,
    "RentalEndDate": rentalEndDate,
    "AvailableEndDate": availableEndDate,
    "ManageInventoryMethod": manageInventoryMethod,
    "StockAvailability": stockAvailability,
    "DisplayBackInStockSubscription": displayBackInStockSubscription,
    "EmailAFriendEnabled": emailAFriendEnabled,
    "CompareProductsEnabled": compareProductsEnabled,
    "PageShareCode": pageShareCode,
    "ProductPrice": productPrice.toJson(),
    "AddToCart": addToCart.toJson(),
    "Breadcrumb": breadcrumb.toJson(),
    "ProductTags": List<dynamic>.from(productTags.map((x) => x.toJson())),
    "ProductAttributes": List<dynamic>.from(productAttributes.map((x) => x.toJson())),
    "ProductSpecificationModel": productSpecificationModel.toJson(),
    "ProductManufacturers": List<dynamic>.from(productManufacturers.map((x) => x)),
    "ProductReviewOverview": productReviewOverview.toJson(),
    "ProductEstimateShipping": productEstimateShipping.toJson(),
    "TierPrices": List<dynamic>.from(tierPrices.map((x) => x.toJson())),
    "AssociatedProducts": List<GetProductDetailsModel>.from(associatedProducts.map((x) => x)),
    "DisplayDiscontinuedMessage": displayDiscontinuedMessage,
    "CurrentStoreName": currentStoreName,
    "InStock": inStock,
    "AllowAddingOnlyExistingAttributeCombinations": allowAddingOnlyExistingAttributeCombinations,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AddToCart {
  AddToCart({
    required this.productId,
    required this.enteredQuantity,
    required this.minimumQuantityNotification,
    required this.allowedQuantities,
    required this.customerEntersPrice,
    required this.customerEnteredPrice,
    required this.customerEnteredPriceRange,
    required this.disableBuyButton,
    required this.disableWishlistButton,
    required this.isRental,
    required this.availableForPreOrder,
    required this.preOrderAvailabilityStartDateTimeUtc,
    required this.preOrderAvailabilityStartDateTimeUserTime,
    required this.updatedShoppingCartItemId,
    required this.updateShoppingCartItemType,
    required this.customProperties,
  });

  int productId;
  int enteredQuantity;
  dynamic minimumQuantityNotification;
  List<AllowedQuantity> allowedQuantities;
  bool customerEntersPrice;
  double customerEnteredPrice;
  String customerEnteredPriceRange;
  bool disableBuyButton;
  bool disableWishlistButton;
  bool isRental;
  bool availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  dynamic preOrderAvailabilityStartDateTimeUserTime;
  int updatedShoppingCartItemId;
  dynamic updateShoppingCartItemType;
  CustomProperties customProperties;

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
    productId: json["ProductId"],
    enteredQuantity: json["EnteredQuantity"],
    minimumQuantityNotification: json["MinimumQuantityNotification"],
    allowedQuantities: List<AllowedQuantity>.from(json["AllowedQuantities"].map((x) => AllowedQuantity.fromJson(x))),
    customerEntersPrice: json["CustomerEntersPrice"],
    customerEnteredPrice: json["CustomerEnteredPrice"],
    customerEnteredPriceRange: json["CustomerEnteredPriceRange"],
    disableBuyButton: json["DisableBuyButton"],
    disableWishlistButton: json["DisableWishlistButton"],
    isRental: json["IsRental"],
    availableForPreOrder: json["AvailableForPreOrder"],
    preOrderAvailabilityStartDateTimeUtc: json["PreOrderAvailabilityStartDateTimeUtc"],
    preOrderAvailabilityStartDateTimeUserTime: json["PreOrderAvailabilityStartDateTimeUserTime"],
    updatedShoppingCartItemId: json["UpdatedShoppingCartItemId"],
    updateShoppingCartItemType: json["UpdateShoppingCartItemType"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "EnteredQuantity": enteredQuantity,
    "MinimumQuantityNotification": minimumQuantityNotification,
    "AllowedQuantities": List<dynamic>.from(allowedQuantities.map((x) => x.toJson())),
    "CustomerEntersPrice": customerEntersPrice,
    "CustomerEnteredPrice": customerEnteredPrice,
    "CustomerEnteredPriceRange": customerEnteredPriceRange,
    "DisableBuyButton": disableBuyButton,
    "DisableWishlistButton": disableWishlistButton,
    "IsRental": isRental,
    "AvailableForPreOrder": availableForPreOrder,
    "PreOrderAvailabilityStartDateTimeUtc": preOrderAvailabilityStartDateTimeUtc,
    "PreOrderAvailabilityStartDateTimeUserTime": preOrderAvailabilityStartDateTimeUserTime,
    "UpdatedShoppingCartItemId": updatedShoppingCartItemId,
    "UpdateShoppingCartItemType": updateShoppingCartItemType,
    "CustomProperties": customProperties.toJson(),
  };
}

class Breadcrumb {
  Breadcrumb({
    required this.enabled,
    required this.productId,
    required this.productName,
    required this.productSeName,
    required this.categoryBreadcrumb,
    required this.customProperties,
  });

  bool enabled;
  int productId;
  String productName;
  String productSeName;
  List<CategoryBreadcrumb> categoryBreadcrumb;
  CustomProperties customProperties;

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
    enabled: json["Enabled"],
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    categoryBreadcrumb: List<CategoryBreadcrumb>.from(json["CategoryBreadcrumb"].map((x) => CategoryBreadcrumb.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "CategoryBreadcrumb": List<dynamic>.from(categoryBreadcrumb.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}

class CategoryBreadcrumb {
  CategoryBreadcrumb({
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
  dynamic route;
  int id;
  CustomProperties customProperties;

  factory CategoryBreadcrumb.fromJson(Map<String, dynamic> json) => CategoryBreadcrumb(
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

class GiftCard {
  GiftCard({
    required this.isGiftCard,
    required this.recipientName,
    required this.recipientEmail,
    required this.senderName,
    required this.senderEmail,
    required this.message,
    required this.giftCardType,
    required this.customProperties,
  });

  bool isGiftCard;
  String recipientName;
  String recipientEmail;
  String senderName;
  String senderEmail;
  String message;
  String giftCardType;
  CustomProperties customProperties;

  factory GiftCard.fromJson(Map<String, dynamic> json) => GiftCard(
    isGiftCard: json["IsGiftCard"],
    recipientName: json["RecipientName"],
    recipientEmail: json["RecipientEmail"],
    senderName: json["SenderName"],
    senderEmail: json["SenderEmail"],
    message: json["Message"],
    giftCardType: json["GiftCardType"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "IsGiftCard": isGiftCard,
    "RecipientName": recipientName,
    "RecipientEmail": recipientEmail,
    "SenderName": senderName,
    "SenderEmail": senderEmail,
    "Message": message,
    "GiftCardType": giftCardType,
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductAttribute {
  ProductAttribute({
    required this.productId,
    required this.productAttributeId,
    required this.name,
    required this.description,
    required this.textPrompt,
    required this.isRequired,
    required this.defaultValue,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.hasCondition,
    required this.allowedFileExtensions,
    required this.attributeControlType,
    required this.values,
    required this.id,
    required this.customProperties,
  });

  int productId;
  int productAttributeId;
  String name;
  dynamic description;
  dynamic textPrompt;
  bool isRequired;
  dynamic defaultValue;
  dynamic selectedDay;
  dynamic selectedMonth;
  dynamic selectedYear;
  bool hasCondition;
  List<String> allowedFileExtensions;
  String attributeControlType;
  List<AttributeValue> values;
  int id;
  CustomProperties customProperties;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    productId: json["ProductId"],
    productAttributeId: json["ProductAttributeId"],
    name: json["Name"],
    description: json["Description"],
    textPrompt: json["TextPrompt"],
    isRequired: json["IsRequired"],
    defaultValue: json["DefaultValue"],
    selectedDay: json["SelectedDay"],
    selectedMonth: json["SelectedMonth"],
    selectedYear: json["SelectedYear"],
    hasCondition: json["HasCondition"],
    allowedFileExtensions: List<String>.from(json["AllowedFileExtensions"].map((x) => x)),
    attributeControlType: json["AttributeControlType"],
    values: List<AttributeValue>.from(json["Values"].map((x) => AttributeValue.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductAttributeId": productAttributeId,
    "Name": name,
    "Description": description,
    "TextPrompt": textPrompt,
    "IsRequired": isRequired,
    "DefaultValue": defaultValue,
    "SelectedDay": selectedDay,
    "SelectedMonth": selectedMonth,
    "SelectedYear": selectedYear,
    "HasCondition": hasCondition,
    "AllowedFileExtensions": List<String>.from(allowedFileExtensions.map((x) => x)),
    "AttributeControlType": attributeControlType,
    "Values": List<dynamic>.from(values.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AttributeValue {
  AttributeValue({
    required this.name,
    required this.colorSquaresRgb,
    required this.imageSquaresPictureModel,
    required this.priceAdjustment,
    required this.priceAdjustmentUsePercentage,
    required this.priceAdjustmentValue,
    required this.isPreSelected,
    required this.pictureId,
    required this.customerEntersQty,
    required this.quantity,
    required this.id,
    required this.customProperties,
  });

  String name;
  dynamic colorSquaresRgb;
  PictureModel imageSquaresPictureModel;
  String priceAdjustment;
  bool priceAdjustmentUsePercentage;
  double priceAdjustmentValue;
  bool isPreSelected;
  int pictureId;
  bool customerEntersQty;
  int quantity;
  int id;
  CustomProperties customProperties;

  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
    name: json["Name"],
    colorSquaresRgb: json["ColorSquaresRgb"],
    imageSquaresPictureModel: PictureModel.fromJson(json["ImageSquaresPictureModel"]),
    priceAdjustment: json["PriceAdjustment"] == null ? null : json["PriceAdjustment"],
    priceAdjustmentUsePercentage: json["PriceAdjustmentUsePercentage"],
    priceAdjustmentValue: json["PriceAdjustmentValue"],
    isPreSelected: json["IsPreSelected"],
    pictureId: json["PictureId"],
    customerEntersQty: json["CustomerEntersQty"],
    quantity: json["Quantity"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ColorSquaresRgb": colorSquaresRgb,
    "ImageSquaresPictureModel": imageSquaresPictureModel.toJson(),
    "PriceAdjustment": priceAdjustment == null ? null : priceAdjustment,
    "PriceAdjustmentUsePercentage": priceAdjustmentUsePercentage,
    "PriceAdjustmentValue": priceAdjustmentValue,
    "IsPreSelected": isPreSelected,
    "PictureId": pictureId,
    "CustomerEntersQty": customerEntersQty,
    "Quantity": quantity,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductEstimateShipping {
  ProductEstimateShipping({
    required this.productId,
    required this.requestDelay,
    required this.enabled,
    required this.countryId,
    required this.stateProvinceId,
    required this.zipPostalCode,
    required this.useCity,
    required this.city,
    required this.availableCountries,
    required this.availableStates,
    required this.customProperties,
  });

  int productId;
  int requestDelay;
  bool enabled;
  String countryId;
  String stateProvinceId;
  String zipPostalCode;
  bool useCity;
  String city;
  List<CountryStateModel> availableCountries;
  List<CountryStateModel> availableStates;
  CustomProperties customProperties;

  factory ProductEstimateShipping.fromJson(Map<String, dynamic> json) => ProductEstimateShipping(
    productId: json["ProductId"],
    requestDelay: json["RequestDelay"],
    enabled: json["Enabled"],
    countryId: json["CountryId"],
    stateProvinceId: json["StateProvinceId"],
    zipPostalCode: json["ZipPostalCode"],
    useCity: json["UseCity"],
    city: json["City"],
    availableCountries: List<CountryStateModel>.from(json["AvailableCountries"].map((x) => CountryStateModel.fromJson(x))),
    availableStates: List<CountryStateModel>.from(json["AvailableStates"].map((x) => CountryStateModel.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "RequestDelay": requestDelay,
    "Enabled": enabled,
    "CountryId": countryId,
    "StateProvinceId": stateProvinceId,
    "ZipPostalCode": zipPostalCode,
    "UseCity": useCity,
    "City": city,
    "AvailableCountries": List<dynamic>.from(availableCountries.map((x) => x.toJson())),
    "AvailableStates": List<dynamic>.from(availableStates.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductPrice {
  ProductPrice({
    required this.currencyCode,
    required this.oldPrice,
    required this.price,
    required this.priceWithDiscount,
    required this.priceValue,
    required this.customerEntersPrice,
    required this.callForPrice,
    required this.productId,
    required this.hidePrices,
    required this.isRental,
    required this.rentalPrice,
    required this.displayTaxShippingInfo,
    required this.basePricePAngV,
    required this.customProperties,
  });

  String currencyCode;
  dynamic oldPrice;
  String price;
  dynamic priceWithDiscount;
  double priceValue;
  bool customerEntersPrice;
  bool callForPrice;
  int productId;
  bool hidePrices;
  bool isRental;
  String rentalPrice;
  bool displayTaxShippingInfo;
  dynamic basePricePAngV;
  CustomProperties customProperties;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
    currencyCode: json["CurrencyCode"],
    oldPrice: json["OldPrice"],
    price: json["Price"],
    priceWithDiscount: json["PriceWithDiscount"],
    priceValue: json["PriceValue"],
    customerEntersPrice: json["CustomerEntersPrice"],
    callForPrice: json["CallForPrice"],
    productId: json["ProductId"],
    hidePrices: json["HidePrices"],
    isRental: json["IsRental"],
    rentalPrice: json["RentalPrice"],
    displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    basePricePAngV: json["BasePricePAngV"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CurrencyCode": currencyCode,
    "OldPrice": oldPrice,
    "Price": price,
    "PriceWithDiscount": priceWithDiscount,
    "PriceValue": priceValue,
    "CustomerEntersPrice": customerEntersPrice,
    "CallForPrice": callForPrice,
    "ProductId": productId,
    "HidePrices": hidePrices,
    "IsRental": isRental,
    "RentalPrice": rentalPrice,
    "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "BasePricePAngV": basePricePAngV,
    "CustomProperties": customProperties.toJson(),
  };
}

class ProductReviewOverview {
  ProductReviewOverview({
    required this.productId,
    required this.ratingSum,
    required this.totalReviews,
    required this.allowCustomerReviews,
    required this.canAddNewReview,
    required this.customProperties,
  });

  int productId;
  int ratingSum;
  int totalReviews;
  bool allowCustomerReviews;
  bool canAddNewReview;
  CustomProperties customProperties;

  factory ProductReviewOverview.fromJson(Map<String, dynamic> json) => ProductReviewOverview(
    productId: json["ProductId"],
    ratingSum: json["RatingSum"],
    totalReviews: json["TotalReviews"],
    allowCustomerReviews: json["AllowCustomerReviews"],
    canAddNewReview: json["CanAddNewReview"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "RatingSum": ratingSum,
    "TotalReviews": totalReviews,
    "AllowCustomerReviews": allowCustomerReviews,
    "CanAddNewReview": canAddNewReview,
    "CustomProperties": customProperties.toJson(),
  };
}


class VendorModel {
  VendorModel({
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

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    name: json["Name"] == null ? null : json["Name"],
    seName: json["SeName"] == null ? null : json["SeName"],
    productCount: json["ProductCount"] == null ? null : json["ProductCount"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name == null ? null : name,
    "SeName": seName == null ? null : seName,
    "ProductCount": productCount == null ? null : productCount,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
class TierPrice {
  TierPrice({
   required this.price,
   required this.quantity,
   required this.customProperties,
  });

  String price;
  int quantity;
  CustomProperties customProperties;

  factory TierPrice.fromJson(Map<String, dynamic> json) => TierPrice(
    price: json["Price"],
    quantity: json["Quantity"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Price": price,
    "Quantity": quantity,
    "CustomProperties": customProperties.toJson(),
  };
}