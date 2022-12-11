/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:meta/meta.dart';
import 'dart:convert';

List<GetSearchTermModel> getSearchTermModelFromJson(String str) => List<GetSearchTermModel>.from(json.decode(str).map((x) => GetSearchTermModel.fromJson(x)));

String getSearchTermModelToJson(List<GetSearchTermModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSearchTermModel {
  GetSearchTermModel({
    required this.productId,
    required this.label,
    required this.productUrl,
    required this.productPictureUrl,
    required this.showLinktoResultSearch,
  });

  int productId;
  String label;
  String productUrl;
  dynamic productPictureUrl;
  bool showLinktoResultSearch;

  factory GetSearchTermModel.fromJson(Map<String, dynamic> json) => GetSearchTermModel(
    productId: json["ProductId"],
    label: json["Label"],
    productUrl: json["ProductURL"],
    productPictureUrl: json["ProductPictureURL"],
    showLinktoResultSearch: json["ShowLinktoResultSearch"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "Label": label,
    "ProductURL": productUrl,
    "ProductPictureURL": productPictureUrl,
    "ShowLinktoResultSearch": showLinktoResultSearch,
  };
}
