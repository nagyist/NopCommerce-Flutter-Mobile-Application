/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Models/CustomerAttributeModel.dart';

GetRegisterResponseModel getRegisterResponseModelFromJson(String str) => GetRegisterResponseModel.fromJson(json.decode(str));

String getRegisterResponseModelToJson(GetRegisterResponseModel data) => json.encode(data.toJson());

class GetRegisterResponseModel {
    GetRegisterResponseModel({
        required this.email,
        required this.enteringEmailTwice,
        required this.confirmEmail,
        required this.usernamesEnabled,
        required this.username,
        required this.checkUsernameAvailabilityEnabled,
        required this.password,
        required this.confirmPassword,
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
        required this.acceptPrivacyPolicyEnabled,
        required this.acceptPrivacyPolicyPopup,
        required this.timeZoneId,
        required this.allowCustomersToSetTimeZone,
        required this.availableTimeZones,
        required this.vatNumber,
        required this.displayVatNumber,
        required this.honeypotEnabled,
        required this.displayCaptcha,
        required this.customerAttributes,
        required this.gdprConsents,
        required this.customProperties,
    });

    dynamic email;
    bool enteringEmailTwice;
    dynamic confirmEmail;
    bool usernamesEnabled;
    dynamic username;
    bool checkUsernameAvailabilityEnabled;
    dynamic password;
    dynamic confirmPassword;
    bool genderEnabled;
    dynamic gender;
    bool firstNameEnabled;
    dynamic firstName;
    bool firstNameRequired;
    bool lastNameEnabled;
    dynamic lastName;
    bool lastNameRequired;
    bool dateOfBirthEnabled;
    dynamic dateOfBirthDay;
    dynamic dateOfBirthMonth;
    dynamic dateOfBirthYear;
    bool dateOfBirthRequired;
    bool companyEnabled;
    bool companyRequired;
    dynamic company;
    bool streetAddressEnabled;
    bool streetAddressRequired;
    dynamic streetAddress;
    bool streetAddress2Enabled;
    bool streetAddress2Required;
    dynamic streetAddress2;
    bool zipPostalCodeEnabled;
    bool zipPostalCodeRequired;
    dynamic zipPostalCode;
    bool cityEnabled;
    bool cityRequired;
    dynamic city;
    bool countyEnabled;
    bool countyRequired;
    dynamic county;
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
    dynamic phone;
    bool faxEnabled;
    bool faxRequired;
    dynamic fax;
    bool newsletterEnabled;
    bool newsletter;
    bool acceptPrivacyPolicyEnabled;
    bool acceptPrivacyPolicyPopup;
    String timeZoneId;
    bool allowCustomersToSetTimeZone;
    List<CountryStateModel> availableTimeZones;
    dynamic vatNumber;
    bool displayVatNumber;
    bool honeypotEnabled;
    bool displayCaptcha;
    List<CustomerAttributeModel> customerAttributes;
    List<GdprConsent_Register> gdprConsents;
    CustomProperties customProperties;

    factory GetRegisterResponseModel.fromJson(Map<String, dynamic> json) => GetRegisterResponseModel(
        email: json["Email"],
        enteringEmailTwice: json["EnteringEmailTwice"],
        confirmEmail: json["ConfirmEmail"],
        usernamesEnabled: json["UsernamesEnabled"],
        username: json["Username"],
        checkUsernameAvailabilityEnabled: json["CheckUsernameAvailabilityEnabled"],
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
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
        acceptPrivacyPolicyEnabled: json["AcceptPrivacyPolicyEnabled"],
        acceptPrivacyPolicyPopup: json["AcceptPrivacyPolicyPopup"],
        timeZoneId: json["TimeZoneId"],
        allowCustomersToSetTimeZone: json["AllowCustomersToSetTimeZone"],
        availableTimeZones: List<CountryStateModel>.from(json["AvailableTimeZones"].map((x) => CountryStateModel.fromJson(x))),
        vatNumber: json["VatNumber"],
        displayVatNumber: json["DisplayVatNumber"],
        honeypotEnabled: json["HoneypotEnabled"],
        displayCaptcha: json["DisplayCaptcha"],
        customerAttributes: List<CustomerAttributeModel>.from(json["CustomerAttributes"].map((x) => CustomerAttributeModel.fromJson(x))),
        gdprConsents: List<GdprConsent_Register>.from(json["GdprConsents"].map((x) => GdprConsent_Register.fromJson(x))),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "EnteringEmailTwice": enteringEmailTwice,
        "ConfirmEmail": confirmEmail,
        "UsernamesEnabled": usernamesEnabled,
        "Username": username,
        "CheckUsernameAvailabilityEnabled": checkUsernameAvailabilityEnabled,
        "Password": password,
        "ConfirmPassword": confirmPassword,
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
        "AcceptPrivacyPolicyEnabled": acceptPrivacyPolicyEnabled,
        "AcceptPrivacyPolicyPopup": acceptPrivacyPolicyPopup,
        "TimeZoneId": timeZoneId,
        "AllowCustomersToSetTimeZone": allowCustomersToSetTimeZone,
        "AvailableTimeZones": List<dynamic>.from(availableTimeZones.map((x) => x.toJson())),
        "VatNumber": vatNumber,
        "DisplayVatNumber": displayVatNumber,
        "HoneypotEnabled": honeypotEnabled,
        "DisplayCaptcha": displayCaptcha,
        "CustomerAttributes": List<dynamic>.from(customerAttributes.map((x) => x.toJson())),
        "GdprConsents": List<dynamic>.from(gdprConsents.map((x) => x.toJson())),
        "CustomProperties": customProperties.toJson(),
    };
}


class GdprConsent_Register {
    GdprConsent_Register({
        required this.message,
        required this.isRequired,
        required this.requiredMessage,
        required this.accepted,
        required this.id,
        required this.customProperties,
    });

    String message;
    bool isRequired;
    String requiredMessage;
    bool accepted;
    int id;
    CustomProperties customProperties;

    factory GdprConsent_Register.fromJson(Map<String, dynamic> json) => GdprConsent_Register(
        message: json["Message"],
        isRequired: json["IsRequired"],
        requiredMessage: json["RequiredMessage"],
        accepted: json["Accepted"],
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "Message": message,
        "IsRequired": isRequired,
        "RequiredMessage": requiredMessage,
        "Accepted": accepted,
        "Id": id,
        "CustomProperties": customProperties.toJson(),
    };
}
