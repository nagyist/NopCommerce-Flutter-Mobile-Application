/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ShoppingCartCrossSellProductComponent{

  getCrossSellProduct({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return Column(
      children: [

        Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,height: 1),

        Container(
          margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
          alignment: Alignment.centerLeft,
          child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("shoppingCart.crossSells"),maxLines: 2),
        ),

        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
             // width: FlexoValues.deviceWidth,
              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: homeProvider.crossSellProduct.map((e){
                  return Container(
                    child: ProductBox().getHorizontalProductBox(context: context, productBoxModel: e, localResourceProvider: localResourceProvider,updateHeaderData: homeProvider.getHeaderData),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        SizedBox(height: FlexoValues.heightSpace2Px,)
      ],
    );
  }
}