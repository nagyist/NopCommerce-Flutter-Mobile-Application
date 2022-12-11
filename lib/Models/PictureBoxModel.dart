/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';

class PictureModel {
  PictureModel({
    required this.imageUrl,
    required this.thumbImageUrl,
    required this.fullSizeImageUrl,
    required this.title,
    required this.alternateText,
    required this.customProperties,
  });

  String imageUrl;
  String thumbImageUrl;
  String fullSizeImageUrl;
  String title;
  String alternateText;
  CustomProperties customProperties;

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
    imageUrl: json["ImageUrl"] == null ? null : json["ImageUrl"],
    thumbImageUrl: json["ThumbImageUrl"] == null ? null : json["ThumbImageUrl"],
    fullSizeImageUrl: json["FullSizeImageUrl"] == null ? null : json["FullSizeImageUrl"],
    title: json["Title"] == null ? null : json["Title"],
    alternateText: json["AlternateText"] == null ? null : json["AlternateText"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ImageUrl": imageUrl == null ? null : imageUrl,
    "ThumbImageUrl": thumbImageUrl == null ? null : thumbImageUrl,
    "FullSizeImageUrl": fullSizeImageUrl == null ? null : fullSizeImageUrl,
    "Title": title == null ? null : title,
    "AlternateText": alternateText == null ? null : alternateText,
    "CustomProperties": customProperties.toJson(),
  };
}