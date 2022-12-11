/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'dart:convert';
import 'package:nopcommerce/Models/CustomProperties.dart';

GetGiftCardBalanceResponseModel getGiftCardBalanceResponseModelFromJson(String str) => GetGiftCardBalanceResponseModel.fromJson(json.decode(str));

String getGiftCardBalanceResponseModelToJson(GetGiftCardBalanceResponseModel data) => json.encode(data.toJson());

class GetGiftCardBalanceResponseModel {
  GetGiftCardBalanceResponseModel({
    required this.result,
    required this.message,
    required this.giftCardCode,
    required this.customProperties,
  });

  dynamic result;
  dynamic message;
  dynamic giftCardCode;
  CustomProperties customProperties;

  factory GetGiftCardBalanceResponseModel.fromJson(Map<String, dynamic> json) => GetGiftCardBalanceResponseModel(
    result: json["Result"],
    message: json["Message"],
    giftCardCode: json["GiftCardCode"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "GiftCardCode": giftCardCode,
    "CustomProperties": customProperties.toJson(),
  };
}