/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

ManualPaymentModel manualPaymentModelFromJson(String str) => ManualPaymentModel.fromJson(json.decode(str));

String manualPaymentModelToJson(ManualPaymentModel data) => json.encode(data.toJson());

class ManualPaymentModel {
  ManualPaymentModel({
    required this.creditCardType,
    required this.creditCardTypes,
    required this.cardholderName,
    required this.cardNumber,
    required this.expireMonth,
    required this.expireYear,
    required this.expireMonths,
    required this.expireYears,
    required this.cardCode,
    required this.paymentMethodName,
    required this.paymentMethodType,
  });

  dynamic creditCardType;
  List<CreditCardType> creditCardTypes;
  dynamic cardholderName;
  dynamic cardNumber;
  dynamic expireMonth;
  dynamic expireYear;
  List<CreditCardType> expireMonths;
  List<CreditCardType> expireYears;
  dynamic cardCode;
  String paymentMethodName;
  String paymentMethodType;

  factory ManualPaymentModel.fromJson(Map<String, dynamic> json) => ManualPaymentModel(
    creditCardType: json["CreditCardType"],
    creditCardTypes: List<CreditCardType>.from(json["CreditCardTypes"].map((x) => CreditCardType.fromJson(x))),
    cardholderName: json["CardholderName"],
    cardNumber: json["CardNumber"],
    expireMonth: json["ExpireMonth"],
    expireYear: json["ExpireYear"],
    expireMonths: List<CreditCardType>.from(json["ExpireMonths"].map((x) => CreditCardType.fromJson(x))),
    expireYears: List<CreditCardType>.from(json["ExpireYears"].map((x) => CreditCardType.fromJson(x))),
    cardCode: json["CardCode"],
    paymentMethodName: json["PaymentMethodName"],
    paymentMethodType: json["PaymentMethodType"],
  );

  Map<String, dynamic> toJson() => {
    "CreditCardType": creditCardType,
    "CreditCardTypes": List<dynamic>.from(creditCardTypes.map((x) => x.toJson())),
    "CardholderName": cardholderName,
    "CardNumber": cardNumber,
    "ExpireMonth": expireMonth,
    "ExpireYear": expireYear,
    "ExpireMonths": List<dynamic>.from(expireMonths.map((x) => x.toJson())),
    "ExpireYears": List<dynamic>.from(expireYears.map((x) => x.toJson())),
    "CardCode": cardCode,
    "PaymentMethodName": paymentMethodName,
    "PaymentMethodType": paymentMethodType,
  };
}

class CreditCardType {
  CreditCardType({
    required this.disabled,
    required this.group,
    required this.selected,
    required this.text,
    required this.value,
  });

  bool disabled;
  dynamic group;
  bool selected;
  String text;
  String value;

  factory CreditCardType.fromJson(Map<String, dynamic> json) => CreditCardType(
    disabled: json["Disabled"],
    group: json["Group"],
    selected: json["Selected"],
    text: json["Text"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Disabled": disabled,
    "Group": group,
    "Selected": selected,
    "Text": text,
    "Value": value,
  };
}
