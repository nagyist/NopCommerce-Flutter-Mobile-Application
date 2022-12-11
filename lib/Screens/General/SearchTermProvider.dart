/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Models/GetSearchTermModel.dart';
import 'package:nopcommerce/Services/SearchTermService.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class SearchTermProvider extends ChangeNotifier {


  List<String> errors = [];
  bool isLoadProduct = false;
  TextEditingController searchText=new TextEditingController();
  bool isSearchProduct=false;
  List<GetSearchTermModel> getSearchTermModel=[];

  List<GetSearchTermModel> matches = [];
  List<GetSearchTermModel> matchesData = [];
  var headerModelData;
  HeaderInfoResponseModel headerModel = new HeaderInfoResponseModel(
      isAuthenticated: false,
      customerName: "",
      shoppingCartEnabled: false,
      shoppingCartItems: 0,
      wishlistEnabled: false,
      wishlistItems: 0,
      allowPrivateMessages: false,
      unreadPrivateMessages: "",
      alertMessage: "",
      registrationType: "",
      customProperties: CustomProperties()
  );

  searchTermData( BuildContext context, String searchTerm)async
  {

    Response response=await SearchTermService().getSearchTerm(context: context, param: "/$searchTerm");

    if(response.statusCode == 200) {

      matches=matchesData;
      getSearchTermModel=getSearchTermModelFromJson(response.body);
      matchesData.addAll(getSearchTermModel);
      isSearchProduct=false;


    }else if(response.statusCode == 400)
    {
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      for(var er in errors.errors)
      {
        addError(error: er);

      }
    }

    notifyListeners();
  }


  void addError({required String error}) {
    if (!errors.contains(error))
    {
      errors.add(error);
      notifyListeners();
    }

  }

}