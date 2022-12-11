/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CountryStateModel.dart';

import 'AddressAttributeModel.dart';
import 'CustomProperties.dart';

class AddressModel {
  AddressModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyEnabled,
    required this.companyRequired,
    required this.company,
    required this.countryEnabled,
    required this.countryId,
    required this.countryName,
    required this.stateProvinceEnabled,
    required this.stateProvinceId,
    required this.stateProvinceName,
    required this.countyEnabled,
    required this.countyRequired,
    required this.county,
    required this.cityEnabled,
    required this.cityRequired,
    required this.city,
    required this.streetAddressEnabled,
    required this.streetAddressRequired,
    required this.address1,
    required this.streetAddress2Enabled,
    required this.streetAddress2Required,
    required this.address2,
    required this.zipPostalCodeEnabled,
    required this.zipPostalCodeRequired,
    required this.zipPostalCode,
    required this.phoneEnabled,
    required this.phoneRequired,
    required this.phoneNumber,
    required this.faxEnabled,
    required this.faxRequired,
    required this.faxNumber,
    required this.availableCountries,
    required this.availableStates,
    required this.formattedCustomAddressAttributes,
    required this.customAddressAttributes,
    required this.id,
    required this.customProperties,
  });

  String firstName;
  String lastName;
  String email;
  bool companyEnabled;
  bool companyRequired;
  String company;
  bool countryEnabled;
  int countryId;
  String countryName;
  bool stateProvinceEnabled;
  int stateProvinceId;
  String stateProvinceName;
  bool countyEnabled;
  bool countyRequired;
  String county;
  bool cityEnabled;
  bool cityRequired;
  String city;
  bool streetAddressEnabled;
  bool streetAddressRequired;
  String address1;
  bool streetAddress2Enabled;
  bool streetAddress2Required;
  String address2;
  bool zipPostalCodeEnabled;
  bool zipPostalCodeRequired;
  String zipPostalCode;
  bool phoneEnabled;
  bool phoneRequired;
  String phoneNumber;
  bool faxEnabled;
  bool faxRequired;
  String faxNumber;
  List<CountryStateModel> availableCountries;
  List<CountryStateModel> availableStates;
  String formattedCustomAddressAttributes;
  List<AddressAttribute> customAddressAttributes;
  int id;
  CustomProperties customProperties;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"],
    companyEnabled: json["CompanyEnabled"],
    companyRequired: json["CompanyRequired"],
    company: json["Company"],
    countryEnabled: json["CountryEnabled"],
    countryId: json["CountryId"] == null ? null : json["CountryId"],
    countryName: json["CountryName"] == null ? null : json["CountryName"],
    stateProvinceEnabled: json["StateProvinceEnabled"],
    stateProvinceId: json["StateProvinceId"] == null ? null : json["StateProvinceId"],
    stateProvinceName: json["StateProvinceName"] == null ? null : json["StateProvinceName"],
    countyEnabled: json["CountyEnabled"],
    countyRequired: json["CountyRequired"],
    county: json["County"],
    cityEnabled: json["CityEnabled"],
    cityRequired: json["CityRequired"],
    city: json["City"],
    streetAddressEnabled: json["StreetAddressEnabled"],
    streetAddressRequired: json["StreetAddressRequired"],
    address1: json["Address1"],
    streetAddress2Enabled: json["StreetAddress2Enabled"],
    streetAddress2Required: json["StreetAddress2Required"],
    address2: json["Address2"],
    zipPostalCodeEnabled: json["ZipPostalCodeEnabled"],
    zipPostalCodeRequired: json["ZipPostalCodeRequired"],
    zipPostalCode: json["ZipPostalCode"],
    phoneEnabled: json["PhoneEnabled"],
    phoneRequired: json["PhoneRequired"],
    phoneNumber: json["PhoneNumber"],
    faxEnabled: json["FaxEnabled"],
    faxRequired: json["FaxRequired"],
    faxNumber: json["FaxNumber"],
    availableCountries: List<CountryStateModel>.from(json["AvailableCountries"].map((x) => CountryStateModel.fromJson(x))),
    availableStates: List<CountryStateModel>.from(json["AvailableStates"].map((x) => CountryStateModel.fromJson(x))),
    formattedCustomAddressAttributes: json["FormattedCustomAddressAttributes"] == null ? null : json["FormattedCustomAddressAttributes"],
    customAddressAttributes: List<AddressAttribute>.from(json["CustomAddressAttributes"].map((x) => AddressAttribute.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "CompanyEnabled": companyEnabled,
    "CompanyRequired": companyRequired,
    "Company": company,
    "CountryEnabled": countryEnabled,
    "CountryId": countryId == null ? null : countryId,
    "CountryName": countryName == null ? null : countryName,
    "StateProvinceEnabled": stateProvinceEnabled,
    "StateProvinceId": stateProvinceId == null ? null : stateProvinceId,
    "StateProvinceName": stateProvinceName == null ? null : stateProvinceName,
    "CountyEnabled": countyEnabled,
    "CountyRequired": countyRequired,
    "County": county,
    "CityEnabled": cityEnabled,
    "CityRequired": cityRequired,
    "City": city,
    "StreetAddressEnabled": streetAddressEnabled,
    "StreetAddressRequired": streetAddressRequired,
    "Address1": address1,
    "StreetAddress2Enabled": streetAddress2Enabled,
    "StreetAddress2Required": streetAddress2Required,
    "Address2": address2,
    "ZipPostalCodeEnabled": zipPostalCodeEnabled,
    "ZipPostalCodeRequired": zipPostalCodeRequired,
    "ZipPostalCode": zipPostalCode,
    "PhoneEnabled": phoneEnabled,
    "PhoneRequired": phoneRequired,
    "PhoneNumber": phoneNumber,
    "FaxEnabled": faxEnabled,
    "FaxRequired": faxRequired,
    "FaxNumber": faxNumber,
    "AvailableCountries": List<dynamic>.from(availableCountries.map((x) => x.toJson())),
    "AvailableStates": List<dynamic>.from(availableStates.map((x) => x.toJson())),
    "FormattedCustomAddressAttributes": formattedCustomAddressAttributes == null ? null : formattedCustomAddressAttributes,
    "CustomAddressAttributes": List<dynamic>.from(customAddressAttributes.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
