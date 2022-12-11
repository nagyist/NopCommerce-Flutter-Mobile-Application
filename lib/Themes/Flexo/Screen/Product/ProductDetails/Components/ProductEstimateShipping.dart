/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingChangeRequestModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingModel.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/ProductEstimateShipping.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductEstimateShipping {
  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel, required Map<int,ProductEstimateShippingChangeRequestModel> estimateShippingMap,required ProductEstimateShippingModel productEstimateShippingModel})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return StatefulBuilder(builder: (context, setState){

      String estimateShippingString = "";
      setState(()
      {
        if(estimateShippingMap.isNotEmpty)
        {
          ProductEstimateShippingChangeRequestModel requestModel = estimateShippingMap[getProductDetailsModel.id]!;

          estimateShippingString = localResourceProvider.getResourseByKey("products.estimateShipping.toAddress")+" "+ requestModel.countryName+", ${requestModel.stateId == 0 ? "" : requestModel.stateName+", "}${getProductDetailsModel.productEstimateShipping.useCity ? requestModel.city : requestModel.zipPostalCode} "+ localResourceProvider.getResourseByKey("products.estimateShipping.viaProvider")+" ${requestModel.name}";
        }
      });

      return Container(
        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
        child: Column(
          children: [

            getProductDetailsModel.productEstimateShipping.enabled?
            getProductDetailsModel.productEstimateShipping.countryId == "0" ?
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageTransition(type: selectedTransition, child: ProductEstimateShippingPopup(getProductDetailsModel,estimateShippingMap[getProductDetailsModel.id]!))).then((value) {
                  print("value $value");
                  if(value != null)
                  {
                    productDetailsProvider.updateEstimateData(context: context,getProductDetailsModel: getProductDetailsModel, requestModel: value);
                  }
                });
              },
              child: Container(
                width: FlexoValues.controlsWidth,
                child: RichText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: new TextSpan(
                      text: localResourceProvider.getResourseByKey("products.estimateShipping.noSelectedShippingOption"),
                      style: TextStyleWidget.headingTextStyle16,
                      children: [
                        TextSpan(
                          text:" ▼",
                          style: TextStyleWidget.headingTextStyle14,
                        )
                      ]
                  ),
                ),
              ),
            ) :
            Container(
              width: FlexoValues.deviceWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: FlexoValues.controlsWidth,
                    child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("products.estimateShipping.priceTitle") + " ${productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.price}",),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: selectedTransition, child: ProductEstimateShippingPopup(getProductDetailsModel,estimateShippingMap[getProductDetailsModel.id]!))).then((value) {
                        if(value != null)
                        {
                          productDetailsProvider.updateEstimateData(context: context,getProductDetailsModel: getProductDetailsModel, requestModel: value);
                        }
                      });
                    },
                    child: Container(
                      width: FlexoValues.controlsWidth,
                      child: RichText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: new TextSpan(
                            text: estimateShippingString,
                            style: TextStyleWidget.headingTextStyle16,
                            children: [
                              TextSpan(
                                text:" ▼",
                                style: TextStyleWidget.headingTextStyle14,
                              )
                            ]
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px),

                  productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.deliveryDateFormat == null || productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.deliveryDateFormat == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("products.estimateShipping.estimatedDeliveryPrefix") + " ${productEstimateShippingModel.shippingOptions.where((element) => element.selected).first.deliveryDateFormat}",),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px),
                ],
              ),
            ) :
            Container(),
          ],
        ),
      );
    });
  }
}