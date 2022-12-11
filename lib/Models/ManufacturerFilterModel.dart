/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'CustomProperties.dart';

class ManufacturerFilter {
  ManufacturerFilter({
    required this.enabled,
    required this.manufacturers,
    required this.customProperties,
  });

  bool enabled;
  List<dynamic> manufacturers;
  CustomProperties customProperties;

  factory ManufacturerFilter.fromJson(Map<String, dynamic> json) => ManufacturerFilter(
    enabled: json["Enabled"],
    manufacturers: List<dynamic>.from(json["Manufacturers"].map((x) => x)),
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "Manufacturers": List<dynamic>.from(manufacturers.map((x) => x)),
    "CustomProperties": customProperties.toJson(),
  };
}
