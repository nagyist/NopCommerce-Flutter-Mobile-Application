/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/PagerModel.dart';

GetCustomerRewardPointsModel getCustomerRewardPointsModelFromJson(String str) => GetCustomerRewardPointsModel.fromJson(json.decode(str));

String getCustomerRewardPointsModelToJson(GetCustomerRewardPointsModel data) => json.encode(data.toJson());

class GetCustomerRewardPointsModel {
    GetCustomerRewardPointsModel({
        required this.rewardPoints,
        required this.pagerModel,
        required this.rewardPointsBalance,
        required this.rewardPointsAmount,
        required this.minimumRewardPointsBalance,
        required this.minimumRewardPointsAmount,
        required this.customProperties,
    });

    List<RewardPoint> rewardPoints;
    PagerModel pagerModel;
    int rewardPointsBalance;
    String rewardPointsAmount;
    int minimumRewardPointsBalance;
    String minimumRewardPointsAmount;
    CustomProperties customProperties;

    factory GetCustomerRewardPointsModel.fromJson(Map<String, dynamic> json) => GetCustomerRewardPointsModel(
        rewardPoints: List<RewardPoint>.from(json["RewardPoints"].map((x) => RewardPoint.fromJson(x))),
        pagerModel: PagerModel.fromJson(json["PagerModel"]),
        rewardPointsBalance: json["RewardPointsBalance"],
        rewardPointsAmount: json["RewardPointsAmount"],
        minimumRewardPointsBalance: json["MinimumRewardPointsBalance"],
        minimumRewardPointsAmount: json["MinimumRewardPointsAmount"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "RewardPoints": List<dynamic>.from(rewardPoints.map((x) => x.toJson())),
        "PagerModel": pagerModel.toJson(),
        "RewardPointsBalance": rewardPointsBalance,
        "RewardPointsAmount": rewardPointsAmount,
        "MinimumRewardPointsBalance": minimumRewardPointsBalance,
        "MinimumRewardPointsAmount": minimumRewardPointsAmount,
        "CustomProperties": customProperties.toJson(),
    };
}

class RewardPoint {
    RewardPoint({
        required this.points,
        required this.pointsBalance,
        required this.message,
        required this.createdOn,
        required this.endDate,
        required this.id,
        required this.customProperties,
    });

    int points;
    String pointsBalance;
    String message;
    DateTime createdOn;
    DateTime? endDate;
    int id;
    CustomProperties customProperties;

    factory RewardPoint.fromJson(Map<String, dynamic> json) => RewardPoint(
        points: json["Points"],
        pointsBalance: json["PointsBalance"],
        message: json["Message"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        endDate: json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "Points": points,
        "PointsBalance": pointsBalance,
        "Message": message,
        "CreatedOn": createdOn.toIso8601String(),
        "EndDate": endDate == null ? null : endDate!.toIso8601String(),
        "Id": id,
        "CustomProperties": customProperties.toJson(),
    };
}
