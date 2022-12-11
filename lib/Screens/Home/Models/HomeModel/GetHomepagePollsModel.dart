/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:nopcommerce/Models/CustomProperties.dart';
import 'dart:convert';

List<GetHomepagePollsModel> getHomepagePollsModelFromJson(String str) => List<GetHomepagePollsModel>.from(json.decode(str).map((x) => GetHomepagePollsModel.fromJson(x)));

String getHomepagePollsModelToJson(List<GetHomepagePollsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHomepagePollsModel {
  GetHomepagePollsModel({
    required this.name,
    required this.alreadyVoted,
    required this.totalVotes,
    required this.answers,
    required this.id,
    required this.customProperties,
  });

  String name;
  bool alreadyVoted;
  int totalVotes;
  List<Answer> answers;
  int id;
  CustomProperties customProperties;

  factory GetHomepagePollsModel.fromJson(Map<String, dynamic> json) => GetHomepagePollsModel(
    name: json["Name"],
    alreadyVoted: json["AlreadyVoted"],
    totalVotes: json["TotalVotes"],
    answers: List<Answer>.from(json["Answers"].map((x) => Answer.fromJson(x))),
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "AlreadyVoted": alreadyVoted,
    "TotalVotes": totalVotes,
    "Answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}

class Answer {
  Answer({
    required this.name,
    required this.numberOfVotes,
    required this.percentOfTotalVotes,
    required this.id,
    required this.customProperties,
  });

  String name;
  int numberOfVotes;
  double percentOfTotalVotes;
  int id;
  CustomProperties customProperties;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    name: json["Name"],
    numberOfVotes: json["NumberOfVotes"],
    percentOfTotalVotes: json["PercentOfTotalVotes"],
    id: json["Id"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "NumberOfVotes": numberOfVotes,
    "PercentOfTotalVotes": percentOfTotalVotes,
    "Id": id,
    "CustomProperties": customProperties.toJson(),
  };
}
