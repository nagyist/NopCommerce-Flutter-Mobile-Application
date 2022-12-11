/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'dart:convert';
import 'package:nopcommerce/Models/AddressModel.dart';

GetCustomerAddressesModel getCustomerAddressesModelFromJson(String str) => GetCustomerAddressesModel.fromJson(json.decode(str));

String getCustomerAddressesModelToJson(GetCustomerAddressesModel data) => json.encode(data.toJson());

class GetCustomerAddressesModel {
  GetCustomerAddressesModel({
    required this.addresses,
    required this.invalidAddresses,
    required this.newAddress,
  });

  List<AddressModel> addresses;
  List<AddressModel> invalidAddresses;
  AddressModel newAddress;

  factory GetCustomerAddressesModel.fromJson(Map<String, dynamic> json) => GetCustomerAddressesModel(
    addresses:List<AddressModel>.from(json["Addresses"].map((x) => AddressModel.fromJson(x))),
    invalidAddresses: List<AddressModel>.from(json["InvalidAddresses"].map((x) => AddressModel.fromJson(x))),
    newAddress: AddressModel.fromJson(json["NewAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "Addresses": List<dynamic>.from(addresses.map((x) => x)),
    "InvalidAddresses": List<dynamic>.from(invalidAddresses.map((x) => x.toJson())),
    "NewAddress": newAddress.toJson(),
  };
}
