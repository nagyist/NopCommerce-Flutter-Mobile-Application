/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetShippingMethodsModel getShippingMethodsModelFromJson(String str) => GetShippingMethodsModel.fromJson(json.decode(str));

String getShippingMethodsModelToJson(GetShippingMethodsModel data) => json.encode(data.toJson());

class GetShippingMethodsModel {
  GetShippingMethodsModel({
    required this.shippingMethods,
    required this.notifyCustomerAboutShippingFromMultipleLocations,
    required this.warnings,
    required this.displayPickupInStore,
    required this.pickupPointsModel,
    required this.customProperties,
  });

  List<ShippingMethod> shippingMethods;
  bool notifyCustomerAboutShippingFromMultipleLocations;
  List<dynamic> warnings;
  bool displayPickupInStore;
  dynamic pickupPointsModel;
  CustomProperties customProperties;

  factory GetShippingMethodsModel.fromJson(Map<String, dynamic> json) => GetShippingMethodsModel(
    shippingMethods: List<ShippingMethod>.from(json["ShippingMethods"].map((x) => ShippingMethod.fromJson(x))),
    notifyCustomerAboutShippingFromMultipleLocations: json["NotifyCustomerAboutShippingFromMultipleLocations"],
    warnings: List<dynamic>.from(json["Warnings"].map((x) => x)),
    displayPickupInStore: json["DisplayPickupInStore"],
    pickupPointsModel: json["PickupPointsModel"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ShippingMethods": List<dynamic>.from(shippingMethods.map((x) => x.toJson())),
    "NotifyCustomerAboutShippingFromMultipleLocations": notifyCustomerAboutShippingFromMultipleLocations,
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "DisplayPickupInStore": displayPickupInStore,
    "PickupPointsModel": pickupPointsModel,
    "CustomProperties": customProperties.toJson(),
  };
}

class ShippingMethod {
  ShippingMethod({
    required this.shippingRateComputationMethodSystemName,
    required this.name,
    required this.description,
    required this.fee,
    required this.selected,
    required this.shippingOption,
    required this.customProperties,
  });

  String shippingRateComputationMethodSystemName;
  String name;
  String description;
  String fee;
  bool selected;
  String shippingOption;
  CustomProperties customProperties;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
    shippingRateComputationMethodSystemName: json["ShippingRateComputationMethodSystemName"],
    name: json["Name"],
    description: json["Description"],
    fee: json["Fee"],
    selected: json["Selected"],
    shippingOption: json["ShippingOption"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ShippingRateComputationMethodSystemName": shippingRateComputationMethodSystemName,
    "Name": name,
    "Description": description,
    "Fee": fee,
    "Selected": selected,
    "ShippingOption": shippingOption,
    "CustomProperties": customProperties.toJson(),
  };
}
