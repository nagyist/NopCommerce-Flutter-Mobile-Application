/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

GetHomepageAllNewsModel getHomepageAllNewsModelFromJson(String str) => GetHomepageAllNewsModel.fromJson(json.decode(str));

String getHomepageAllNewsModelToJson(GetHomepageAllNewsModel data) => json.encode(data.toJson());

class GetHomepageAllNewsModel {
  GetHomepageAllNewsModel({
    required this.workingLanguageId,
    required this.pagingFilteringContext,
    required this.newsItems,
    required this.customProperties,
  });

  int workingLanguageId;
  PagingFilteringContext pagingFilteringContext;
  List<NewsItem> newsItems;
  CustomProperties customProperties;

  factory GetHomepageAllNewsModel.fromJson(Map<String, dynamic> json) => GetHomepageAllNewsModel(
    workingLanguageId: json["WorkingLanguageId"],
    pagingFilteringContext: PagingFilteringContext.fromJson(json["PagingFilteringContext"]),
    newsItems: List<NewsItem>.from(json["NewsItems"].map((x) => NewsItem.fromJson(x))),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "WorkingLanguageId": workingLanguageId,
    "PagingFilteringContext": pagingFilteringContext.toJson(),
    "NewsItems": List<dynamic>.from(newsItems.map((x) => x.toJson())),
    "CustomProperties": customProperties.toJson(),
  };
}


class NewsItem {
  NewsItem({
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    required this.seName,
    required this.title,
    required this.short,
    required this.full,
    required this.allowComments,
    required this.numberOfComments,
    required this.createdOn,
    required this.comments,
    required this.addNewComment,
    required this.id,
    required this.customProperties,
  });

  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic metaTitle;
  String seName;
  String title;
  String short;
  String full;
  bool allowComments;
  int numberOfComments;
  DateTime createdOn;
  List<dynamic> comments;
  AddNewComment addNewComment;
  int id;
  CustomProperties customProperties;

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    title: json["Title"],
    short: json["Short"],
    full: json["Full"],
    allowComments: json["AllowComments"],
    numberOfComments: json["NumberOfComments"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    comments: List<dynamic>.from(json["Comments"].map((x) => x)),
    addNewComment: AddNewComment.fromJson(json["AddNewComment"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "Title": title,
    "Short": short,
    "Full": full,
    "AllowComments": allowComments,
    "NumberOfComments": numberOfComments,
    "CreatedOn": createdOn.toIso8601String(),
    "Comments": List<dynamic>.from(comments.map((x) => x)),
    "AddNewComment": addNewComment.toJson(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class AddNewComment {
  AddNewComment({
    this.commentTitle,
    this.commentText,
    required this.displayCaptcha,
    required this.customProperties,
  });

  dynamic commentTitle;
  dynamic commentText;
  bool displayCaptcha;
  CustomProperties customProperties;

  factory AddNewComment.fromJson(Map<String, dynamic> json) => AddNewComment(
    commentTitle: json["CommentTitle"],
    commentText: json["CommentText"],
    displayCaptcha: json["DisplayCaptcha"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CommentTitle": commentTitle,
    "CommentText": commentText,
    "DisplayCaptcha": displayCaptcha,
    "CustomProperties": customProperties.toJson(),
  };
}

class PagingFilteringContext {
  PagingFilteringContext({
    required this.pageIndex,
    required this.pageNumber,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.firstItem,
    required this.lastItem,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.customProperties,
  });

  int pageIndex;
  int pageNumber;
  int pageSize;
  int totalItems;
  int totalPages;
  int firstItem;
  int lastItem;
  bool hasPreviousPage;
  bool hasNextPage;
  CustomProperties customProperties;

  factory PagingFilteringContext.fromJson(Map<String, dynamic> json) => PagingFilteringContext(
    pageIndex: json["PageIndex"],
    pageNumber: json["PageNumber"],
    pageSize: json["PageSize"],
    totalItems: json["TotalItems"],
    totalPages: json["TotalPages"],
    firstItem: json["FirstItem"],
    lastItem: json["LastItem"],
    hasPreviousPage: json["HasPreviousPage"],
    hasNextPage: json["HasNextPage"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "PageIndex": pageIndex,
    "PageNumber": pageNumber,
    "PageSize": pageSize,
    "TotalItems": totalItems,
    "TotalPages": totalPages,
    "FirstItem": firstItem,
    "LastItem": lastItem,
    "HasPreviousPage": hasPreviousPage,
    "HasNextPage": hasNextPage,
    "CustomProperties": customProperties.toJson(),
  };
}
