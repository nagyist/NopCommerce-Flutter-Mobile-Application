/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/CustomPropertiesValues.dart';
import 'package:nopcommerce/Models/GiftCardModel.dart';
import 'package:nopcommerce/Models/OrderDetailsItemModel.dart';
import 'package:nopcommerce/Models/OrderNote.dart';
import 'package:nopcommerce/Models/ShipmentModel.dart';
import 'package:nopcommerce/Models/TaxRateModel.dart';

GetOrderDetailsModel getOrderDetailsModelFromJson(String str) => GetOrderDetailsModel.fromJson(json.decode(str));

String getOrderDetailsModelToJson(GetOrderDetailsModel data) => json.encode(data.toJson());

class GetOrderDetailsModel {
  GetOrderDetailsModel({
    required this.printMode,
    required this.pdfInvoiceDisabled,
    required this.customOrderNumber,
    required this.createdOn,
    required this.orderStatus,
    required this.isReOrderAllowed,
    required this.isReturnRequestAllowed,
    required this.isShippable,
    required this.pickupInStore,
    required this.pickupAddress,
    required this.shippingStatus,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.shipments,
    required this.billingAddress,
    required this.vatNumber,
    required this.paymentMethod,
    required this.paymentMethodStatus,
    required this.canRePostProcessPayment,
    required this.customValues,
    required this.orderSubtotal,
    required this.orderSubTotalDiscount,
    required this.orderShipping,
    required this.paymentMethodAdditionalFee,
    required this.checkoutAttributeInfo,
    required this.pricesIncludeTax,
    required this.displayTaxShippingInfo,
    required this.tax,
    required this.taxRates,
    required this.displayTax,
    required this.displayTaxRates,
    required this.orderTotalDiscount,
    required this.redeemedRewardPoints,
    required this.redeemedRewardPointsAmount,
    required this.orderTotal,
    required this.giftCards,
    required this.showSku,
    required this.items,
    required this.orderNotes,
    required this.showVendorName,
    required this.id,
    required this.customProperties,
  });

  bool printMode;
  bool pdfInvoiceDisabled;
  String customOrderNumber;
  DateTime createdOn;
  String orderStatus;
  bool isReOrderAllowed;
  bool isReturnRequestAllowed;
  bool isShippable;
  bool pickupInStore;
  Address pickupAddress;
  String shippingStatus;
  Address shippingAddress;
  String shippingMethod;
  List<Shipment> shipments;
  Address billingAddress;
  dynamic vatNumber;
  String paymentMethod;
  String paymentMethodStatus;
  bool canRePostProcessPayment;
  CustomPropertiesValues customValues;
  String orderSubtotal;
  dynamic orderSubTotalDiscount;
  String orderShipping;
  dynamic paymentMethodAdditionalFee;
  String checkoutAttributeInfo;
  bool pricesIncludeTax;
  bool displayTaxShippingInfo;
  String tax;
  List<TaxRate> taxRates;
  bool displayTax;
  bool displayTaxRates;
  dynamic orderTotalDiscount;
  int redeemedRewardPoints;
  dynamic redeemedRewardPointsAmount;
  String orderTotal;
  List<GiftCard> giftCards;
  bool showSku;
  List<OrderDetailsItem> items;
  List<OrderNote> orderNotes;
  bool showVendorName;
  int id;
  CustomProperties customProperties;

  factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) => GetOrderDetailsModel(
    printMode: json["PrintMode"],
    pdfInvoiceDisabled: json["PdfInvoiceDisabled"],
    customOrderNumber: json["CustomOrderNumber"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    orderStatus: json["OrderStatus"],
    isReOrderAllowed: json["IsReOrderAllowed"],
    isReturnRequestAllowed: json["IsReturnRequestAllowed"],
    isShippable: json["IsShippable"],
    pickupInStore: json["PickupInStore"],
    pickupAddress: Address.fromJson(json["PickupAddress"]),
    shippingStatus: json["ShippingStatus"],
    shippingAddress: Address.fromJson(json["ShippingAddress"]),
    shippingMethod: json["ShippingMethod"],
    shipments: List<Shipment>.from(json["Shipments"].map((x) => Shipment.fromJson(x))),
    billingAddress: Address.fromJson(json["BillingAddress"]),
    vatNumber: json["VatNumber"],
    paymentMethod: json["PaymentMethod"],
    paymentMethodStatus: json["PaymentMethodStatus"],
    canRePostProcessPayment: json["CanRePostProcessPayment"],
    customValues: CustomPropertiesValues.fromJson(json["CustomValues"]),
    orderSubtotal: json["OrderSubtotal"],
    orderSubTotalDiscount: json["OrderSubTotalDiscount"],
    orderShipping: json["OrderShipping"],
    paymentMethodAdditionalFee: json["PaymentMethodAdditionalFee"],
    checkoutAttributeInfo: json["CheckoutAttributeInfo"],
    pricesIncludeTax: json["PricesIncludeTax"],
    displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
    tax: json["Tax"],
    taxRates: List<TaxRate>.from(json["TaxRates"].map((x) => TaxRate.fromJson(x))),
    displayTax: json["DisplayTax"],
    displayTaxRates: json["DisplayTaxRates"],
    orderTotalDiscount: json["OrderTotalDiscount"],
    redeemedRewardPoints: json["RedeemedRewardPoints"],
    redeemedRewardPointsAmount: json["RedeemedRewardPointsAmount"],
    orderTotal: json["OrderTotal"],
    giftCards: List<GiftCard>.from(json["GiftCards"].map((x) => GiftCard.fromJson(x))),
    showSku: json["ShowSku"],
    items: List<OrderDetailsItem>.from(json["Items"].map((x) => OrderDetailsItem.fromJson(x))),
    orderNotes: List<OrderNote>.from(json["OrderNotes"].map((x) => OrderNote.fromJson(x))),
    showVendorName: json["ShowVendorName"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "PrintMode": printMode,
    "PdfInvoiceDisabled": pdfInvoiceDisabled,
    "CustomOrderNumber": customOrderNumber,
    "CreatedOn": createdOn.toIso8601String(),
    "OrderStatus": orderStatus,
    "IsReOrderAllowed": isReOrderAllowed,
    "IsReturnRequestAllowed": isReturnRequestAllowed,
    "IsShippable": isShippable,
    "PickupInStore": pickupInStore,
    "PickupAddress": pickupAddress.toJson(),
    "ShippingStatus": shippingStatus,
    "ShippingAddress": shippingAddress.toJson(),
    "ShippingMethod": shippingMethod,
    "Shipments": List<dynamic>.from(shipments.map((x) => x.toJson())),
    "BillingAddress": billingAddress.toJson(),
    "VatNumber": vatNumber,
    "PaymentMethod": paymentMethod,
    "PaymentMethodStatus": paymentMethodStatus,
    "CanRePostProcessPayment": canRePostProcessPayment,
    "CustomValues": customValues.toJson(),
    "OrderSubtotal": orderSubtotal,
    "OrderSubTotalDiscount": orderSubTotalDiscount,
    "OrderShipping": orderShipping,
    "PaymentMethodAdditionalFee": paymentMethodAdditionalFee,
    "CheckoutAttributeInfo": checkoutAttributeInfo,
    "PricesIncludeTax": pricesIncludeTax,
    "DisplayTaxShippingInfo": displayTaxShippingInfo,
    "Tax": tax,
    "TaxRates": List<dynamic>.from(taxRates.map((x) => x.toJson())),
    "DisplayTax": displayTax,
    "DisplayTaxRates": displayTaxRates,
    "OrderTotalDiscount": orderTotalDiscount,
    "RedeemedRewardPoints": redeemedRewardPoints,
    "RedeemedRewardPointsAmount": redeemedRewardPointsAmount,
    "OrderTotal": orderTotal,
    "GiftCards": List<dynamic>.from(giftCards.map((x) => x.toJson())),
    "ShowSku": showSku,
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
    "OrderNotes": List<dynamic>.from(orderNotes.map((x) => x)),
    "ShowVendorName": showVendorName,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Address {
  Address({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyEnabled,
    required this.companyRequired,
    required this.company,
    required this.countryEnabled,
    required this.countryId,
    required this.countryName,
    required this.stateProvinceEnabled,
    required this.stateProvinceId,
    required this.stateProvinceName,
    required this.countyEnabled,
    required this.countyRequired,
    required this.county,
    required this.cityEnabled,
    required this.cityRequired,
    required this.city,
    required this.streetAddressEnabled,
    required this.streetAddressRequired,
    required this.address1,
    required this.streetAddress2Enabled,
    required this.streetAddress2Required,
    required this.address2,
    required this.zipPostalCodeEnabled,
    required this.zipPostalCodeRequired,
    required this.zipPostalCode,
    required this.phoneEnabled,
    required this.phoneRequired,
    required this.phoneNumber,
    required this.faxEnabled,
    required this.faxRequired,
    required this.faxNumber,
    required this.availableCountries,
    required this.availableStates,
    required this.formattedCustomAddressAttributes,
    required this.customAddressAttributes,
    required this.id,
    required this.customProperties,
  });

  String firstName;
  String lastName;
  String email;
  bool companyEnabled;
  bool companyRequired;
  String company;
  bool countryEnabled;
  int countryId;
  String countryName;
  bool stateProvinceEnabled;
  int stateProvinceId;
  String stateProvinceName;
  bool countyEnabled;
  bool countyRequired;
  String county;
  bool cityEnabled;
  bool cityRequired;
  String city;
  bool streetAddressEnabled;
  bool streetAddressRequired;
  String address1;
  bool streetAddress2Enabled;
  bool streetAddress2Required;
  String address2;
  bool zipPostalCodeEnabled;
  bool zipPostalCodeRequired;
  String zipPostalCode;
  bool phoneEnabled;
  bool phoneRequired;
  String phoneNumber;
  bool faxEnabled;
  bool faxRequired;
  String faxNumber;
  List<dynamic> availableCountries;
  List<dynamic> availableStates;
  String formattedCustomAddressAttributes;
  List<CustomAddressAttribute> customAddressAttributes;
  int id;
  CustomProperties customProperties;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    firstName: json["FirstName"] == null ? null : json["FirstName"],
    lastName: json["LastName"] == null ? null : json["LastName"],
    email: json["Email"] == null ? null : json["Email"],
    companyEnabled: json["CompanyEnabled"],
    companyRequired: json["CompanyRequired"],
    company: json["Company"] == null ? null : json["Company"],
    countryEnabled: json["CountryEnabled"],
    countryId: json["CountryId"] == null ? null : json["CountryId"],
    countryName: json["CountryName"] == null ? null : json["CountryName"],
    stateProvinceEnabled: json["StateProvinceEnabled"],
    stateProvinceId: json["StateProvinceId"] == null ? null : json["StateProvinceId"],
    stateProvinceName: json["StateProvinceName"] == null ? null : json["StateProvinceName"],
    countyEnabled: json["CountyEnabled"],
    countyRequired: json["CountyRequired"],
    county: json["County"] == null ? null : json["County"],
    cityEnabled: json["CityEnabled"],
    cityRequired: json["CityRequired"],
    city: json["City"] == null ? null : json["City"],
    streetAddressEnabled: json["StreetAddressEnabled"],
    streetAddressRequired: json["StreetAddressRequired"],
    address1: json["Address1"] == null ? null : json["Address1"],
    streetAddress2Enabled: json["StreetAddress2Enabled"],
    streetAddress2Required: json["StreetAddress2Required"],
    address2: json["Address2"] == null ? null : json["Address2"],
    zipPostalCodeEnabled: json["ZipPostalCodeEnabled"],
    zipPostalCodeRequired: json["ZipPostalCodeRequired"],
    zipPostalCode: json["ZipPostalCode"] == null ? null : json["ZipPostalCode"],
    phoneEnabled: json["PhoneEnabled"],
    phoneRequired: json["PhoneRequired"],
    phoneNumber: json["PhoneNumber"] == null ? null : json["PhoneNumber"],
    faxEnabled: json["FaxEnabled"],
    faxRequired: json["FaxRequired"],
    faxNumber: json["FaxNumber"] == null ? null : json["FaxNumber"],
    availableCountries: List<dynamic>.from(json["AvailableCountries"].map((x) => x)),
    availableStates: List<dynamic>.from(json["AvailableStates"].map((x) => x)),
    formattedCustomAddressAttributes: json["FormattedCustomAddressAttributes"] == null ? null : json["FormattedCustomAddressAttributes"],
    customAddressAttributes: List<CustomAddressAttribute>.from(json["CustomAddressAttributes"].map((x) => CustomAddressAttribute.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName == null ? null : firstName,
    "LastName": lastName == null ? null : lastName,
    "Email": email == null ? null : email,
    "CompanyEnabled": companyEnabled,
    "CompanyRequired": companyRequired,
    "Company": company == null ? null : company,
    "CountryEnabled": countryEnabled,
    "CountryId": countryId == null ? null : countryId,
    "CountryName": countryName == null ? null : countryName,
    "StateProvinceEnabled": stateProvinceEnabled,
    "StateProvinceId": stateProvinceId == null ? null : stateProvinceId,
    "StateProvinceName": stateProvinceName == null ? null : stateProvinceName,
    "CountyEnabled": countyEnabled,
    "CountyRequired": countyRequired,
    "County": county == null ? null : county,
    "CityEnabled": cityEnabled,
    "CityRequired": cityRequired,
    "City": city == null ? null : city,
    "StreetAddressEnabled": streetAddressEnabled,
    "StreetAddressRequired": streetAddressRequired,
    "Address1": address1 == null ? null : address1,
    "StreetAddress2Enabled": streetAddress2Enabled,
    "StreetAddress2Required": streetAddress2Required,
    "Address2": address2 == null ? null : address2,
    "ZipPostalCodeEnabled": zipPostalCodeEnabled,
    "ZipPostalCodeRequired": zipPostalCodeRequired,
    "ZipPostalCode": zipPostalCode == null ? null : zipPostalCode,
    "PhoneEnabled": phoneEnabled,
    "PhoneRequired": phoneRequired,
    "PhoneNumber": phoneNumber == null ? null : phoneNumber,
    "FaxEnabled": faxEnabled,
    "FaxRequired": faxRequired,
    "FaxNumber": faxNumber == null ? null : faxNumber,
    "AvailableCountries": List<dynamic>.from(availableCountries.map((x) => x)),
    "AvailableStates": List<dynamic>.from(availableStates.map((x) => x)),
    "FormattedCustomAddressAttributes": formattedCustomAddressAttributes == null ? null : formattedCustomAddressAttributes,
    "CustomAddressAttributes": List<dynamic>.from(customAddressAttributes.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class CustomAddressAttribute {
  CustomAddressAttribute({
    required this.name,
    required this.isRequired,
    required this.defaultValue,
    required this.attributeControlType,
    required this.values,
    required this.id,
    required this.customProperties,
  });

  String name;
  bool isRequired;
  dynamic defaultValue;
  String attributeControlType;
  List<Value> values;
  int id;
  CustomProperties customProperties;

  factory CustomAddressAttribute.fromJson(Map<String, dynamic> json) => CustomAddressAttribute(
    name: json["Name"],
    isRequired: json["IsRequired"],
    defaultValue: json["DefaultValue"],
    attributeControlType: json["AttributeControlType"],
    values: List<Value>.from(json["Values"].map((x) => Value.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "IsRequired": isRequired,
    "DefaultValue": defaultValue,
    "AttributeControlType": attributeControlType,
    "Values": List<dynamic>.from(values.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Value {
  Value({
    required this.name,
    required this.isPreSelected,
    required this.id,
    required this.customProperties,
  });

  String name;
  bool isPreSelected;
  int id;
  CustomProperties customProperties;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    name: json["Name"],
    isPreSelected: json["IsPreSelected"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "IsPreSelected": isPreSelected,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
