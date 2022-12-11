/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/UserAgreement/UserAgreementProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/CheckboxWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class UserAgreementComponent{

  getUserAgreementComponent({required BuildContext context,}){

    var userAgreementProvider = context.watch<UserAgreementProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return StatefulBuilder(builder: (context,setState){
      return Column(
        children: [
          SizedBox(
            height:FlexoValues.widthSpace5Px,
          ),

          Container(
            width: FlexoValues.deviceWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()
                  {
                    setState((){
                      userAgreementProvider.isAgreement=!userAgreementProvider.isAgreement;
                    });
                  },
                  child: checkboxWidget(isCheck: userAgreementProvider.isAgreement,isReadOnly: false),
                ),

                SizedBox(width:FlexoValues.widthSpace2Px,),

                Container(
                  child: FlexoTextWidget().headingText16(
                    text: userAgreementProvider.userAgreementModel.userAgreementText==null?"": userAgreementProvider.userAgreementModel.userAgreementText,
                  )
                ),
              ],
            ),
          ),

          SizedBox(height: FlexoValues.deviceWidth *  0.06,),

          ButtonWidget().getButton(
              text:localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
              width: FlexoValues.controlsWidth, onClick: ()async{
                if(await CheckConnectivity().checkInternet(context)){
                  userAgreementProvider.continueButtonClick(context: context, orderGuid: userAgreementProvider.userAgreementModel.orderItemGuid);
                }
              },
              isApiLoad:true
          ),

        ],
      );
    });
  }
}