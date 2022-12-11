/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/AvailableReturn.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/ReturnRequestItem.dart';
import 'dart:convert';

GetReturnRequestModel getReturnRequestModelFromJson(String str) => GetReturnRequestModel.fromJson(json.decode(str));

String getReturnRequestModelToJson(GetReturnRequestModel data) => json.encode(data.toJson());

class GetReturnRequestModel {
    GetReturnRequestModel({
        required this.orderId,
        required this.customOrderNumber,
        required this.items,
        required this.returnRequestReasonId,
        required this.availableReturnReasons,
        required this.returnRequestActionId,
        required this.availableReturnActions,
        required this.comments,
        required this.allowFiles,
        required this.uploadedFileGuid,
        required this.result,
        required this.customProperties,
    });

    int orderId;
    String customOrderNumber;
    List<ReturnRequestItem> items;
    int returnRequestReasonId;
    List<AvailableReturn> availableReturnReasons;
    int returnRequestActionId;
    List<AvailableReturn> availableReturnActions;
    dynamic comments;
    bool allowFiles;
    String uploadedFileGuid;
    dynamic result;
    CustomProperties customProperties;

    factory GetReturnRequestModel.fromJson(Map<String, dynamic> json) => GetReturnRequestModel(
        orderId: json["OrderId"],
        customOrderNumber: json["CustomOrderNumber"],
        items: List<ReturnRequestItem>.from(json["Items"].map((x) => ReturnRequestItem.fromJson(x))),
        returnRequestReasonId: json["ReturnRequestReasonId"],
        availableReturnReasons: List<AvailableReturn>.from(json["AvailableReturnReasons"].map((x) => AvailableReturn.fromJson(x))),
        returnRequestActionId: json["ReturnRequestActionId"],
        availableReturnActions: List<AvailableReturn>.from(json["AvailableReturnActions"].map((x) => AvailableReturn.fromJson(x))),
        comments: json["Comments"],
        allowFiles: json["AllowFiles"],
        uploadedFileGuid: json["UploadedFileGuid"],
        result: json["Result"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
    );

    Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "CustomOrderNumber": customOrderNumber,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "ReturnRequestReasonId": returnRequestReasonId,
        "AvailableReturnReasons": List<dynamic>.from(availableReturnReasons.map((x) => x.toJson())),
        "ReturnRequestActionId": returnRequestActionId,
        "AvailableReturnActions": List<dynamic>.from(availableReturnActions.map((x) => x.toJson())),
        "Comments": comments,
        "AllowFiles": allowFiles,
        "UploadedFileGuid": uploadedFileGuid,
        "Result": result,
        "CustomProperties": customProperties.toJson(),
    };
}
