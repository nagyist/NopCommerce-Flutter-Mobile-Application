/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FlexoDatePicker.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/AddToCartType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:provider/provider.dart';

class RentalInfo {

  TextEditingController startDobController=new TextEditingController();
  TextEditingController endDobController=new TextEditingController();

  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    if(getProductDetailsModel.rentalStartDate!=null)
    {
      startDobController.text = getProductDetailsModel.rentalStartDate.toString();
    }

    if(getProductDetailsModel.rentalEndDate!=null){
      endDobController.text = getProductDetailsModel.rentalEndDate.toString();
    }

    return StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              children: [

                getProductDetailsModel.isRental?
                Column(
                  children: [
                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  width: FlexoValues.deviceWidth * 0.47,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: new TextSpan(
                                        text: localResourceProvider.getResourseByKey("products.rentalStartDate"),
                                        style: TextStyleWidget.controlsHeadingTextStyle,
                                        children: [
                                          TextSpan(
                                            text:" *",
                                            style: TextStyleWidget.controlsRequiredTextStyle,
                                          )
                                        ]
                                    ),
                                  ),
                                ),

                                SizedBox(height: FlexoValues.widthSpace1Px),

                                FlexoDatePickerPlugin(
                                    context: context,
                                    pastDateEnable: false,
                                    showRequiredIcon: false,
                                    futureDateEnable: true,
                                    width: FlexoValues.deviceWidth * 0.47,
                                    controller: startDobController,
                                    onClick: (formattedDate)
                                    {
                                      setState(()
                                      {
                                        startDobController.text =  formattedDate;
                                        getProductDetailsModel.rentalStartDate = formattedDate;
                                        productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                      });
                                    }
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: [

                                Container(
                                  width: FlexoValues.deviceWidth * 0.47,
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: new TextSpan(
                                        text: localResourceProvider.getResourseByKey("products.rentalEndDate"),
                                        style: TextStyleWidget.controlsHeadingTextStyle,
                                        children: [
                                          TextSpan(
                                            text:" *",
                                            style: TextStyleWidget.controlsRequiredTextStyle,
                                          )
                                        ]
                                    ),
                                  ),
                                ),

                                SizedBox(height: FlexoValues.widthSpace1Px),

                                FlexoDatePickerPlugin(
                                    context: context,
                                    showRequiredIcon: false,
                                    pastDateEnable: false,
                                    futureDateEnable: true,
                                    width: FlexoValues.deviceWidth * 0.47,
                                    controller: endDobController,
                                    onClick: (formattedDate)
                                    {
                                      setState(()
                                      {
                                        endDobController.text = formattedDate;
                                        getProductDetailsModel.rentalEndDate = formattedDate;
                                        productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Other,getProductDetailsModel: getProductDetailsModel);
                                      });
                                    }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace4Px),
                  ],
                ):Container()
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