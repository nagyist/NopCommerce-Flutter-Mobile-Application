/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/InvalidResponseModel.dart';
import 'package:nopcommerce/Services/ForgotPasswordService.dart';

class ForgotPasswordProvider extends ChangeNotifier {

  bool isAPILoader = true;
  bool isPageLoader = true;
  List<String> errors = [];
  static TextEditingController emailAddress=new TextEditingController();

  pageLoadData({required BuildContext context}){
    isAPILoader = false;
    isPageLoader = false;
    emailAddress.text="";
    errors.clear();
  }

  forgotPasswordClick({required BuildContext context}) async
  {
    isAPILoader = true;
    final body = '{ '
    '"email": "${emailAddress.text}",'
     '}';
    Response response = await ForgotPasswordService().userForgotPassword(context: context, body: body);
    if(response.statusCode == 200){
        emailAddress.clear();
        Navigator.pop(context);
        FlushBarMessage().successMessage(context: context, title: response.body.replaceAll('"', ''));
        isAPILoader = false;
    }else if(response.statusCode == 400)
    {
      InvalidResponseModel errors = invalidResponseModelFromJson(response.body);
      for(var er in errors.errors)
      {
        addError(error: er);
        notifyListeners();
      }
    }
    isAPILoader = false;
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