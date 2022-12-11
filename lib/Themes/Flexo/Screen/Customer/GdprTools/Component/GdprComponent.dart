/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/GdprTools/GdprToolsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class GdprComponent{

  getGdprComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var gdprToolsProvider = context.watch<GdprToolsProvider>();
    return StatefulBuilder(builder: (context, setState){
      return Container(
        child: Column(
          children: [

            SizedBox(height: FlexoValues.heightSpace2Px,),

            Container(
              padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px,),
              width: FlexoValues.deviceWidth,
              alignment: Alignment.centerLeft,
              child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.gdpr.export"))
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
              width: FlexoValues.deviceWidth,
              child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey( "account.gdpr.export.hint")),
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            ButtonWidget().getButton(text:localResourceProvider.getResourseByKey("account.gdpr.export.button").toString().toUpperCase(),
                width: FlexoValues.controlsWidth, onClick: ()async{
                  if(await CheckConnectivity().checkInternet(context)){
                    gdprToolsProvider.exportButtonClickEvent(context: context);
                   }
                },
                isApiLoad: gdprToolsProvider.isAPILoader
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            Divider(thickness: 1,height: 1,),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            Container(
              width: FlexoValues.deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
              alignment: Alignment.centerLeft,
              child:  FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.gdpr.delete"))
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
              width: FlexoValues.deviceWidth,
              child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("account.gdpr.delete.hint")),
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            ButtonWidget().getButton(text:localResourceProvider.getResourseByKey("account.gdpr.delete.button").toString().toUpperCase(),
                width: FlexoValues.controlsWidth, onClick: ()async{
                  if(await CheckConnectivity().checkInternet(context)){
                    gdprToolsProvider.deleteButtonClickEvent(context: context);
                   }
                  }, isApiLoad: gdprToolsProvider.isAPILoader
            ),

            SizedBox(height: FlexoValues.heightSpace2Px,),

          ],
        ),
      );
    });
  }
}