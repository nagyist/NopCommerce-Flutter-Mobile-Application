/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/RatingBar/rating_bar.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductReview/ProductReviewProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:provider/provider.dart';

class ProductReviewAddComponent{

  GlobalKey<FormState> form = new GlobalKey<FormState>();
  getProductReviewAddComponent({required BuildContext context})  {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productReviewProvider = context.watch<ProductReviewProvider>();

    return Form(
      key: form,
      child: Column(
        children: [
          SizedBox(height: FlexoValues.deviceWidth * 0.06),
          Container(
            width: FlexoValues.deviceWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: FlexoTextWidget().headingText17(text: localResourceProvider.getResourseByKey("reviews.write"),),
          ),

          SizedBox(height: FlexoValues.widthSpace4Px),

          !productReviewProvider.getProductReviewsModel.addProductReview.canCurrentCustomerLeaveReview ?
          Column(
            children: [
              Container(
                child: FlexoTextWidget().warningMessageText(text: localResourceProvider.getResourseByKey("reviews.onlyRegisteredUserScanWriteReviews")),
              ),

              SizedBox(height: FlexoValues.widthSpace4Px),
            ],
          ) : Container(),

          TextFieldWidget(
            width: FlexoValues.controlsWidth,
            controller: productReviewProvider.reviewTitleController,
            required: true,
            hintText: localResourceProvider.getResourseByKey("reviews.fields.title"),
            maxLine: 1,
            heading: localResourceProvider.getResourseByKey("reviews.fields.title"),
            errorMsg: localResourceProvider.getResourseByKey("reviews.fields.title.required"),
            keyBoardType: TextInputType.name,
            enable: productReviewProvider.getProductReviewsModel.addProductReview.canCurrentCustomerLeaveReview,
          ),

          SizedBox(height: FlexoValues.widthSpace2Px),

          TextFieldWidget(
            width: FlexoValues.controlsWidth,
            controller: productReviewProvider.reviewTextController,
            required: true,
            hintText: localResourceProvider.getResourseByKey("reviews.fields.reviewText"),
            maxLine: 5,
            heading: localResourceProvider.getResourseByKey("reviews.fields.reviewText"),
            errorMsg: localResourceProvider.getResourseByKey("reviews.fields.reviewText.required"),
            keyBoardType: TextInputType.name,
            enable: productReviewProvider.getProductReviewsModel.addProductReview.canCurrentCustomerLeaveReview,
          ),

          SizedBox(height: FlexoValues.heightSpace1Px,),

          Divider(color: FlexoColorConstants.BORDER_COLOR,thickness: 1,),

          Container(
            width: FlexoValues.deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  alignment: Alignment.center,
                  child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("reviews.fields.rating"),),
                ),

                SizedBox(height: FlexoValues.widthSpace2Px),

                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: FlexoValues.deviceWidth * 0.2,
                        alignment: Alignment.centerRight,
                        child: Text(
                          localResourceProvider.getResourseByKey("reviews.fields.rating.bad"),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: FlexoValues.fontSize15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Container(
                        width: FlexoValues.deviceWidth * 0.5,
                        alignment: Alignment.center,
                        child: RatingBar.builder(
                          initialRating: productReviewProvider.rating.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: FlexoValues.fontSize22,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                          ),
                          onRatingUpdate: (rating) {
                            productReviewProvider.rating=rating.toInt();
                          },
                        ),
                      ),

                      Container(
                        width: FlexoValues.deviceWidth * 0.2,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localResourceProvider.getResourseByKey("reviews.fields.rating.excellent"),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: FlexoValues.fontSize15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(color: FlexoColorConstants.BORDER_COLOR,thickness: 1,),

          Container(
            child: Column(
              children: productReviewProvider.getProductReviewsModel.reviewTypeList.map((e){
                productReviewProvider.customReview[e.id]={
                  '"reviewTypeId"':e.id,
                  '"rating"': productReviewProvider.dynamicRating
                };
                return Container(
                  child: Column(
                    children: [
                      Container(
                        width: FlexoValues.deviceWidth,
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        alignment: Alignment.center,
                        child: FlexoTextWidget().headingBoldText16(text: e.name,),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px),

                      Container(
                        width: FlexoValues.deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: FlexoValues.deviceWidth * 0.2,
                              alignment: Alignment.centerRight,
                              child: Text(
                                localResourceProvider.getResourseByKey("reviews.fields.rating.bad"),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: FlexoValues.fontSize15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: FlexoValues.deviceWidth * 0.5,
                              alignment: Alignment.center,
                              child: RatingBar.builder(
                                initialRating: productReviewProvider.dynamicRating.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: FlexoValues.fontSize22,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                                ),
                                onRatingUpdate: (rating) {
                                  productReviewProvider.dynamicRating=rating.toInt();
                                  productReviewProvider.customReview[e.id]={
                                    '"reviewTypeId"':e.id,
                                    '"rating"':productReviewProvider.dynamicRating
                                  };

                                },
                              ),
                            ),
                            Container(
                              width: FlexoValues.deviceWidth * 0.2,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                localResourceProvider.getResourseByKey("reviews.fields.rating.excellent"),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: FlexoValues.fontSize15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(color: FlexoColorConstants.BORDER_COLOR,thickness: 1,),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: FlexoValues.widthSpace2Px),

          ButtonWidget().getButton(
            text: localResourceProvider.getResourseByKey("reviews.submitButton").toString().toUpperCase(),
            width: FlexoValues.controlsWidth,
            onClick: ()
            {
              KeyboardUtil.hideKeyboard(context);
              if(form.currentState!.validate()){
                if(productReviewProvider.getProductReviewsModel.addProductReview.canCurrentCustomerLeaveReview){
                  if (localResourceProvider.getSettingByName("catalogSettings.productReviewsMustBeApproved")=='False') {
                    productReviewProvider.submitReview(context: context);
                  }else{
                    FlushBarMessage().warningMessage(context: context, title: localResourceProvider.getResourseByKey("reviews.seeAfterApproving"));
                    productReviewProvider.reviewTextController.clear();
                    productReviewProvider.reviewTitleController.clear();
                  }
                }else{
                  FlushBarMessage().failedMessage(context: context, title: localResourceProvider.getResourseByKey("reviews.onlyRegisteredUserScanWriteReviews"));
                  productReviewProvider.reviewTextController.clear();
                  productReviewProvider.reviewTitleController.clear();
                }
              }
            },
            isApiLoad: false
          ),
        ],
      ),
    );
  }
}