/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestDetail.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class OrderTotalPriceComponent{

  getOrderTotalPrice({required BuildContext context}){
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    var inclTax = orderDetailsProvider.getOrderDetailsModel.pricesIncludeTax;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: FlexoColorConstants.LIST_BORDER_COLOR
                  )
              )
          ),
          child: Column(
            children: [
              SizedBox(height: FlexoValues.widthSpace2Px,),

              orderDetailsProvider.getOrderDetailsModel.items.length>0 && orderDetailsProvider.getOrderDetailsModel.displayTaxShippingInfo?
              Column(
                children: [
                  Container(
                    width: FlexoValues.controlsWidth,
                    child: RichText(
                      text: HTML.toTextSpan(
                        context,
                        inclTax? "${localResourceProvider.getResourseByKey("order.taxShipping.inclTax")}:" :"${localResourceProvider.getResourseByKey( "order.taxShipping.exclTax")}:",
                        defaultTextStyle: TextStyle(
                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                          fontSize:FlexoValues.fontSize16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.checkoutAttributeInfo.isNotEmpty?
              Column(
                children: [
                  Container(
                    width: FlexoValues.controlsWidth,
                    child: RichText(
                      text: HTML.toTextSpan(
                          context,
                          '${orderDetailsProvider.getOrderDetailsModel.checkoutAttributeInfo}',
                          defaultTextStyle: TextStyle(
                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                            fontSize:FlexoValues.fontSize16,
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height:FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlexoTextWidget().contentText16(
                      text: "${localResourceProvider.getResourseByKey("shoppingCart.totals.subtotal")}:",
                    ),
                    FlexoTextWidget().contentText16(
                      text: orderDetailsProvider.getOrderDetailsModel.orderSubtotal,
                    ),
                  ],
                ),
              ),
              SizedBox(height:FlexoValues.widthSpace2Px,),

              orderDetailsProvider.getOrderDetailsModel.orderSubTotalDiscount!=null?
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.subTotalDiscount")}:",
                        ),
                        FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.orderSubTotalDiscount,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.isShippable?
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.shipping")}:",
                        ),
                        FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.orderShipping,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.paymentMethodAdditionalFee!=null?
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlexoTextWidget().contentText16(
                          text:  "${localResourceProvider.getResourseByKey("messages.order.paymentMethodAdditionalFee")}",
                        ),
                        FlexoTextWidget().contentText16(
                          text:  orderDetailsProvider.getOrderDetailsModel.paymentMethodAdditionalFee,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.displayTaxRates && orderDetailsProvider.getOrderDetailsModel.taxRates.length>0?
              Container(
                child: Column(
                  children: [
                    Column(
                      children: orderDetailsProvider.getOrderDetailsModel.taxRates.map((e){
                        String code=localResourceProvider.getResourseByKey("order.taxRateLine");
                        code=code.replaceAll('{0}', e.rate);
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlexoTextWidget().headingText16(
                                text:"$code:",
                              ),
                              FlexoTextWidget().headingText16(
                                text:e.value,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height:FlexoValues.widthSpace2Px,),
                  ],
                ),
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.displayTax?
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey("order.tax")}:",
                        ),
                        FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.tax,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.orderTotalDiscount==null? Container():
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.totalDiscount")}:",
                        ),
                        FlexoTextWidget().contentText16(
                          text: '${orderDetailsProvider.getOrderDetailsModel.orderTotalDiscount}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: FlexoValues.widthSpace2Px,),
                ],
              ),

              orderDetailsProvider.getOrderDetailsModel.orderTotalDiscount != null ?
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: FlexoValues.deviceWidth *0.5,
                            child: FlexoTextWidget().headingText16(
                                text: localResourceProvider.getResourseByKey("messages.order.totalDiscount")
                            )
                          ),
                          Container(
                            width: FlexoValues.deviceWidth*0.4,
                            alignment: Alignment.centerRight,
                            child: Text(
                              orderDetailsProvider.getOrderDetailsModel.orderTotalDiscount == null ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : orderDetailsProvider.getOrderDetailsModel.orderTotalDiscount,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize16,
                                  color:FlexoColorConstants.DARK_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px),
                  ],
                ),
              ) : Container(),

              orderDetailsProvider.getOrderDetailsModel.giftCards.isNotEmpty?Container(
                child: Column(
                  children: [
                    Column(
                      children: orderDetailsProvider.getOrderDetailsModel.giftCards.map((e){
                        String code=localResourceProvider.getResourseByKey("messages.order.giftCardInfo");
                        code=code.replaceAll('{0}', e.couponCode);
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlexoTextWidget().headingText16(
                                text:"$code",
                              ),
                              FlexoTextWidget().headingText16(
                                text:e.amount,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height:FlexoValues.widthSpace2Px,),
                  ],
                ),
              ):Container(),

              orderDetailsProvider.getOrderDetailsModel.redeemedRewardPoints > 0 ?
              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Column(
                  children: [

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: FlexoValues.deviceWidth*0.4,
                            child: Text(
                              localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints").toString().replaceAll("{0}", orderDetailsProvider.getOrderDetailsModel.redeemedRewardPoints.toString())+" :",
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize16,
                                  color:FlexoColorConstants.BUTTON_COLOR,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                          Container(
                            width: FlexoValues.deviceWidth*0.5,
                            alignment: Alignment.centerRight,
                            child: Text(
                              orderDetailsProvider.getOrderDetailsModel.redeemedRewardPointsAmount,
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize16,
                                  color: FlexoColorConstants.BUTTON_COLOR,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px,),
                  ],
                ),
              ) : Container(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlexoTextWidget().headingBoldText17(
                      text:"${localResourceProvider.getResourseByKey("order.orderTotal")}:",
                    ),
                    FlexoTextWidget().headingBoldText17(
                      text:orderDetailsProvider.getOrderDetailsModel.orderTotal,
                    ),
                  ],
                ),
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),

              !orderDetailsProvider.getOrderDetailsModel.printMode?
              Container(
                child: Column(
                  children: [
                    orderDetailsProvider.getOrderDetailsModel.isReOrderAllowed?
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                      child: GestureDetector(
                        onTap: ()async{
                          if(await CheckConnectivity().checkInternet(context) )
                          {
                            orderDetailsProvider.reOrderOnClickEvent(context: context, orderId: orderDetailsProvider.getOrderDetailsModel.id);
                          }
                        },
                        child: Container(
                          height: FlexoValues.deviceHeight*0.07,
                          decoration: BoxDecoration(
                            color:FlexoColorConstants.BUTTON_COLOR,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            localResourceProvider.getResourseByKey("order.reorder").toString().toUpperCase(),
                            style: TextStyle(
                                fontSize:FlexoValues.fontSize17,
                                color:FlexoColorConstants.BUTTON_TEXT_COLOR,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ):Container(),

                    orderDetailsProvider.getOrderDetailsModel.isReturnRequestAllowed?
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                      child: Column(
                        children: [
                          SizedBox(height: FlexoValues.widthSpace2Px,),

                          GestureDetector(
                            onTap: ()async{
                              if(await CheckConnectivity().checkInternet(context))
                              {
                                Navigator.push(context, PageTransition(type: selectedTransition, child: ReturnRequestDetail(orderDetailsProvider.getOrderDetailsModel.id,  orderDetailsProvider.getOrderDetailsModel.customOrderNumber)));
                              }
                            },
                            child: Container(
                              child: Container(
                                height: FlexoValues.deviceHeight*0.07,
                                decoration: BoxDecoration(
                                  color:FlexoColorConstants.BUTTON_COLOR,
                                ),
                                child: Center(
                                  child: Text(
                                    localResourceProvider.getResourseByKey("order.returnItems").toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: FlexoValues.fontSize17,
                                        color:FlexoColorConstants.BUTTON_TEXT_COLOR,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) :Container(),

                  ],
                ),
              ):Container(),
              SizedBox(height:FlexoValues.widthSpace2Px,),
            ],
          ),
        );
      },
    );
  }
}

