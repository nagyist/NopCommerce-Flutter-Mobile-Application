/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

GetPaymentInfoNetBankingModel getPaymentInfoNetBankingModelFromJson(String str) => GetPaymentInfoNetBankingModel.fromJson(json.decode(str));

String getPaymentInfoNetBankingModelToJson(GetPaymentInfoNetBankingModel data) => json.encode(data.toJson());

class GetPaymentInfoNetBankingModel {
    GetPaymentInfoNetBankingModel({
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

    dynamic cardholderName;
    dynamic cardNumber;
    dynamic expireMonth;
    dynamic expireYear;
    List<Expire> expireMonths;
    List<Expire> expireYears;
    dynamic cardCode;
    String paymentMethodName;
    String paymentMethodType;

    factory GetPaymentInfoNetBankingModel.fromJson(Map<String, dynamic> json) => GetPaymentInfoNetBankingModel(
        cardholderName: json["CardholderName"],
        cardNumber: json["CardNumber"],
        expireMonth: json["ExpireMonth"],
        expireYear: json["ExpireYear"],
        expireMonths: List<Expire>.from(json["ExpireMonths"].map((x) => Expire.fromJson(x))),
        expireYears: List<Expire>.from(json["ExpireYears"].map((x) => Expire.fromJson(x))),
        cardCode: json["CardCode"],
        paymentMethodName: json["PaymentMethodName"],
        paymentMethodType: json["PaymentMethodType"],
    );

    Map<String, dynamic> toJson() => {
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

class Expire {
    Expire({
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

    factory Expire.fromJson(Map<String, dynamic> json) => Expire(
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
