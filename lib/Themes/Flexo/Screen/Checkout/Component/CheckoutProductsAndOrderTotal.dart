/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/AttributeValueModel.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class CheckoutProductsAndOrderTotal extends StatelessWidget {
  const CheckoutProductsAndOrderTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Container(
        child: Column(
          children: [

            Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),
            Column(
                children:[
                  //Products
                  Container(
                    width: FlexoValues.deviceWidth,
                    child: Column(
                      children: checkoutProvider.getOrderSummaryModel.items.map((e){

                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                  )
                              )
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      checkoutProvider.getOrderSummaryModel.showProductImages ?
                                      GestureDetector(
                                        onTap: (){
                                          setState(()
                                          {
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: 0,isCart: false))).then((value)
                                            {
                                              setState(()
                                              {
                                                checkoutProvider.getHeaderData(context: context);
                                              });
                                            });
                                          });
                                        },
                                        child: Container(
                                          width: FlexoValues.deviceWidth * 0.4,
                                          height: FlexoValues.deviceWidth * 0.4,
                                          padding: EdgeInsets.fromLTRB(FlexoValues.widthSpace1Px, FlexoValues.widthSpace1Px, 0, FlexoValues.widthSpace1Px),
                                          child: CachedNetworkImage(
                                            imageUrl: e.picture.imageUrl,
                                          ),
                                        ),
                                      ) : Container(),

                                      Container(
                                        width: checkoutProvider.getOrderSummaryModel.showProductImages ? FlexoValues.deviceWidth * 0.6 : FlexoValues.deviceWidth,
                                        padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Container(
                                              padding:EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      setState(()
                                                      {
                                                        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: 0,isCart: false))).then((value)
                                                        {
                                                          setState(()
                                                          {
                                                            checkoutProvider.getHeaderData(context: context);
                                                          });
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      child: FlexoTextWidget().productBoxHorizontalText(text: e.productName,maxLines: 3),
                                                      width: FlexoValues.deviceWidth * 0.56,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace1Px),

                                            checkoutProvider.getOrderSummaryModel.showSku && e.sku != null ?
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                  child: FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("ShoppingCart.sku")+": ", subTextList: [e.sku]),

                                                ),

                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                              ],
                                            ) : Container (),

                                            checkoutProvider.getOrderSummaryModel.showVendorName && e.vendorName != null ?
                                            Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                child:Column(
                                                  children: [
                                                    FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("ShoppingCart.VendorName")+": ", subTextList: [e.vendorName]),
                                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                                  ],
                                                )
                                            ) : Container(),

                                            e.attributeInfo == "" || e.attributeInfo == null ? Container() :
                                            Container(
                                                child: Column(
                                                  children: [

                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                      child: RichText(
                                                        text: HTML.toTextSpan(
                                                          context,
                                                          e.attributeInfo,
                                                          defaultTextStyle:TextStyleWidget.contentTextStyle16,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: FlexoValues.heightSpace1Px),
                                                  ],
                                                )
                                            ),

                                            e.recurringInfo == "" || e.recurringInfo == null ? Container() :
                                            Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                      child: RichText(
                                                        text: HTML.toTextSpan(
                                                          context,
                                                          e.recurringInfo,
                                                          defaultTextStyle: TextStyleWidget.contentTextStyle16,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: FlexoValues.heightSpace1Px),
                                                  ],
                                                )
                                            ),

                                            e.rentalInfo == "" || e.rentalInfo == null ? Container() :
                                            Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                      child: RichText(
                                                        text: HTML.toTextSpan(
                                                          context,
                                                          e.rentalInfo,
                                                          defaultTextStyle: TextStyleWidget.contentTextStyle16,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: FlexoValues.heightSpace1Px),
                                                  ],
                                                )
                                            ),

                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child:FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("shoppingCart.UnitPrice")+": ", subTextList: [e.unitPrice]),
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace1Px),

                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child: FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("shoppingCart.itemTotal")+": ", subTextList: [e.subTotal]),
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace1Px),

                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child: FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("ShoppingCart.Quantity")+": ", subTextList: [e.quantity.toString()]),
                                            ),

                                            e.discount != null ?
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  SizedBox(height: FlexoValues.widthSpace1Px),

                                                  Container(
                                                    child: Text(
                                                      localResourceProvider.getResourseByKey("shoppingCart.itemYouSave").toString().replaceAll("{0}", e.discount),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: FlexoValues.fontSize16,
                                                          color: Colors.blue
                                                      ),),
                                                  ),

                                                  e.maximumDiscountedQty != null ?
                                                  Container(
                                                    child: Column(
                                                      children: [

                                                        SizedBox(height: FlexoValues.widthSpace1Px),

                                                        Container(
                                                          child: Text(
                                                            localResourceProvider.getResourseByKey("shoppingCart.maximumDiscountedQty").toString().replaceAll("{0}", e.maximumDiscountedQty.toString()),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: FlexoValues.fontSize16,
                                                                color: Colors.blue
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ) :  Container()
                                                ],
                                              ),
                                            ) : Container(),

                                            SizedBox(height: FlexoValues.heightSpace1Px),
                                          ],

                                        ),
                                      ),

                                    ]
                                ),

                                e.warnings.length > 0 ?
                                Container(
                                  width: FlexoValues.controlsWidth,
                                  padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: e.warnings.map((w){
                                      return Container(
                                        child: FlexoTextWidget().warningMessageText(text: w),
                                      );
                                    }).toList(),
                                  ),
                                ) : Container()
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: FlexoValues.widthSpace2Px),

                  //Custom Attributes
                  Container(
                    child: Column(
                      children: checkoutProvider.getOrderSummaryModel.checkoutAttributes.map((e){
                        bool notValue = true;
                        List<Value> values = [];
                        if(e.attributeControlType==AttributeControlType.Checkboxes || e.attributeControlType==AttributeControlType.ColorSquares|| e.attributeControlType==AttributeControlType.DropdownList || e.attributeControlType==AttributeControlType.RadioList || e.attributeControlType==AttributeControlType.ReadonlyCheckboxes){
                          values= e.values.where((element) => element.isPreSelected).toList();
                          if(values.length>0){
                            setState((){
                              notValue=true;
                            });
                          }else{
                            setState((){
                              notValue=false;
                            });
                          }

                        }
                        if(e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox
                            || e.attributeControlType==AttributeControlType.FileUpload){
                          if(e.defaultValue==null){
                            setState((){
                              notValue=false;
                            });
                          }
                        }

                        if(e.attributeControlType==AttributeControlType.Datepicker){
                          if(e.selectedDay==null || e.selectedYear==null || e.selectedMonth==null){
                            setState((){
                              notValue=false;
                            });
                          }
                        }

                        return Container(
                          width: FlexoValues.deviceWidth,
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child:notValue? Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                e.name!=null && notValue?
                                Container(
                                  child: FlexoTextWidget().headingBoldText16(text: '${e.name}: ',maxLines: 2),
                                ):Container(),

                                e.attributeControlType==AttributeControlType.Datepicker || e.selectedDay!=null?
                                Container(
                                  width: FlexoValues.controlsWidth,
                                  child: FlexoTextWidget().contentText16(text: '${e.selectedYear}-${e.selectedMonth}-${e.selectedDay}',),
                                ):

                                e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                                Container(
                                  width: FlexoValues.controlsWidth,
                                  child: FlexoTextWidget().contentText16(text: e.defaultValue!=null ? e.defaultValue : '',),
                                ):

                                Container(
                                  margin: EdgeInsets.only(bottom: FlexoValues.widthSpace1Px),
                                  child: Wrap(
                                    children: e.values.where((element) => element.isPreSelected).toList().asMap().entries.map((p){
                                      String value = p.value.name;
                                      if(p.value.priceAdjustment != null)
                                      {
                                        value += "[${p.value.priceAdjustment}]";
                                      }

                                      if(e.values.where((element) => element.isPreSelected).length - 1 != p.key)
                                      {
                                        value += ", ";
                                      }

                                      return Container(
                                        child: FlexoTextWidget().contentText16(text: value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ):Container(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: FlexoValues.deviceWidth * 0.5,
                                child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.subtotal")+": "),
                              ),
                              Container(
                                width: FlexoValues.deviceWidth * 0.4,
                                alignment: Alignment.centerRight,
                                child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.subTotal == null ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : checkoutProvider.orderTotalResponseModel.subTotal,),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        checkoutProvider.orderTotalResponseModel.subTotalDiscount != null ?
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.5,
                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.subtotalDiscount")+": ",),
                                  ),
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.subTotalDiscount == null ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : checkoutProvider.orderTotalResponseModel.subTotalDiscount,),
                                  ),
                                ],
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ):Container(),

                        !checkoutProvider.orderTotalResponseModel.hideShippingTotal ?
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.5,
                                    child: FlexoTextWidget().subTotalLeftText(text: checkoutProvider.orderTotalResponseModel.requiresShipping && checkoutProvider.orderTotalResponseModel.selectedShippingMethod != null
                                        ? localResourceProvider.getResourseByKey("shoppingCart.totals.shipping")+": "+"(${checkoutProvider.orderTotalResponseModel.selectedShippingMethod})"
                                        : localResourceProvider.getResourseByKey("shoppingCart.totals.shipping")+": ",),
                                  ),

                                  checkoutProvider.orderTotalResponseModel.requiresShipping ?
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: !checkoutProvider.isShippableProduct ? localResourceProvider.getResourseByKey("shoppingCart.totals.shipping.notRequired") : checkoutProvider.orderTotalResponseModel.shipping != null ? checkoutProvider.orderTotalResponseModel.shipping : localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout"),),
                                   ) :
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: !checkoutProvider.isShippableProduct ? localResourceProvider.getResourseByKey("shoppingCart.totals.shipping.notRequired") : localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout"),),
                                  ),
                                ],
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) : Container(),

                        checkoutProvider.orderTotalResponseModel.paymentMethodAdditionalFee != null ?
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.5,
                                      child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.paymentMethodAdditionalFee")+": ",),
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth * 0.4,
                                      alignment: Alignment.centerRight,
                                      child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.paymentMethodAdditionalFee,),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) :  Container(),

                        checkoutProvider.orderTotalResponseModel.displayTaxRates && checkoutProvider.orderTotalResponseModel.taxRates.length > 0 ?
                        Container(
                          child: Column(
                            children: [
                              Column(
                                  children: checkoutProvider.orderTotalResponseModel.taxRates.map((taxRate)
                                  {
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.5,
                                            child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.taxRateLine").toString().replaceAll("{0}", taxRate.rate)+": ",),
                                          ),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.4,
                                            alignment: Alignment.centerRight,
                                            child: FlexoTextWidget().subTotalRightText(text: taxRate.value,),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) : Container(),

                        checkoutProvider.orderTotalResponseModel.displayTax ?
                        Container(
                          child: Column(
                            children: [

                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.5,
                                      child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.tax")+": ",),
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth * 0.4,
                                      alignment: Alignment.centerRight,
                                      child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.tax == null ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : checkoutProvider.orderTotalResponseModel.tax,),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) :  Container(),


                        checkoutProvider.orderTotalResponseModel.orderTotalDiscount != null ?
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.5,
                                      child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("messages.order.totalDiscount"),),
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth * 0.4,
                                      alignment: Alignment.centerRight,
                                      child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.orderTotalDiscount == null ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : checkoutProvider.orderTotalResponseModel.orderTotalDiscount,),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) : Container(),

                        checkoutProvider.orderTotalResponseModel.giftCards.length > 0 ?
                        Container(
                          child: Column(
                            children: [

                              Container(
                                child: Column(
                                  children: checkoutProvider.orderTotalResponseModel.giftCards.map((e)
                                  {
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.6,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Container(
                                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo")+ ": "+localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo.code").toString().replaceAll("{0}", e.couponCode),),
                                                  ),
                                                ),

                                                Container(
                                                  width: FlexoValues.deviceWidth * 0.3,
                                                  child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo.remaining").toString().replaceAll("{0}", e.remaining),),
                                                 ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            alignment: Alignment.centerRight,
                                            child: FlexoTextWidget().subTotalRightText(text: e.amount),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ): Container(),

                        checkoutProvider.orderTotalResponseModel.redeemedRewardPoints > 0 ?
                        Container(
                          child: Column(
                            children: [

                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.2,
                                      child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints").toString().replaceAll("{0}", checkoutProvider.orderTotalResponseModel.redeemedRewardPoints.toString())+": ",),
                                    ),
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.7,
                                      alignment: Alignment.centerRight,
                                      child: FlexoTextWidget().subTotalRightText(text: checkoutProvider.orderTotalResponseModel.redeemedRewardPointsAmount),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px),
                            ],
                          ),
                        ) : Container(),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: FlexoValues.deviceWidth * 0.2,
                                child: FlexoTextWidget().subTotalLeftTextBold(text: localResourceProvider.getResourseByKey("shoppingCart.totals.orderTotal")+": "),
                              ),
                              Container(
                                width: FlexoValues.deviceWidth * 0.7,
                                alignment: Alignment.centerRight,
                                child: FlexoTextWidget().subTotalRightTextBold(text: checkoutProvider.orderTotalResponseModel.orderTotal == null || checkoutProvider.orderTotalResponseModel.orderTotal == "" ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout") : checkoutProvider.orderTotalResponseModel.orderTotal,),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        checkoutProvider.orderTotalResponseModel.willEarnRewardPoints > 0 ?
                        Container(
                          child: Column(
                            children: [

                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.3,
                                      child: Text(
                                        localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints.willEarn")+": ",
                                        style: TextStyle(
                                            fontSize: FlexoValues.fontSize15,
                                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: FlexoValues.deviceWidth * 0.6,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints.willEarn.point").toString().replaceAll("{0}", checkoutProvider.orderTotalResponseModel.willEarnRewardPoints.toString()),
                                        style: TextStyle(
                                            fontSize: FlexoValues.fontSize15,
                                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) : Container(),

                      ],
                    ),
                  ),
                ]

            ),
          ],
        ),
      );
    });
  }
}
