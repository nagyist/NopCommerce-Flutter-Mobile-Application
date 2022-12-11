/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



import 'dart:convert';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';

EstimateShippingResponseModel estimateShippingResponseModelFromJson(String str) => EstimateShippingResponseModel.fromJson(json.decode(str));

String estimateShippingResponseModelToJson(EstimateShippingResponseModel data) => json.encode(data.toJson());

class EstimateShippingResponseModel {
  EstimateShippingResponseModel({
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

  int requestDelay;
  bool enabled;
  int countryId;
  int stateProvinceId;
  String zipPostalCode;
  bool useCity;
  String city;
  List<CountryStateModel> availableCountries;
  List<CountryStateModel> availableStates;
  CustomProperties customProperties;

  factory EstimateShippingResponseModel.fromJson(Map<String, dynamic> json) => EstimateShippingResponseModel(
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

