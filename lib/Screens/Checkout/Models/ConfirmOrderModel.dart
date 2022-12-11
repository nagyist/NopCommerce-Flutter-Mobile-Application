/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';

ConfirmOrderModel confirmOrderModelFromJson(String str) => ConfirmOrderModel.fromJson(json.decode(str));

String confirmOrderModelToJson(ConfirmOrderModel data) => json.encode(data.toJson());

class ConfirmOrderModel {
  ConfirmOrderModel({
    required this.success,
    required this.orderId,
    required this.redirectionUrl,
    required this.errors,
  });

  bool success;
  int orderId;
  String redirectionUrl;
  List<dynamic> errors;

  factory ConfirmOrderModel.fromJson(Map<String, dynamic> json) => ConfirmOrderModel(
    success: json["Success"],
    orderId: json["OrderId"],
    redirectionUrl: json["RedirectionUrl"],
    errors: List<dynamic>.from(json["Errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "OrderId": orderId,
    "RedirectionUrl": redirectionUrl,
    "Errors": List<dynamic>.from(errors.map((x) => x)),
  };
}
