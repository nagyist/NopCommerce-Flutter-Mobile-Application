/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class DeliveryInfo {
  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            children: [

              getProductDetailsModel.freeShippingNotificationEnabled && getProductDetailsModel.isFreeShipping?
              Column(
                children: [

                  SizedBox(height: FlexoValues.widthSpace2Px),

                  Container(
                    child: Row(
                      children: [

                        Container(
                          child: Icon(
                            Icons.local_shipping_outlined,
                            size: FlexoValues.iconSize22,
                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                          ),
                        ),

                        SizedBox(width: FlexoValues.widthSpace3Px),

                        Container(
                          child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("products.freeShipping"),),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px),
                ],
              ) : Container(),

              getProductDetailsModel.deliveryDate == null || getProductDetailsModel.deliveryDate == "" ? Container() :
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("products.deliveryDate")+": ",),
                        ),

                        Expanded(
                          child: Container(
                            child: FlexoTextWidget().headingBoldText15(text: getProductDetailsModel.deliveryDate,),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}