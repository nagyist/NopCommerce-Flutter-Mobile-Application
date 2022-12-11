/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetTopicBlockModel getTopicBlockModelFromJson(String str) => GetTopicBlockModel.fromJson(json.decode(str));

String getTopicBlockModelToJson(GetTopicBlockModel data) => json.encode(data.toJson());

class GetTopicBlockModel {
  GetTopicBlockModel({
    required this.systemName,
    required this.includeInSitemap,
    required this.isPasswordProtected,
    required this.title,
    required this.body,
    required this.metaKeywords,
    required this.metaDescription,
    required this.metaTitle,
    required this.seName,
    required this.topicTemplateId,
    required this.id,
    required this.customProperties,
  });

  String systemName;
  bool includeInSitemap;
  bool isPasswordProtected;
  String title;
  String body;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String seName;
  int topicTemplateId;
  int id;
  CustomProperties customProperties;

  factory GetTopicBlockModel.fromJson(Map<String, dynamic> json) => GetTopicBlockModel(
    systemName: json["SystemName"],
    includeInSitemap: json["IncludeInSitemap"],
    isPasswordProtected: json["IsPasswordProtected"],
    title: json["Title"],
    body: json["Body"],
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    topicTemplateId: json["TopicTemplateId"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "SystemName": systemName,
    "IncludeInSitemap": includeInSitemap,
    "IsPasswordProtected": isPasswordProtected,
    "Title": title,
    "Body": body,
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "TopicTemplateId": topicTemplateId,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
