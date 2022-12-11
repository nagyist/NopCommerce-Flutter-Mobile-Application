/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class OrderDetailComponent{
  getOrderDetail({required BuildContext context}){
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        DateTime date = orderDetailsProvider.getOrderDetailsModel.createdOn;
        return  Container(
          width:FlexoValues.deviceWidth,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color:FlexoColorConstants.LIST_BORDER_COLOR
                  )
              )
          ),
          child: Column(
            children: [

              SizedBox(height:FlexoValues.widthSpace2Px),

              !orderDetailsProvider.getOrderDetailsModel.printMode ?
              Container(
                width: FlexoValues.deviceWidth,
                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()async {
                        if(await CheckConnectivity().checkInternet(context))
                        {
                          orderDetailsProvider.printButtonClickEvent(context: context, orderId:  orderDetailsProvider.getOrderDetailsModel.id);
                        }
                      },
                      child: Container(
                        child: Container(
                          width: orderDetailsProvider.getOrderDetailsModel.pdfInvoiceDisabled ? FlexoValues.controlsWidth:FlexoValues.deviceWidth*0.47,
                          height: FlexoValues.heightSpace5Px,
                          decoration: BoxDecoration(
                            color:FlexoColorConstants.BUTTON_COLOR,
                          ),
                          child: Center(
                            child: Text(
                              localResourceProvider.getResourseByKey("order.print").toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize17,
                                  color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    !orderDetailsProvider.getOrderDetailsModel.pdfInvoiceDisabled ?
                    GestureDetector(
                      onTap: ()async{
                        if(await CheckConnectivity().checkInternet(context))
                        {
                          orderDetailsProvider.pdfInvoiceButtonClickEvent(context: context, orderId: orderDetailsProvider.getOrderDetailsModel.id);
                        }
                      },
                      child: Container(
                        child: Container(
                          width:FlexoValues.deviceWidth*0.47,
                          height:FlexoValues.heightSpace5Px,
                          decoration: BoxDecoration(
                            color:FlexoColorConstants.BUTTON_COLOR,
                          ),
                          child: Center(
                            child: Text(
                              localResourceProvider.getResourseByKey("order.getPdfInvoice").toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize17,
                                  color:FlexoColorConstants.BUTTON_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ):Container(),

              SizedBox(height:FlexoValues.widthSpace2Px,),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: FlexoTextWidget().headingBoldText17(
                            text:"${localResourceProvider.getResourseByKey('order.order#').toString().toUpperCase()}${orderDetailsProvider.getOrderDetailsModel.customOrderNumber}",
                        )
                    ),
                    SizedBox(height: FlexoValues.heightSpace1Px,),
                    Container(
                        child: FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey('order.orderDate')}: ${DateFormat.MMMEd().format(date)}, ${date.year}",
                        )
                    ),

                    SizedBox(height: FlexoValues.heightSpace1Px,),
                    Container(
                        child: FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey("order.orderStatus")}: ${orderDetailsProvider.getOrderDetailsModel.orderStatus}",
                        )
                    ),

                    SizedBox(height: FlexoValues.heightSpace1Px,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: FlexoTextWidget().contentText16(
                              text:"${localResourceProvider.getResourseByKey('order.orderTotal')}:",
                            )
                        ),

                        Container(
                          child:FlexoTextWidget().headingBoldText16(
                            text: " ${orderDetailsProvider.getOrderDetailsModel.orderTotal}",
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),
            ],
          ),
        );
      },
    );
  }
}