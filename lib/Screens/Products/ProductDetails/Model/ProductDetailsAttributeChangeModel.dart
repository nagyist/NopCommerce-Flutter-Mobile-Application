/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:meta/meta.dart';
import 'dart:convert';

ProductDetailsAttributeChangeModel productDetailsAttributeChangeModelFromJson(String str) => ProductDetailsAttributeChangeModel.fromJson(json.decode(str));

String productDetailsAttributeChangeModelToJson(ProductDetailsAttributeChangeModel data) => json.encode(data.toJson());

class ProductDetailsAttributeChangeModel {
  ProductDetailsAttributeChangeModel({
    required this.productId,
    required this.gtin,
    required this.mpn,
    required this.sku,
    required this.price,
    required this.basepricepangv,
    required this.stockAvailability,
    required this.enabledattributemappingids,
    required this.disabledattributemappingids,
    required this.pictureFullSizeUrl,
    required this.pictureDefaultSizeUrl,
    required this.isFreeShipping,
    required this.message,
  });

  int productId;
  dynamic gtin;
  dynamic mpn;
  String sku;
  String price;
  dynamic basepricepangv;
  String stockAvailability;
  List<dynamic> enabledattributemappingids;
  List<dynamic> disabledattributemappingids;
  String pictureFullSizeUrl;
  String pictureDefaultSizeUrl;
  bool isFreeShipping;
  dynamic message;

  factory ProductDetailsAttributeChangeModel.fromJson(Map<String, dynamic> json) => ProductDetailsAttributeChangeModel(
    productId: json["ProductId"],
    gtin: json["Gtin"],
    mpn: json["Mpn"],
    sku: json["Sku"],
    price: json["Price"],
    basepricepangv: json["Basepricepangv"],
    stockAvailability: json["StockAvailability"],
    enabledattributemappingids: List<dynamic>.from(json["Enabledattributemappingids"].map((x) => x)),
    disabledattributemappingids: List<dynamic>.from(json["Disabledattributemappingids"].map((x) => x)),
    pictureFullSizeUrl: json["PictureFullSizeUrl"],
    pictureDefaultSizeUrl: json["PictureDefaultSizeUrl"],
    isFreeShipping: json["IsFreeShipping"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "Gtin": gtin,
    "Mpn": mpn,
    "Sku": sku,
    "Price": price,
    "Basepricepangv": basepricepangv,
    "StockAvailability": stockAvailability,
    "Enabledattributemappingids": List<dynamic>.from(enabledattributemappingids.map((x) => x)),
    "Disabledattributemappingids": List<dynamic>.from(disabledattributemappingids.map((x) => x)),
    "PictureFullSizeUrl": pictureFullSizeUrl,
    "PictureDefaultSizeUrl": pictureDefaultSizeUrl,
    "IsFreeShipping": isFreeShipping,
    "Message": message,
  };
}
