/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

List<StateModel> stateModelFromJson(String str) => List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  StateModel({
    required this.id,
    required this.name,
    required this.customProperties,
  });

  int id;
  String name;
  CustomProperties customProperties;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"],
    name: json["name"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "CustomProperties": customProperties.toJson(),
  };
}