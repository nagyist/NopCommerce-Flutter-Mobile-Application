/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetPickupPointsModel getPickupPointsModelFromJson(String str) => GetPickupPointsModel.fromJson(json.decode(str));

String getPickupPointsModelToJson(GetPickupPointsModel data) => json.encode(data.toJson());

class GetPickupPointsModel {
  GetPickupPointsModel({
    required this.warnings,
    required this.pickupPoints,
    required this.allowPickupInStore,
    required this.pickupInStore,
    required this.pickupInStoreOnly,
    required this.displayPickupPointsOnMap,
    required this.googleMapsApiKey,
    required this.customProperties,
  });

  List<dynamic> warnings;
  List<PickupPoint> pickupPoints;
  bool allowPickupInStore;
  bool pickupInStore;
  bool pickupInStoreOnly;
  bool displayPickupPointsOnMap;
  String googleMapsApiKey;
  CustomProperties customProperties;

  factory GetPickupPointsModel.fromJson(Map<String, dynamic> json) => GetPickupPointsModel(
    warnings: List<dynamic>.from(json["Warnings"].map((x) => x)),
    pickupPoints: List<PickupPoint>.from(json["PickupPoints"].map((x) => PickupPoint.fromJson(x))),
    allowPickupInStore: json["AllowPickupInStore"],
    pickupInStore: json["PickupInStore"],
    pickupInStoreOnly: json["PickupInStoreOnly"],
    displayPickupPointsOnMap: json["DisplayPickupPointsOnMap"],
    googleMapsApiKey: json["GoogleMapsApiKey"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Warnings": List<dynamic>.from(warnings.map((x) => x)),
    "PickupPoints": List<dynamic>.from(pickupPoints.map((x) => x.toJson())),
    "AllowPickupInStore": allowPickupInStore,
    "PickupInStore": pickupInStore,
    "PickupInStoreOnly": pickupInStoreOnly,
    "DisplayPickupPointsOnMap": displayPickupPointsOnMap,
    "GoogleMapsApiKey": googleMapsApiKey,
    "CustomProperties": customProperties.toJson(),
  };
}

class PickupPoint {
  PickupPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.providerSystemName,
    required this.address,
    required this.city,
    required this.county,
    required this.stateName,
    required this.countryName,
    required this.zipPostalCode,
    required this.latitude,
    required this.longitude,
    required this.pickupFee,
    required this.openingHours,
    required this.customProperties,
  });

  String id;
  String name;
  dynamic description;
  String providerSystemName;
  String address;
  String city;
  dynamic county;
  String stateName;
  String countryName;
  String zipPostalCode;
  dynamic latitude;
  dynamic longitude;
  String pickupFee;
  String openingHours;
  CustomProperties customProperties;

  factory PickupPoint.fromJson(Map<String, dynamic> json) => PickupPoint(
    id: json["Id"],
    name: json["Name"],
    description: json["Description"],
    providerSystemName: json["ProviderSystemName"],
    address: json["Address"],
    city: json["City"],
    county: json["County"],
    stateName: json["StateName"],
    countryName: json["CountryName"],
    zipPostalCode: json["ZipPostalCode"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    pickupFee: json["PickupFee"],
    openingHours: json["OpeningHours"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Description": description,
    "ProviderSystemName": providerSystemName,
    "Address": address,
    "City": city,
    "County": county,
    "StateName": stateName,
    "CountryName": countryName,
    "ZipPostalCode": zipPostalCode,
    "Latitude": latitude,
    "Longitude": longitude,
    "PickupFee": pickupFee,
    "OpeningHours": openingHours,
    "CustomProperties": customProperties.toJson(),
  };
}
