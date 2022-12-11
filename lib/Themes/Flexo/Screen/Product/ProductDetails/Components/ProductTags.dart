/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTag.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductTags {
  getView({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [
          Container(
            child: Column(
              children: [

                productDetailsProvider.getProductDetailsModel.productTags.isEmpty?Container():
                Container(

                  child: Column(
                    children: [

                      Divider(thickness: 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                      Container(
                        width: FlexoValues.deviceWidth,
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey('products.tags'),),
                      ),

                      SizedBox(height: FlexoValues.heightSpace1Px,),

                      Container(
                        width: FlexoValues.deviceWidth,
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Row(
                          children: productDetailsProvider.getProductDetailsModel.productTags.map((e){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByPopularTag(tagId: e.id,tagName: e.name)));
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: FlexoTextWidget().redirectText16(text: '${e.name}(${e.productCount})',),
                                    ),

                                    productDetailsProvider.getProductDetailsModel.productTags.length - 1 != productDetailsProvider.getProductDetailsModel.productTags.indexOf(e) ?
                                    Container(
                                      child: FlexoTextWidget().redirectText16(text: ', ',),
                                    ) : Container(),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px)
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      );
    });
  }
}