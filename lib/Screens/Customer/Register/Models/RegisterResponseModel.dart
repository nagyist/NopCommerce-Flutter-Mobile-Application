/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:meta/meta.dart';
import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    RegisterResponseModel({
        required this.message,
        required this.accessToken,
        required this.refreshToken,
        required this.refreshTokenExpiration,
    });

    String message;
    dynamic accessToken;
    dynamic refreshToken;
    DateTime refreshTokenExpiration;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        message: json["Message"],
        accessToken: json["AccessToken"],
        refreshToken: json["RefreshToken"],
        refreshTokenExpiration: DateTime.parse(json["RefreshTokenExpiration"]),
    );

    Map<String, dynamic> toJson() => {
        "Message": message,
        "AccessToken": accessToken,
        "RefreshToken": refreshToken,
        "RefreshTokenExpiration": refreshTokenExpiration.toIso8601String(),
    };
}
