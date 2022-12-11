/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Screens/Customer/Register/Register.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';

class NotLoginComponent
{
  getNotLoginComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: FlexoValues.heightSpace2Px,),

              Container(
                width: FlexoValues.deviceWidth,
                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.heightSpace2Px),
                alignment: Alignment.center,
                child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.signInForBetterExperience"),),
              ),

              SizedBox(height: FlexoValues.heightSpace2Px,),

              ButtonWidget().getButton(
                  text: localResourceProvider.getResourseByKey("account.login.loginButton").toString().toUpperCase(),
                  width: FlexoValues.controlsWidth,
                  onClick: ()
                  {
                    Navigator.push(context, PageTransition(type: selectedTransition, child: Login(loginType: LoginTypeAttribute.Other)));
                  },
                  isApiLoad: false
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),

              ButtonWidget().getButton(
                  text: localResourceProvider.getResourseByKey("account.register").toString().toUpperCase(),
                  width: FlexoValues.controlsWidth,
                  onClick: ()
                  {
                    Navigator.push(context, PageTransition(type: selectedTransition, child: Register(loginType: LoginTypeAttribute.Other,)));
                  },
                  isApiLoad: false
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),

              ButtonWidget().getButton(
                  text: localResourceProvider.getResourseByKey("shoppingCart.continueShopping").toString().toUpperCase(),
                  width: FlexoValues.controlsWidth,
                  onClick: ()
                  {
                    Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));
                  },
                  isApiLoad: false
              ),
            ],
          ),
        );
      },
    );
  }
}