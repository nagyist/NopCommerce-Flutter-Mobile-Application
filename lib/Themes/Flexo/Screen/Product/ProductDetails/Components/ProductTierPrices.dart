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
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ProductTierPrices {
  getView({required BuildContext context,required List<TierPrice> tierPrices})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    final _scrollController = ScrollController();

    return StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              children: [

                tierPrices.isNotEmpty?
                Column(
                  children: [
                    Container(
                      width: FlexoValues.deviceWidth,
                      child:Scrollbar(
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        controller: _scrollController,
                        thickness: 4,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: FlexoColorConstants.BORDER_COLOR
                                ),
                                top: BorderSide(
                                    color: FlexoColorConstants.BORDER_COLOR
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.3,
                                      height: FlexoValues.deviceWidth * 0.12,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: FlexoColorConstants.BORDER_COLOR
                                            ),
                                            bottom: BorderSide(
                                                color: FlexoColorConstants.BORDER_COLOR
                                            ),
                                          ),
                                          color: Colors.grey.shade300
                                      ),
                                      alignment: Alignment.center,
                                      child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("products.tierPrices.quantity"),),
                                    ),
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.3,
                                      height: FlexoValues.deviceWidth * 0.12,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: FlexoColorConstants.BORDER_COLOR
                                            ),
                                            bottom: BorderSide(
                                                color: FlexoColorConstants.BORDER_COLOR
                                            ),
                                          ),
                                          color: Colors.grey.shade300
                                      ),
                                      alignment: Alignment.center,
                                      child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("products.tierPrices.price"),),
                                    ),
                                  ],
                                ),

                                Row(
                                    children: tierPrices.map((e){
                                      return Column(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceWidth * 0.12,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                    color: FlexoColorConstants.BORDER_COLOR
                                                ),
                                                bottom: BorderSide(
                                                    color: FlexoColorConstants.BORDER_COLOR
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: FlexoTextWidget().contentText15(text: '${e.quantity}+',),
                                          ),
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            height: FlexoValues.deviceWidth * 0.12,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                    color: FlexoColorConstants.BORDER_COLOR
                                                ),
                                                bottom: BorderSide(
                                                    color: FlexoColorConstants.BORDER_COLOR
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child:  Text(
                                              '${e.price}',
                                              style: TextStyle(
                                                  fontSize: FlexoValues.fontSize15,
                                                  color: Colors.red
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList()
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) ,
                    ),
                    SizedBox(
                      height: FlexoValues.widthSpace2Px,
                    ),
                  ],
                ):Container(),
              ],
            ),
          ),
        ],
      );
    });
  }

  attributeHeading({required String heading, required bool isRequired, required String description})
  {
    return Container(
      child: Column(
        children: [
          Container(
            width: FlexoValues.controlsWidth,
            child: RichText(
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: new TextSpan(
                  text: heading,
                  style: TextStyleWidget.controlsHeadingTextStyle,
                  children: [
                    isRequired ?
                    TextSpan(
                      text:" *",
                      style: TextStyleWidget.controlsRequiredTextStyle,
                    ) : TextSpan(),
                  ]
              ),
            ),
          ),

          description == "" ? Container() :
          Container(
            width: FlexoValues.controlsWidth,
            child: Column(
              children: [

                SizedBox(height: FlexoValues.widthSpace1Px),

                Container(
                  width: FlexoValues.controlsWidth,
                  child: FlexoTextWidget().contentText15(text: description,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}