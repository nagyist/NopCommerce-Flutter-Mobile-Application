/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

ProductEstimateShippingModel productEstimateShippingModelFromJson(String str) => ProductEstimateShippingModel.fromJson(json.decode(str));

String productEstimateShippingModelToJson(ProductEstimateShippingModel data) => json.encode(data.toJson());

class ProductEstimateShippingModel {
  ProductEstimateShippingModel({
    required this.shippingOptions,
    required this.success,
    required this.errors,
    required this.customProperties,
  });

  List<ShippingOption> shippingOptions;
  bool success;
  List<dynamic> errors;
  CustomProperties customProperties;

  factory ProductEstimateShippingModel.fromJson(Map<String, dynamic> json) => ProductEstimateShippingModel(
    shippingOptions: List<ShippingOption>.from(json["ShippingOptions"].map((x) => ShippingOption.fromJson(x))),
    success: json["Success"],
    errors: List<dynamic>.from(json["Errors"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ShippingOptions": List<dynamic>.from(shippingOptions.map((x) => x.toJson())),
    "Success": success,
    "Errors": List<dynamic>.from(errors.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}
class ShippingOption {
  ShippingOption({
    required this.name,
    required this.shippingRateComputationMethodSystemName,
    required this.description,
    required this.price,
    required this.rate,
    required this.deliveryDateFormat,
    required this.selected,
    required this.customProperties,
  });

  String name;
  String shippingRateComputationMethodSystemName;
  String description;
  String price;
  double rate;
  String deliveryDateFormat;
  bool selected;
  CustomProperties customProperties;

  factory ShippingOption.fromJson(Map<String, dynamic> json) => ShippingOption(
    name: json["Name"],
    shippingRateComputationMethodSystemName: json["ShippingRateComputationMethodSystemName"],
    description: json["Description"],
    price: json["Price"],
    rate: json["Rate"],
    deliveryDateFormat: json["DeliveryDateFormat"] == null ? null : json["DeliveryDateFormat"],
    selected: json["Selected"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "ShippingRateComputationMethodSystemName": shippingRateComputationMethodSystemName,
    "Description": description,
    "Price": price,
    "Rate": rate,
    "DeliveryDateFormat": deliveryDateFormat == null ? null : deliveryDateFormat,
    "Selected": selected,
    "CustomProperties": customProperties.toJson(),
  };
}
