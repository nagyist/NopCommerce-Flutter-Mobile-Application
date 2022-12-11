/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'CustomProperties.dart';

class RecurringOrder {
  RecurringOrder({
    required this.startDate,
    required this.cycleInfo,
    required this.nextPayment,
    required this.totalCycles,
    required this.cyclesRemaining,
    required this.initialOrderId,
    required this.canRetryLastPayment,
    required this.initialOrderNumber,
    required this.canCancel,
    required this.id,
    required this.customProperties,
  });

  String startDate;
  String cycleInfo;
  String nextPayment;
  int totalCycles;
  int cyclesRemaining;
  int initialOrderId;
  bool canRetryLastPayment;
  String initialOrderNumber;
  bool canCancel;
  int id;
  CustomProperties customProperties;

  factory RecurringOrder.fromJson(Map<String, dynamic> json) => RecurringOrder(
    startDate: json["StartDate"],
    cycleInfo: json["CycleInfo"],
    nextPayment: json["NextPayment"],
    totalCycles: json["TotalCycles"],
    cyclesRemaining: json["CyclesRemaining"],
    initialOrderId: json["InitialOrderId"],
    canRetryLastPayment: json["CanRetryLastPayment"],
    initialOrderNumber: json["InitialOrderNumber"],
    canCancel: json["CanCancel"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "StartDate": startDate,
    "CycleInfo": cycleInfo,
    "NextPayment": nextPayment,
    "TotalCycles": totalCycles,
    "CyclesRemaining": cyclesRemaining,
    "InitialOrderId": initialOrderId,
    "CanRetryLastPayment": canRetryLastPayment,
    "InitialOrderNumber": initialOrderNumber,
    "CanCancel": canCancel,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}