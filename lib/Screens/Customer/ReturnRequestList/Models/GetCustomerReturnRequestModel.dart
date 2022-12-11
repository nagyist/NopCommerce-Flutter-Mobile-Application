/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetCustomerReturnRequestModel getCustomerReturnRequestModelFromJson(String str) => GetCustomerReturnRequestModel.fromJson(json.decode(str));

String getCustomerReturnRequestModelToJson(GetCustomerReturnRequestModel data) => json.encode(data.toJson());

class GetCustomerReturnRequestModel {
    GetCustomerReturnRequestModel({
        required this.items,
        required this.customProperties,
    });

    List<CustomerReturnRequestItem> items;
    CustomProperties customProperties;

    factory GetCustomerReturnRequestModel.fromJson(Map<String, dynamic> json) => GetCustomerReturnRequestModel(
        items: List<CustomerReturnRequestItem>.from(json["Items"].map((x) => CustomerReturnRequestItem.fromJson(x))),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "CustomProperties": customProperties.toJson(),
    };
}

class CustomerReturnRequestItem {
    CustomerReturnRequestItem({
        required this.customNumber,
        required this.returnRequestStatus,
        required this.productId,
        required this.productName,
        required this.productSeName,
        required this.quantity,
        required this.returnReason,
        required this.returnAction,
        required this.comments,
        required this.uploadedFileGuid,
        required this.createdOn,
        required this.id,
        required this.customProperties,
    });

    String customNumber;
    String returnRequestStatus;
    int productId;
    String productName;
    String productSeName;
    int quantity;
    String returnReason;
    String returnAction;
    dynamic comments;
    String uploadedFileGuid;
    DateTime createdOn;
    int id;
    CustomProperties customProperties;

    factory CustomerReturnRequestItem.fromJson(Map<String, dynamic> json) => CustomerReturnRequestItem(
        customNumber: json["CustomNumber"],
        returnRequestStatus: json["ReturnRequestStatus"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        quantity: json["Quantity"],
        returnReason: json["ReturnReason"],
        returnAction: json["ReturnAction"],
        comments: json["Comments"],
        uploadedFileGuid: json["UploadedFileGuid"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "CustomNumber": customNumber,
        "ReturnRequestStatus": returnRequestStatus,
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "Quantity": quantity,
        "ReturnReason": returnReason,
        "ReturnAction": returnAction,
        "Comments": comments,
        "UploadedFileGuid": uploadedFileGuid,
        "CreatedOn": createdOn.toIso8601String(),
        "Id": id,
        "CustomProperties": customProperties.toJson(),
    };
}
