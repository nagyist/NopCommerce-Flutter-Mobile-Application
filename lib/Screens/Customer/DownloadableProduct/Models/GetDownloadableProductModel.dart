/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetDownloadableProductModel getDownloadableProductModelFromJson(String str) => GetDownloadableProductModel.fromJson(json.decode(str));

String getDownloadableProductModelToJson(GetDownloadableProductModel data) => json.encode(data.toJson());

class GetDownloadableProductModel {
    GetDownloadableProductModel({
        required this.items,
        required this.customProperties,
    });

    List<DownloadProductItem> items;
    CustomProperties customProperties;

    factory GetDownloadableProductModel.fromJson(Map<String, dynamic> json) => GetDownloadableProductModel(
        items: List<DownloadProductItem>.from(json["Items"].map((x) => DownloadProductItem.fromJson(x))),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "CustomProperties": customProperties.toJson(),
    };
}

class DownloadProductItem {
    DownloadProductItem({
        required this.orderItemGuid,
        required this.orderId,
        required this.customOrderNumber,
        required this.productId,
        required this.productName,
        required this.productSeName,
        required this.productAttributes,
        required this.downloadId,
        required this.licenseId,
        required this.createdOn,
        required this.customProperties,
    });

    String orderItemGuid;
    int orderId;
    String customOrderNumber;
    int productId;
    String productName;
    String productSeName;
    String productAttributes;
    int downloadId;
    int licenseId;
    DateTime createdOn;
    CustomProperties customProperties;

    factory DownloadProductItem.fromJson(Map<String, dynamic> json) => DownloadProductItem(
        orderItemGuid: json["OrderItemGuid"],
        orderId: json["OrderId"],
        customOrderNumber: json["CustomOrderNumber"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        productAttributes: json["ProductAttributes"],
        downloadId: json["DownloadId"],
        licenseId: json["LicenseId"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "OrderItemGuid": orderItemGuid,
        "OrderId": orderId,
        "CustomOrderNumber": customOrderNumber,
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "ProductAttributes": productAttributes,
        "DownloadId": downloadId,
        "LicenseId": licenseId,
        "CreatedOn": createdOn.toIso8601String(),
        "CustomProperties": customProperties.toJson(),
    };
}
