/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:nopcommerce/Models/CustomProperties.dart';

GetContactUsModel getContactUsModelFromJson(String str) => GetContactUsModel.fromJson(json.decode(str));

String getContactUsModelToJson(GetContactUsModel data) => json.encode(data.toJson());

class GetContactUsModel {
  GetContactUsModel({
    required this.email,
    required this.subject,
    required this.subjectEnabled,
    required this.enquiry,
    required this.fullName,
    required this.successfullySent,
    required this.result,
    required this.displayCaptcha,
    required this.customProperties,
  });

  String email;
  dynamic subject;
  bool subjectEnabled;
  dynamic enquiry;
  String fullName;
  bool successfullySent;
  dynamic result;
  bool displayCaptcha;
  CustomProperties customProperties;

  factory GetContactUsModel.fromJson(Map<String, dynamic> json) => GetContactUsModel(
    email: json["Email"],
    subject: json["Subject"],
    subjectEnabled: json["SubjectEnabled"],
    enquiry: json["Enquiry"],
    fullName: json["FullName"],
    successfullySent: json["SuccessfullySent"],
    result: json["Result"],
    displayCaptcha: json["DisplayCaptcha"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Subject": subject,
    "SubjectEnabled": subjectEnabled,
    "Enquiry": enquiry,
    "FullName": fullName,
    "SuccessfullySent": successfullySent,
    "Result": result,
    "DisplayCaptcha": displayCaptcha,
    "CustomProperties": customProperties.toJson(),
  };
}