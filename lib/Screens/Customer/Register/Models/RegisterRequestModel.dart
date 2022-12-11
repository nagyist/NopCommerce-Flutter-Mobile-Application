/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';

class RegisterRequestModel{
  BuildContext context;
  String username;
  String password;
  String confirmPassword;
  String email;
  String confirmEmail;
  String timeZoneID;
  String vatNumber;
  String gender;
  String firstName;
  String lastName;
  int dateOfBirthDay;
  int dateOfBirthMonth;
  int dateOfBirthYear;
  String company;
  String streetAddress;
  String streetAddress2;
  String zipPostalCode;
  String city;
  String county;
  int countryID;
  String phone;
  String fax;
  int stateProvinceID;
  bool newsLatter;
  Map<String, String> customerAttributes = {};
  Map<String, String> gDPRConsents = {};

  RegisterRequestModel(
      {required this.context,
        required this.username,
        required this.password,
        required this.confirmPassword,
        required this.email,
        required this.confirmEmail,
        required this.timeZoneID,
        required this.vatNumber,
        required this.gender,
        required this.firstName,
        required this.lastName,
        required this.dateOfBirthDay,
        required this.dateOfBirthMonth,
        required this.dateOfBirthYear,
        required this.company,
        required this.streetAddress,
        required this.streetAddress2,
        required this.zipPostalCode,
        required this.city,
        required this.county,
        required this.countryID,
        required this.phone,
        required this.fax,
        required this.stateProvinceID,
        required this.newsLatter,
        required this.customerAttributes,
        required this.gDPRConsents});
}