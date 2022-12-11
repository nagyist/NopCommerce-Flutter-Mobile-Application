/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/CustomerProductReview/CustomerProductReviewProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/RatingBar/rating_bar.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';

class CustomerProductReviewComponent{

  getCustomerProductReviewComponent({required BuildContext context}){

    var customerProductReviewProvider = context.watch<CustomerProductReviewProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return Column(
      children: [
        Column(
          children: customerProductReviewProvider.productReview.map((e){
            return Container(
              width:FlexoValues.deviceWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width:FlexoValues.deviceWidth,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: FlexoColorConstants.LIST_BORDER_COLOR
                            )
                        ),
                        color: FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                      ),
                      padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal:FlexoValues.widthSpace2Px),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: FlexoValues.controlsWidth,
                              child: Text.rich(
                                TextSpan(
                                    text: '${e.title}',
                                    style:TextStyleWidget.headingBoldTextStyle16,
                                    children: [
                                      TextSpan(
                                          text:localResourceProvider.getSettingByName("catalogSettings.productReviewsMustBeApproved")=='True'? e.approvalStatus!=null?' - ${e.approvalStatus}':'':'',
                                          style:TextStyleWidget.headingBoldTextStyle16
                                      ),
                                    ]
                                ),
                              )
                          ),
                        ],
                      )
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px,),

                  Container(
                    width: FlexoValues.deviceWidth,
                    margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    alignment: Alignment.centerRight,
                    child: RatingBar.builder(
                      initialRating: e.rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: FlexoValues.fontSize17,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color:FlexoColorConstants.PRODUCT_RATING_COLOR,
                      ),
                      onRatingUpdate: (rating) {
                        },
                    ),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        FlexoTextWidget().contentText16(text:  e.reviewText,maxLines: 5),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        e.additionalProductReviewList.isNotEmpty?
                        Container(
                          width: FlexoValues.deviceWidth,
                          child: Column(
                            children: e.additionalProductReviewList.map((p){
                              return Container(
                                margin: EdgeInsets.only(bottom: FlexoValues.widthSpace2Px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:  FlexoValues.deviceWidth * 0.6,
                                      child:FlexoTextWidget().headingText16(
                                          text: p.name,
                                          maxLines: 2
                                      )
                                    ),
                                    Container(
                                      child: RatingBar.builder(
                                        initialRating: p.rating.toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: FlexoValues.fontSize17,
                                        ignoreGestures: true,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color:FlexoColorConstants.PRODUCT_RATING_COLOR,
                                        ),
                                        onRatingUpdate: (rating) {

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ):Container(),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Container(
                            width: FlexoValues.deviceWidth,
                            child: Text(
                              "${localResourceProvider.getResourseByKey("account.customerProductReviews.productReviewFor")}:",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleWidget.headingTextStyle16,
                            )
                        ),

                        SizedBox(height: FlexoValues.heightSpace1Px,),

                        Container(
                          width: FlexoValues.deviceWidth,
                          child: RichText(
                            text: new TextSpan(
                                text:e.productName,
                                style: TextStyleWidget.redirectTextStyle16,
                                recognizer: new TapGestureRecognizer()..onTap = () {
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                  {
                                    customerProductReviewProvider.getHeaderData(context: context);
                                  });
                                },
                                children: [
                                  TextSpan(
                                    text:" | ${localResourceProvider.getResourseByKey("reviews.date")}: ${e.writtenOnStr}",
                                    style: TextStyleWidget.contentTextStyle16,
                                  ),
                                ]
                            ),
                          ),
                        ),

                        SizedBox(height:FlexoValues.heightSpace2Px,),

                        e.replyText!=null || e.replyText !=""?
                        Column(
                          children: [
                            Container(
                                width: FlexoValues.deviceWidth,
                                child: Text(
                                  "${localResourceProvider.getResourseByKey("reviews.reply")}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleWidget.headingTextStyle16,
                                )
                            ),
                            SizedBox(height:FlexoValues.heightSpace1Px,),
                            e.replyText!=null?
                            Container(
                              margin: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                              child: RichText(
                                text: HTML.toTextSpan(
                                  context,
                                  e.replyText,
                                  defaultTextStyle: TextStyleWidget.redirectTextStyle16
                                ),
                              ),
                            ):Container(),
                          ],
                        ):Container(),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        SizedBox(height: FlexoValues.widthSpace4Px,),
      ],
    );
  }
}