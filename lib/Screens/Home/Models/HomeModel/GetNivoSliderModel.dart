/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:meta/meta.dart';
import 'dart:convert';

GetNivoSliderModel getNivoSliderModelFromJson(String str) => GetNivoSliderModel.fromJson(json.decode(str));

String getNivoSliderModelToJson(GetNivoSliderModel data) => json.encode(data.toJson());

class GetNivoSliderModel {
  GetNivoSliderModel({
    required this.picture1Url,
    required this.text1,
    required this.link1,
    required this.altText1,
    required this.picture2Url,
    required this.text2,
    required this.link2,
    required this.altText2,
    required this.picture3Url,
    required this.text3,
    required this.link3,
    required this.altText3,
    required this.picture4Url,
    required this.text4,
    required this.link4,
    required this.altText4,
    required this.picture5Url,
    required this.text5,
    required this.link5,
    required this.altText5,
  });

  String picture1Url;
  String text1;
  String link1;
  String altText1;
  String picture2Url;
  String text2;
  String link2;
  String altText2;
  String picture3Url;
  String text3;
  String link3;
  String altText3;
  String picture4Url;
  String text4;
  String link4;
  String altText4;
  String picture5Url;
  String text5;
  String link5;
  String altText5;

  factory GetNivoSliderModel.fromJson(Map<dynamic, dynamic> json) => GetNivoSliderModel(
    picture1Url: json["Picture1Url"],
    text1: json["Text1"],
    link1: json["Link1"],
    altText1: json["AltText1"],
    picture2Url: json["Picture2Url"],
    text2: json["Text2"],
    link2: json["Link2"],
    altText2: json["AltText2"],
    picture3Url: json["Picture3Url"],
    text3: json["Text3"],
    link3: json["Link3"],
    altText3: json["AltText3"],
    picture4Url: json["Picture4Url"],
    text4: json["Text4"],
    link4: json["Link4"],
    altText4: json["AltText4"],
    picture5Url: json["Picture5Url"],
    text5: json["Text5"],
    link5: json["Link5"],
    altText5: json["AltText5"],
  );

  Map<String, dynamic> toJson() => {
    "Picture1Url": picture1Url,
    "Text1": text1,
    "Link1": link1,
    "AltText1": altText1,
    "Picture2Url": picture2Url,
    "Text2": text2,
    "Link2": link2,
    "AltText2": altText2,
    "Picture3Url": picture3Url,
    "Text3": text3,
    "Link3": link3,
    "AltText3": altText3,
    "Picture4Url": picture4Url,
    "Text4": text4,
    "Link4": link4,
    "AltText4": altText4,
    "Picture5Url": picture5Url,
    "Text5": text5,
    "Link5": link5,
    "AltText5": altText5,
  };
}