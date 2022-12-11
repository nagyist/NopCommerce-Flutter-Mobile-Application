/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


class PagerModel {
  PagerModel({
    required this.currentPage,
    required this.individualPagesDisplayedCount,
    required this.pageIndex,
    required this.pageSize,
    required this.showFirst,
    required this.showIndividualPages,
    required this.showLast,
    required this.showNext,
    required this.showPagerItems,
    required this.showPrevious,
    required this.showTotalSummary,
    required this.totalPages,
    required this.totalRecords,
    required this.routeActionName,
    required this.useRouteLinks,
    required this.routeValues,
  });

  int currentPage;
  int individualPagesDisplayedCount;
  int pageIndex;
  int pageSize;
  bool showFirst;
  bool showIndividualPages;
  bool showLast;
  bool showNext;
  bool showPagerItems;
  bool showPrevious;
  bool showTotalSummary;
  int totalPages;
  int totalRecords;
  String routeActionName;
  bool useRouteLinks;
  RouteValues routeValues;

  factory PagerModel.fromJson(Map<String, dynamic> json) => PagerModel(
    currentPage: json["CurrentPage"],
    individualPagesDisplayedCount: json["IndividualPagesDisplayedCount"],
    pageIndex: json["PageIndex"],
    pageSize: json["PageSize"],
    showFirst: json["ShowFirst"],
    showIndividualPages: json["ShowIndividualPages"],
    showLast: json["ShowLast"],
    showNext: json["ShowNext"],
    showPagerItems: json["ShowPagerItems"],
    showPrevious: json["ShowPrevious"],
    showTotalSummary: json["ShowTotalSummary"],
    totalPages: json["TotalPages"],
    totalRecords: json["TotalRecords"],
    routeActionName: json["RouteActionName"],
    useRouteLinks: json["UseRouteLinks"],
    routeValues: RouteValues.fromJson(json["RouteValues"]),
  );

  Map<String, dynamic> toJson() => {
    "CurrentPage": currentPage,
    "IndividualPagesDisplayedCount": individualPagesDisplayedCount,
    "PageIndex": pageIndex,
    "PageSize": pageSize,
    "ShowFirst": showFirst,
    "ShowIndividualPages": showIndividualPages,
    "ShowLast": showLast,
    "ShowNext": showNext,
    "ShowPagerItems": showPagerItems,
    "ShowPrevious": showPrevious,
    "ShowTotalSummary": showTotalSummary,
    "TotalPages": totalPages,
    "TotalRecords": totalRecords,
    "RouteActionName": routeActionName,
    "UseRouteLinks": useRouteLinks,
    "RouteValues": routeValues.toJson(),
  };
}

class RouteValues {
  RouteValues({
    required this.pageNumber,
  });

  int pageNumber;

  factory RouteValues.fromJson(Map<String, dynamic> json) => RouteValues(
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
  };
}