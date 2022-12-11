/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetLoginResponseModel getLoginResponseModelFromJson(String str) => GetLoginResponseModel.fromJson(json.decode(str));

String getLoginResponseModelToJson(GetLoginResponseModel data) => json.encode(data.toJson());

class GetLoginResponseModel {
    GetLoginResponseModel({
        required this.checkoutAsGuest,
        required this.email,
        required this.usernamesEnabled,
        required this.registrationType,
        required this.username,
        required this.password,
        required this.rememberMe,
        required this.displayCaptcha,
        required this.customProperties,
    });

    bool checkoutAsGuest;
    dynamic email;
    bool usernamesEnabled;
    String registrationType;
    dynamic username;
    dynamic password;
    bool rememberMe;
    bool displayCaptcha;
    CustomProperties customProperties;

    factory GetLoginResponseModel.fromJson(Map<String, dynamic> json) => GetLoginResponseModel(
        checkoutAsGuest: json["CheckoutAsGuest"],
        email: json["Email"],
        usernamesEnabled: json["UsernamesEnabled"],
        registrationType: json["RegistrationType"],
        username: json["Username"],
        password: json["Password"],
        rememberMe: json["RememberMe"],
        displayCaptcha: json["DisplayCaptcha"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "CheckoutAsGuest": checkoutAsGuest,
        "Email": email,
        "UsernamesEnabled": usernamesEnabled,
        "RegistrationType": registrationType,
        "Username": username,
        "Password": password,
        "RememberMe": rememberMe,
        "DisplayCaptcha": displayCaptcha,
        "CustomProperties": customProperties.toJson(),
    };
}
