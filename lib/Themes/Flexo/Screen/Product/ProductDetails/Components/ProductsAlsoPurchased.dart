/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ProductsAlsoPurchased{

  getView({required BuildContext context,required Function({required BuildContext context}) loadData})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return Container(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Divider(thickness: 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

          Container(
            width: FlexoValues.deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            alignment: Alignment.centerLeft,
            child: Container(
              child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey('products.alsoPurchased'),),
            ),
          ),


          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                child: Row(
                  children: productDetailsProvider.getProductsAlsoPurchasedModel.map((e){
                    return Container(
                      child: ProductBox().getHorizontalProductBox(context: context, productBoxModel: e, localResourceProvider: localResourceProvider, updateHeaderData: loadData),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}