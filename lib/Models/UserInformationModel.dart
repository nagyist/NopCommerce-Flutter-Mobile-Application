/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'CountryStateModel.dart';
import 'CustomProperties.dart';
import 'CustomerAttributeModel.dart';
import 'GdprConsentModel.dart';

class UserInformationModel {
  UserInformationModel({
    required this.email,
    required this.emailToRevalidate,
    required this.checkUsernameAvailabilityEnabled,
    required this.allowUsersToChangeUsernames,
    required this.usernamesEnabled,
    required this.username,
    required this.genderEnabled,
    required this.gender,
    required this.firstNameEnabled,
    required this.firstName,
    required this.firstNameRequired,
    required this.lastNameEnabled,
    required this.lastName,
    required this.lastNameRequired,
    required this.dateOfBirthEnabled,
    required this.dateOfBirthDay,
    required this.dateOfBirthMonth,
    required this.dateOfBirthYear,
    required this.dateOfBirthRequired,
    required this.companyEnabled,
    required this.companyRequired,
    required this.company,
    required this.streetAddressEnabled,
    required this.streetAddressRequired,
    required this.streetAddress,
    required this.streetAddress2Enabled,
    required this.streetAddress2Required,
    required this.streetAddress2,
    required this.zipPostalCodeEnabled,
    required this.zipPostalCodeRequired,
    required this.zipPostalCode,
    required this.cityEnabled,
    required this.cityRequired,
    required this.city,
    required this.countyEnabled,
    required this.countyRequired,
    required this.county,
    required this.countryEnabled,
    required this.countryRequired,
    required this.countryId,
    required this.availableCountries,
    required this.stateProvinceEnabled,
    required this.stateProvinceRequired,
    required this.stateProvinceId,
    required this.availableStates,
    required this.phoneEnabled,
    required this.phoneRequired,
    required this.phone,
    required this.faxEnabled,
    required this.faxRequired,
    required this.fax,
    required this.newsletterEnabled,
    required this.newsletter,
    required this.signatureEnabled,
    required this.signature,
    required this.timeZoneId,
    required this.allowCustomersToSetTimeZone,
    required this.availableTimeZones,
    required this.vatNumber,
    required this.vatNumberStatusNote,
    required this.displayVatNumber,
    required this.associatedExternalAuthRecords,
    required this.numberOfExternalAuthenticationProviders,
    required this.allowCustomersToRemoveAssociations,
    required this.customerAttributes,
    required this.gdprConsents,
    required this.customProperties,
  });

  String email;
  String emailToRevalidate;
  bool checkUsernameAvailabilityEnabled;
  bool allowUsersToChangeUsernames;
  bool usernamesEnabled;
  String username;
  bool genderEnabled;
  String gender;
  bool firstNameEnabled;
  String firstName;
  bool firstNameRequired;
  bool lastNameEnabled;
  String lastName;
  bool lastNameRequired;
  bool dateOfBirthEnabled;
  int dateOfBirthDay;
  int dateOfBirthMonth;
  int dateOfBirthYear;
  bool dateOfBirthRequired;
  bool companyEnabled;
  bool companyRequired;
  String company;
  bool streetAddressEnabled;
  bool streetAddressRequired;
  String streetAddress;
  bool streetAddress2Enabled;
  bool streetAddress2Required;
  String streetAddress2;
  bool zipPostalCodeEnabled;
  bool zipPostalCodeRequired;
  String zipPostalCode;
  bool cityEnabled;
  bool cityRequired;
  String city;
  bool countyEnabled;
  bool countyRequired;
  String county;
  bool countryEnabled;
  bool countryRequired;
  int countryId;
  List<CountryStateModel> availableCountries;
  bool stateProvinceEnabled;
  bool stateProvinceRequired;
  int stateProvinceId;
  List<CountryStateModel> availableStates;
  bool phoneEnabled;
  bool phoneRequired;
  String phone;
  bool faxEnabled;
  bool faxRequired;
  String fax;
  bool newsletterEnabled;
  bool newsletter;
  bool signatureEnabled;
  String signature;
  String timeZoneId;
  bool allowCustomersToSetTimeZone;
  List<CountryStateModel> availableTimeZones;
  String vatNumber;
  String vatNumberStatusNote;
  bool displayVatNumber;
  List<dynamic> associatedExternalAuthRecords;
  int numberOfExternalAuthenticationProviders;
  bool allowCustomersToRemoveAssociations;
  List<CustomerAttributeModel> customerAttributes;
  List<GdprConsent> gdprConsents;
  CustomProperties customProperties;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) => UserInformationModel(
    email: json["Email"],
    emailToRevalidate: json["EmailToRevalidate"],
    checkUsernameAvailabilityEnabled: json["CheckUsernameAvailabilityEnabled"],
    allowUsersToChangeUsernames: json["AllowUsersToChangeUsernames"],
    usernamesEnabled: json["UsernamesEnabled"],
    username: json["Username"],
    genderEnabled: json["GenderEnabled"],
    gender: json["Gender"],
    firstNameEnabled: json["FirstNameEnabled"],
    firstName: json["FirstName"],
    firstNameRequired: json["FirstNameRequired"],
    lastNameEnabled: json["LastNameEnabled"],
    lastName: json["LastName"],
    lastNameRequired: json["LastNameRequired"],
    dateOfBirthEnabled: json["DateOfBirthEnabled"],
    dateOfBirthDay: json["DateOfBirthDay"],
    dateOfBirthMonth: json["DateOfBirthMonth"],
    dateOfBirthYear: json["DateOfBirthYear"],
    dateOfBirthRequired: json["DateOfBirthRequired"],
    companyEnabled: json["CompanyEnabled"],
    companyRequired: json["CompanyRequired"],
    company: json["Company"],
    streetAddressEnabled: json["StreetAddressEnabled"],
    streetAddressRequired: json["StreetAddressRequired"],
    streetAddress: json["StreetAddress"],
    streetAddress2Enabled: json["StreetAddress2Enabled"],
    streetAddress2Required: json["StreetAddress2Required"],
    streetAddress2: json["StreetAddress2"],
    zipPostalCodeEnabled: json["ZipPostalCodeEnabled"],
    zipPostalCodeRequired: json["ZipPostalCodeRequired"],
    zipPostalCode: json["ZipPostalCode"],
    cityEnabled: json["CityEnabled"],
    cityRequired: json["CityRequired"],
    city: json["City"],
    countyEnabled: json["CountyEnabled"],
    countyRequired: json["CountyRequired"],
    county: json["County"],
    countryEnabled: json["CountryEnabled"],
    countryRequired: json["CountryRequired"],
    countryId: json["CountryId"],
    availableCountries: List<CountryStateModel>.from(json["AvailableCountries"].map((x) => CountryStateModel.fromJson(x))),
    stateProvinceEnabled: json["StateProvinceEnabled"],
    stateProvinceRequired: json["StateProvinceRequired"],
    stateProvinceId: json["StateProvinceId"],
    availableStates: List<CountryStateModel>.from(json["AvailableStates"].map((x) => CountryStateModel.fromJson(x))),
    phoneEnabled: json["PhoneEnabled"],
    phoneRequired: json["PhoneRequired"],
    phone: json["Phone"],
    faxEnabled: json["FaxEnabled"],
    faxRequired: json["FaxRequired"],
    fax: json["Fax"],
    newsletterEnabled: json["NewsletterEnabled"],
    newsletter: json["Newsletter"],
    signatureEnabled: json["SignatureEnabled"],
    signature: json["Signature"],
    timeZoneId: json["TimeZoneId"],
    allowCustomersToSetTimeZone: json["AllowCustomersToSetTimeZone"],
    availableTimeZones: List<CountryStateModel>.from(json["AvailableTimeZones"].map((x) => CountryStateModel.fromJson(x))),
    vatNumber: json["VatNumber"],
    vatNumberStatusNote: json["VatNumberStatusNote"],
    displayVatNumber: json["DisplayVatNumber"],
    associatedExternalAuthRecords: List<dynamic>.from(json["AssociatedExternalAuthRecords"].map((x) => x)),
    numberOfExternalAuthenticationProviders: json["NumberOfExternalAuthenticationProviders"],
    allowCustomersToRemoveAssociations: json["AllowCustomersToRemoveAssociations"],
    customerAttributes: List<CustomerAttributeModel>.from(json["CustomerAttributes"].map((x) => CustomerAttributeModel.fromJson(x))),
    gdprConsents: List<GdprConsent>.from(json["GdprConsents"].map((x) => GdprConsent.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "EmailToRevalidate": emailToRevalidate,
    "CheckUsernameAvailabilityEnabled": checkUsernameAvailabilityEnabled,
    "AllowUsersToChangeUsernames": allowUsersToChangeUsernames,
    "UsernamesEnabled": usernamesEnabled,
    "Username": username,
    "GenderEnabled": genderEnabled,
    "Gender": gender,
    "FirstNameEnabled": firstNameEnabled,
    "FirstName": firstName,
    "FirstNameRequired": firstNameRequired,
    "LastNameEnabled": lastNameEnabled,
    "LastName": lastName,
    "LastNameRequired": lastNameRequired,
    "DateOfBirthEnabled": dateOfBirthEnabled,
    "DateOfBirthDay": dateOfBirthDay,
    "DateOfBirthMonth": dateOfBirthMonth,
    "DateOfBirthYear": dateOfBirthYear,
    "DateOfBirthRequired": dateOfBirthRequired,
    "CompanyEnabled": companyEnabled,
    "CompanyRequired": companyRequired,
    "Company": company,
    "StreetAddressEnabled": streetAddressEnabled,
    "StreetAddressRequired": streetAddressRequired,
    "StreetAddress": streetAddress,
    "StreetAddress2Enabled": streetAddress2Enabled,
    "StreetAddress2Required": streetAddress2Required,
    "StreetAddress2": streetAddress2,
    "ZipPostalCodeEnabled": zipPostalCodeEnabled,
    "ZipPostalCodeRequired": zipPostalCodeRequired,
    "ZipPostalCode": zipPostalCode,
    "CityEnabled": cityEnabled,
    "CityRequired": cityRequired,
    "City": city,
    "CountyEnabled": countyEnabled,
    "CountyRequired": countyRequired,
    "County": county,
    "CountryEnabled": countryEnabled,
    "CountryRequired": countryRequired,
    "CountryId": countryId,
    "AvailableCountries": List<dynamic>.from(availableCountries.map((x) => x.toJson())),
    "StateProvinceEnabled": stateProvinceEnabled,
    "StateProvinceRequired": stateProvinceRequired,
    "StateProvinceId": stateProvinceId,
    "AvailableStates": List<dynamic>.from(availableStates.map((x) => x.toJson())),
    "PhoneEnabled": phoneEnabled,
    "PhoneRequired": phoneRequired,
    "Phone": phone,
    "FaxEnabled": faxEnabled,
    "FaxRequired": faxRequired,
    "Fax": fax,
    "NewsletterEnabled": newsletterEnabled,
    "Newsletter": newsletter,
    "SignatureEnabled": signatureEnabled,
    "Signature": signature,
    "TimeZoneId": timeZoneId,
    "AllowCustomersToSetTimeZone": allowCustomersToSetTimeZone,
    "AvailableTimeZones": List<dynamic>.from(availableTimeZones.map((x) => x.toJson())),
    "VatNumber": vatNumber,
    "VatNumberStatusNote": vatNumberStatusNote,
    "DisplayVatNumber": displayVatNumber,
    "AssociatedExternalAuthRecords": List<dynamic>.from(associatedExternalAuthRecords.map((x) => x)),
    "NumberOfExternalAuthenticationProviders": numberOfExternalAuthenticationProviders,
    "AllowCustomersToRemoveAssociations": allowCustomersToRemoveAssociations,
    "CustomerAttributes": List<dynamic>.from(customerAttributes.map((x) => x.toJson())),
    "GdprConsents": List<dynamic>.from(gdprConsents.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}
