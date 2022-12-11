/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductReview/ProductReviewProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/RatingBar/rating_bar.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ProductReviewListComponent{

  getProductReviewListComponent({required BuildContext context}){

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productReviewProvider = context.watch<ProductReviewProvider>();

    return StatefulBuilder(
        builder: (context,setState){
          return productReviewProvider.getProductReviewsModel.items.length > 0 ?
          Container(
            child: Column(
              children: [
                SizedBox(height: FlexoValues.widthSpace4Px),

                productReviewProvider.getProductReviewsModel.items.isEmpty?Container():
                Container(
                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.center,
                  child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("reviews.existingReviews"),),
                ),

                SizedBox(height: FlexoValues.widthSpace2Px),

                Container(
                  child: Column(
                    children: productReviewProvider.getProductReviewsModel.items.map((e){
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: FlexoColorConstants.LIST_BORDER_COLOR
                            )
                        ),
                        margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px),
                              color: FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                              child: Row(
                                children: [

                                  Container(
                                    width:FlexoValues.deviceWidth * 0.7,
                                    child: FlexoTextWidget().headingBoldText16(text: e.title,),
                                  ),

                                ],
                              ),
                            ),

                            Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,height: 1,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                              alignment: Alignment.topRight,
                              child: RatingBar.builder(
                                initialRating: e.rating.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                ignoreGestures: true,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: FlexoValues.fontSize17,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                                ),
                                onRatingUpdate: (rating) {
                                  },
                              ),
                            ),

                            Container(
                              width: FlexoValues.controlsWidth,
                              padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  e.customerAvatarUrl == null ? Container() :
                                  Container(
                                    height: FlexoValues.deviceWidth * 0.3,
                                    width: FlexoValues.deviceWidth * 0.3,
                                    margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                                        )
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: e.customerAvatarUrl,
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      child: FlexoTextWidget().contentText16(text: e.reviewText,),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            e.additionalProductReviewList.isEmpty?Container():
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: Column(
                                children: e.additionalProductReviewList.map((r){
                                  return  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: FlexoValues.controlsWidth,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: FlexoValues.deviceWidth * 0.6,
                                                child: FlexoTextWidget().headingText15(text: r.name,),
                                              ),
                                              Container(
                                                width: FlexoValues.deviceWidth * 0.3,
                                                alignment: Alignment.centerRight,
                                                child: RatingBar.builder(
                                                  initialRating: r.rating.toDouble(),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  ignoreGestures: true,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: FlexoValues.fontSize17,
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: FlexoValues.widthSpace2Px)
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            Container(
                              width: FlexoValues.controlsWidth,
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: RichText(
                                text: new TextSpan(
                                    text: "${localResourceProvider.getResourseByKey("reviews.from")}:",
                                    style: TextStyleWidget.headingTextStyle16,
                                    children: [
                                      TextSpan(
                                        text:" ${e.customerName}",
                                        style: e.allowViewingProfiles ? TextStyleWidget.redirectTextStyle16 :  TextStyleWidget.headingTextStyle16,
                                        recognizer: new TapGestureRecognizer()..onTap = () {
                                          if(e.allowViewingProfiles)
                                          {
                                          }
                                        },
                                      ),
                                      TextSpan(
                                        text:" | ${localResourceProvider.getResourseByKey("rewardPoints.fields.createdDate")}: ${e.writtenOnStr}",
                                        style: TextStyleWidget.headingTextStyle16
                                      ),
                                    ]),
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("reviews.helpfulness.wasHelpful?"),),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                            bool response = await productReviewProvider.reviewHelpfulnessClick(context: context, productReviewId: e.id, isHelpful: true);
                                            if(response)
                                            {
                                              e.helpfulness.helpfulYesTotal = productReviewProvider.setProductReviewHelpfulnessModel.totalYes;
                                              e.helpfulness.helpfulNoTotal = productReviewProvider.setProductReviewHelpfulnessModel.totalNo;
                                              FlushBarMessage().simpleMessage(context: context, title: productReviewProvider.setProductReviewHelpfulnessModel.result);
                                            }
                                          },
                                          child: Container(
                                            child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("common.yes"),),
                                          ),
                                        ),
                                        SizedBox(width: FlexoValues.widthSpace2Px),
                                        GestureDetector(
                                          onTap: ()async{
                                            bool response = await productReviewProvider.reviewHelpfulnessClick(context: context, productReviewId: e.id, isHelpful: false);
                                            if(response)
                                            {
                                              e.helpfulness.helpfulYesTotal = productReviewProvider.setProductReviewHelpfulnessModel.totalYes;
                                              e.helpfulness.helpfulNoTotal = productReviewProvider.setProductReviewHelpfulnessModel.totalNo;
                                              FlushBarMessage().simpleMessage(context: context, title: productReviewProvider.setProductReviewHelpfulnessModel.result);
                                            }
                                          },
                                          child: Container(
                                            child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("common.no"),),
                                          ),
                                        ),

                                        SizedBox(width: FlexoValues.widthSpace2Px),

                                        Container(
                                          child: FlexoTextWidget().headingText16(text: "(${e.helpfulness.helpfulYesTotal}/${e.helpfulness.helpfulNoTotal})",),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: FlexoValues.widthSpace2Px)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ) : Container();
        }
    );
  }
}
