/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetPaymentMethodsModel getPaymentMethodsModelFromJson(String str) => GetPaymentMethodsModel.fromJson(json.decode(str));

String getPaymentMethodsModelToJson(GetPaymentMethodsModel data) => json.encode(data.toJson());

class GetPaymentMethodsModel {
  GetPaymentMethodsModel({
    required this.paymentMethods,
    required this.displayRewardPoints,
    required this.rewardPointsBalance,
    required this.rewardPointsAmount,
    required this.rewardPointsEnoughToPayForOrder,
    required this.useRewardPoints,
    required this.customProperties,
  });

  List<PaymentMethod> paymentMethods;
  bool displayRewardPoints;
  int rewardPointsBalance;
  String rewardPointsAmount;
  bool rewardPointsEnoughToPayForOrder;
  bool useRewardPoints;
  CustomProperties customProperties;

  factory GetPaymentMethodsModel.fromJson(Map<String, dynamic> json) => GetPaymentMethodsModel(
    paymentMethods: List<PaymentMethod>.from(json["PaymentMethods"].map((x) => PaymentMethod.fromJson(x))),
    displayRewardPoints: json["DisplayRewardPoints"],
    rewardPointsBalance: json["RewardPointsBalance"],
    rewardPointsAmount: json["RewardPointsAmount"],
    rewardPointsEnoughToPayForOrder: json["RewardPointsEnoughToPayForOrder"],
    useRewardPoints: json["UseRewardPoints"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "PaymentMethods": List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
    "DisplayRewardPoints": displayRewardPoints,
    "RewardPointsBalance": rewardPointsBalance,
    "RewardPointsAmount": rewardPointsAmount,
    "RewardPointsEnoughToPayForOrder": rewardPointsEnoughToPayForOrder,
    "UseRewardPoints": useRewardPoints,
    "CustomProperties": customProperties.toJson(),
  };
}


class PaymentMethod {
  PaymentMethod({
    required this.paymentMethodSystemName,
    required this.name,
    required this.description,
    required this.fee,
    required this.selected,
    required this.logoUrl,
    required this.customProperties,
  });

  String paymentMethodSystemName;
  String name;
  String description;
  dynamic fee;
  bool selected;
  String logoUrl;
  CustomProperties customProperties;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    paymentMethodSystemName: json["PaymentMethodSystemName"],
    name: json["Name"],
    description: json["Description"],
    fee: json["Fee"],
    selected: json["Selected"],
    logoUrl: json["LogoUrl"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "PaymentMethodSystemName": paymentMethodSystemName,
    "Name": name,
    "Description": description,
    "Fee": fee,
    "Selected": selected,
    "LogoUrl": logoUrl,
    "CustomProperties": customProperties.toJson(),
  };
}
