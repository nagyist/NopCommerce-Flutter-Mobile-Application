/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetailsById/TopicBlockDetailsById.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/ProductDetailsAttributeChangeModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FlexoDatePicker.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TaxDisplayType.dart';
import 'package:nopcommerce/Utils/Enum/TopicType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPriceWidget {
  getView({required BuildContext context,required ProductPrice productPrice})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return Column(
      children: [
        Container(
          child: !productPrice.customerEntersPrice ?
          Column(
            children: [

              productPrice.callForPrice ?
              Container(
                width: FlexoValues.deviceWidth,
                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("products.callForPrice")),
              ) :
              Column(
                children: [

                  productPrice.isRental ?
                  Container(
                    width: FlexoValues.deviceWidth,
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("products.price.rentalPrice")+": "+productPrice.rentalPrice,),
                  ) : Container(),

                  productPrice.oldPrice!=null  ?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Container(
                              child: Text(
                                '${localResourceProvider.getResourseByKey("products.price.oldPrice")}: ',
                                style: TextStyle(
                                    color: FlexoColorConstants.DARK_TEXT_COLOR,
                                    fontSize: FlexoValues.fontSize15,
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  '${productPrice.oldPrice}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(
                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                      fontSize: FlexoValues.fontSize15,
                                      decoration: TextDecoration.lineThrough
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: FlexoValues.widthSpace1Px),

                      ],
                    ),
                  ) :Container(),

                  productPrice.price==null ?
                  Container() :
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: FlexoTextWidget().headingBoldText18(text: '${localResourceProvider.getResourseByKey("products.price")}',),
                            ),
                            Flexible(
                              child: Container(
                                child: FlexoTextWidget().headingBoldText18(text: productPrice.price == null ? '' :': ${productPrice.price}',),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),
                      ],
                    ),
                  ),

                  productPrice.priceWithDiscount==null ?
                  Container() :
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Container(
                              child: Text(
                                '${localResourceProvider.getResourseByKey("products.price.withDiscount")}: ',
                                style: TextStyle(
                                    color: FlexoColorConstants.DARK_TEXT_COLOR,
                                    fontSize: FlexoValues.fontSize15,
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                            ),

                            Container(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 20,
                                text: HTML.toTextSpan(
                                    context,
                                    '${productPrice.priceWithDiscount}',
                                    defaultTextStyle: TextStyle(
                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                      fontSize: FlexoValues.fontSize15,
                                    ),
                                    linksCallback: (url)
                                    {
                                      launch(url!);
                                    }
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: FlexoValues.widthSpace1Px),

                      ],
                    ),
                  ),

                  productPrice.basePricePAngV==null ?
                  Container() : Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Container(
                              child: Text(
                                productPrice.basePricePAngV,
                                style: TextStyle(
                                    color: FlexoColorConstants.DARK_TEXT_COLOR,
                                    fontSize: FlexoValues.fontSize15,
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: FlexoValues.widthSpace1Px),

                      ],
                    ),
                  ),

                  productPrice.displayTaxShippingInfo ?
                  Container(
                    child: Column(
                      children: [

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: HTML.toTextSpan(
                                context,
                                productDetailsProvider.selectedTax == TaxDisplayType.IncludingTax ? localResourceProvider.getResourseByKey("products.price.taxShipping.inclTax") : localResourceProvider.getResourseByKey("products.price.taxShipping.exclTax"),
                                defaultTextStyle: TextStyle(
                                  color: FlexoColorConstants.DARK_TEXT_COLOR,
                                  fontSize: FlexoValues.fontSize15,
                                ),
                                overrideStyle: {
                                  "a": TextStyleWidget.redirectTextStyle16,
                                },
                                linksCallback: (url)
                                {
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetailsById(name: "", seName: "ShippingInfo", topicId: 0, topicType: TopicType.SeName)));
                                }
                            ),
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace5Px,),
                      ],
                    ),
                  ) : Container(),
                ],
              ),
            ],
          ):Container(),
        ),
      ],
    );
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