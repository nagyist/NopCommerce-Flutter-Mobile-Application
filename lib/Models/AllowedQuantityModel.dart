/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

class AllowedQuantity {
  AllowedQuantity({
    required this.disabled,
    required this.group,
    required this.selected,
    required this.text,
    required this.value,
  });

  bool disabled;
  dynamic group;
  bool selected;
  String text;
  String value;

  factory AllowedQuantity.fromJson(Map<String, dynamic> json) => AllowedQuantity(
    disabled: json["Disabled"],
    group: json["Group"],
    selected: json["Selected"],
    text: json["Text"],
    value: json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Disabled": disabled,
    "Group": group,
    "Selected": selected,
    "Text": text,
    "Value": value,
  };
}