/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';

class OrderNote {
  OrderNote({
    required this.hasDownload,
    required this.note,
    required this.createdOn,
    required this.id,
    required this.customProperties,
  });

  bool hasDownload;
  String note;
  DateTime createdOn;
  int id;
  CustomProperties customProperties;

  factory OrderNote.fromJson(Map<String, dynamic> json) => OrderNote(
    hasDownload: json["HasDownload"],
    note: json["Note"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "HasDownload": hasDownload,
    "Note": note,
    "CreatedOn": createdOn.toIso8601String(),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
