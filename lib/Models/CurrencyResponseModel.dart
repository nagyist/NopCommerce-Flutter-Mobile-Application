/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

CurrencyResponseModel currencyResponseModelFromJson(String str) => CurrencyResponseModel.fromJson(json.decode(str));

String currencyResponseModelToJson(CurrencyResponseModel data) => json.encode(data.toJson());

class CurrencyResponseModel {
  CurrencyResponseModel({
    required this.availableCurrencies,
    required this.currentCurrencyId,
    required this.customProperties,
  });

  List<AvailableCurrency> availableCurrencies;
  int currentCurrencyId;
  CustomProperties customProperties;

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) => CurrencyResponseModel(
    availableCurrencies: List<AvailableCurrency>.from(json["AvailableCurrencies"].map((x) => AvailableCurrency.fromJson(x))),
    currentCurrencyId: json["CurrentCurrencyId"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "AvailableCurrencies": List<dynamic>.from(availableCurrencies.map((x) => x.toJson())),
    "CurrentCurrencyId": currentCurrencyId,
    "CustomProperties": customProperties.toJson(),
  };
}

class AvailableCurrency {
  AvailableCurrency({
    required this.name,
    required this.currencySymbol,
    required this.id,
    required this.customProperties,
  });

  String name;
  String currencySymbol;
  int id;
  CustomProperties customProperties;

  factory AvailableCurrency.fromJson(Map<String, dynamic> json) => AvailableCurrency(
    name: json["Name"],
    currencySymbol: json["CurrencySymbol"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "CurrencySymbol": currencySymbol,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
