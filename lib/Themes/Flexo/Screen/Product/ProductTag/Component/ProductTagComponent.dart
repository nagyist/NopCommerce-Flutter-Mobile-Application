/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTag.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/ProductTagProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductTagComponent{
  getProductTagComponent(BuildContext context)
  {
    var productTagProvider = context.watch<ProductTagProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        return Container(
          width: FlexoValues.deviceWidth,
          child: Wrap(
            children: productTagProvider.getPopularProductTagsModel.tags.map((e){
              return GestureDetector(
                onTap: (){
                 Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByPopularTag(tagId: e.id, tagName: e.name)));
                },
                child: Container(
                  height:FlexoValues.deviceWidth * 0.07,
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace1Px ),
                  child: Text(
                    e.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: e.productCount>15 ? FlexoValues.fontSize18 :FlexoValues.fontSize14,
                        color: FlexoColorConstants.DARK_TEXT_COLOR,
                        fontWeight: e.productCount>15? FontWeight.bold:FontWeight.normal
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}