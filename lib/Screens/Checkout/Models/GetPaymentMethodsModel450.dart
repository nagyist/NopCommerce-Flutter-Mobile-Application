/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPaymentMethodsModel.dart';

GetPaymentMethods getPaymentMethodsFromJson(String str) => GetPaymentMethods.fromJson(json.decode(str));

String getPaymentMethodsToJson(GetPaymentMethods data) => json.encode(data.toJson());

class GetPaymentMethods {
  GetPaymentMethods({
    required this.paymentMethods,
    required this.displayRewardPoints,
    required this.rewardPointsBalance,
    required this.rewardPointsToUse,
    required this.rewardPointsToUseAmount,
    required this.rewardPointsEnoughToPayForOrder,
    required this.useRewardPoints,
    required this.customProperties,
  });

  List<PaymentMethod> paymentMethods;
  bool displayRewardPoints;
  int rewardPointsBalance;
  int rewardPointsToUse;
  String rewardPointsToUseAmount;
  bool rewardPointsEnoughToPayForOrder;
  bool useRewardPoints;
  CustomProperties customProperties;

  factory GetPaymentMethods.fromJson(Map<String, dynamic> json) => GetPaymentMethods(
    paymentMethods: List<PaymentMethod>.from(json["PaymentMethods"].map((x) => PaymentMethod.fromJson(x))),
    displayRewardPoints: json["DisplayRewardPoints"],
    rewardPointsBalance: json["RewardPointsBalance"],
    rewardPointsToUse: json["RewardPointsToUse"],
    rewardPointsToUseAmount: json["RewardPointsToUseAmount"],
    rewardPointsEnoughToPayForOrder: json["RewardPointsEnoughToPayForOrder"],
    useRewardPoints: json["UseRewardPoints"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "PaymentMethods": List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
    "DisplayRewardPoints": displayRewardPoints,
    "RewardPointsBalance": rewardPointsBalance,
    "RewardPointsToUse": rewardPointsToUse,
    "RewardPointsToUseAmount": rewardPointsToUseAmount,
    "RewardPointsEnoughToPayForOrder": rewardPointsEnoughToPayForOrder,
    "UseRewardPoints": useRewardPoints,
    "CustomProperties": customProperties.toJson(),
  };
}


