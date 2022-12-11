/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

PaypalStandardModel paypalStandardModelFromJson(String str) => PaypalStandardModel.fromJson(json.decode(str));

String paypalStandardModelToJson(PaypalStandardModel data) => json.encode(data.toJson());

class PaypalStandardModel {
  PaypalStandardModel({
    required this.redirectionTip,
    required this.redirectToConfirmOrder,
    required this.paymentMethodName,
    required this.paymentMethodType,
  });

  String redirectionTip;
  bool redirectToConfirmOrder;
  String paymentMethodName;
  String paymentMethodType;

  factory PaypalStandardModel.fromJson(Map<String, dynamic> json) => PaypalStandardModel(
    redirectionTip: json["RedirectionTip"],
    redirectToConfirmOrder: json["RedirectToConfirmOrder"],
    paymentMethodName: json["PaymentMethodName"],
    paymentMethodType: json["PaymentMethodType"],
  );

  Map<String, dynamic> toJson() => {
    "RedirectionTip": redirectionTip,
    "RedirectToConfirmOrder": redirectToConfirmOrder,
    "PaymentMethodName": paymentMethodName,
    "PaymentMethodType": paymentMethodType,
  };
}
