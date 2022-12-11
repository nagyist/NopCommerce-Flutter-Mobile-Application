/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetEmailWishlistResponseModel getEmailWishlistResponseModelFromJson(String str) => GetEmailWishlistResponseModel.fromJson(json.decode(str));

String getEmailWishilistResponseModelToJson(GetEmailWishlistResponseModel data) => json.encode(data.toJson());

class GetEmailWishlistResponseModel {
  GetEmailWishlistResponseModel({
    required this.friendEmail,
    required this.yourEmailAddress,
    required this.personalMessage,
    required this.successfullySent,
    required this.result,
    required this.displayCaptcha,
    required this.customProperties,
  });

  String friendEmail;
  String yourEmailAddress;
  String personalMessage;
  bool successfullySent;
  String result;
  bool displayCaptcha;
  CustomProperties customProperties;

  factory GetEmailWishlistResponseModel.fromJson(Map<String, dynamic> json) => GetEmailWishlistResponseModel(
    friendEmail: json["FriendEmail"],
    yourEmailAddress: json["YourEmailAddress"],
    personalMessage: json["PersonalMessage"],
    successfullySent: json["SuccessfullySent"],
    result: json["Result"],
    displayCaptcha: json["DisplayCaptcha"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "FriendEmail": friendEmail,
    "YourEmailAddress": yourEmailAddress,
    "PersonalMessage": personalMessage,
    "SuccessfullySent": successfullySent,
    "Result": result,
    "DisplayCaptcha": displayCaptcha,
    "CustomProperties": customProperties.toJson(),
  };
}