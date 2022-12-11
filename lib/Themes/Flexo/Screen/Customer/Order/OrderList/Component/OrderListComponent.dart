/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetails.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderList/OrderListProvider.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestDetail.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Widgets/ResponsiveSize/responsive_sizer.dart';

class OrderListComponent{

  getOrderListComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderListProvider = context.watch<OrderListProvider>();
    var canRetryRecurringOrders =  orderListProvider.customerOrderModel.recurringOrders.any((e) => e.canRetryLastPayment);

    print("canRetryRecurringOrders $canRetryRecurringOrders");

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return   Container(
          width: FlexoValues.deviceWidth,
          child: Column(
            children: [
              orderListProvider.customerOrderModel.recurringOrders.isNotEmpty?
              Container(
                width: FlexoValues.deviceWidth,
                child: Column(
                  children: [
                    Container(
                      width: FlexoValues.deviceWidth,
                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                      alignment: Alignment.centerLeft,
                      child: FlexoTextWidget().headingText18(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders"), maxLines: 2),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Column(
                            children: [

                              Container(
                                width: 410.w,
                                child: Table(
                                  border: TableBorder(
                                    top: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                    ),
                                    right: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                    ),
                                    left: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                    ),
                                    verticalInside:BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                    ),
                                    horizontalInside:BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                    ),
                                  ),
                                  columnWidths: {
                                    0:FlexColumnWidth(45.w),
                                    1:FlexColumnWidth(45.w),
                                    2:FlexColumnWidth(45.w),
                                    3:FlexColumnWidth(45.w),
                                    4:FlexColumnWidth(45.w),
                                    5:FlexColumnWidth(60.w),
                                    6:FlexColumnWidth(60.w),
                                    7:FlexColumnWidth(60.w),
                                  },
                                  textBaseline: TextBaseline.alphabetic,
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        Container(
                                          width:FlexoValues.deviceWidth*0.45,
                                          height: FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.startDate"), maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.cycleInfo"), maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.nextPayment"), maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.totalCycles"), maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.cyclesRemaining"), maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.initialOrder"), maxLines: 2),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.retryLastPayment"), maxLines: 2),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.1,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.cancel"), maxLines: 2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width:410.w,
                                child: Table(
                                  border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR),
                                  columnWidths: {
                                    0:FlexColumnWidth(45.w),
                                    1:FlexColumnWidth(45.w),
                                    2:FlexColumnWidth(45.w),
                                    3:FlexColumnWidth(45.w),
                                    4:FlexColumnWidth(45.w),
                                    5:FlexColumnWidth(60.w),
                                    6:FlexColumnWidth(60.w),
                                    7:FlexColumnWidth(60.w),
                                  },
                                  textBaseline: TextBaseline.alphabetic,
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: orderListProvider.customerOrderModel.recurringOrders.map((e){
                                    String initialNumber=localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.viewInitialOrder");
                                    initialNumber=initialNumber.replaceAll('{0}', e.initialOrderNumber);
                                    return TableRow(
                                      children: [
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: e.startDate, maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: e.cycleInfo, maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: e.nextPayment, maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: "${e.totalCycles}", maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.45,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: "${e.cyclesRemaining}", maxLines: 2),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.15,
                                          padding: EdgeInsets.all(FlexoValues.deviceWidth*0.015),
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap:(){
                                              Navigator.push(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: e.initialOrderId)));
                                            },
                                            child:FlexoTextWidget().redirectText16(text: initialNumber, maxLines: 2),
                                          ),
                                        ),

                                        e.canRetryLastPayment?
                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.15,
                                          padding: EdgeInsets.symmetric(horizontal:  FlexoValues.deviceWidth*0.14),
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap:() async{
                                              if(await CheckConnectivity().checkInternet(context))
                                              {
                                                orderListProvider.retryLastRecurringPayment(context: context, recurringPaymentId: e.id, commentTitle: "", commentText: "");
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Ionicons.arrow_down_circle_outline,
                                                  color: Colors.green,
                                                  size: FlexoValues.iconSize20,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.retryLastPayment"), maxLines: 2),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ):Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.15,
                                          alignment: Alignment.center,
                                          child:FlexoTextWidget().headingText16(text: "N/A", maxLines: 2),
                                        ),

                                        e.canCancel?
                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.15,
                                          padding: EdgeInsets.symmetric(horizontal:  FlexoValues.deviceWidth*0.14),
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap:() async{
                                              if(await CheckConnectivity().checkInternet(context))
                                              {
                                                orderListProvider.cancelOnClickEvent(context: context, recurringPaymentId: e.id);
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: FlexoValues.iconSize20,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("account.customerOrders.recurringOrders.cancel"), maxLines: 2),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ):Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          height:FlexoValues.deviceWidth*0.15,),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace3Px,),

                    orderListProvider.customerOrderModel.recurringPaymentErrors.any((element) => true) ?Container(
                      child: Column(
                        children: [
                          Column(
                            children:orderListProvider.customerOrderModel.recurringPaymentErrors.map((error){
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlexoTextWidget().headingText16(
                                      text:error,
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
                  ],
                ),
              ):Container(),

              Column(
                children: orderListProvider.customerOrderModel.orders.map((e){
                  return Container(
                    width:FlexoValues.deviceWidth,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: FlexoColorConstants.LIST_BORDER_COLOR
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                  )
                              ),
                              color: FlexoColorConstants.HEADING_BACKGROUND_COLOR
                          ),
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px,vertical: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:FlexoTextWidget().headingBoldText16(
                                    text:'${localResourceProvider.getResourseByKey("account.customerOrders.orderNumber")}: ${e.customOrderNumber}',
                                    maxLines: 1
                                ),
                              ),

                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: e.id)));
                                },
                                child: Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_circle_outline,
                                      color: FlexoColorConstants.THEME_COLOR,
                                      size:FlexoValues.iconSize20,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  e.isReturnRequestAllowed ?Container(
                                    padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ReturnRequestDetail(e.id, e.customOrderNumber)));
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.arrow_forward_sharp,
                                                  color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                  size:FlexoValues.iconSize20,
                                                ),
                                              ),
                                              Container(
                                                  child: FlexoTextWidget().headingBoldText16(
                                                      text: localResourceProvider.getResourseByKey("account.customerOrders.returnItems")
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      :
                                  Container(),
                                ],
                              ),

                              SizedBox(height: FlexoValues.widthSpace2Px,),

                              FlexoTextWidget().headingText16(
                                  text: '${localResourceProvider.getResourseByKey("account.customerOrders.orderStatus")}: ${e.orderStatus}',
                                  maxLines: 2),

                              SizedBox(height: FlexoValues.heightSpace1Px,),

                              FlexoTextWidget().headingText16(
                                  text: '${localResourceProvider.getResourseByKey("order.orderDate")}: ${DateFormat("M/d/yyyy hh:mm:ss aa").format(e.createdOn)} ',
                                  maxLines: 2),

                              SizedBox(height: FlexoValues.heightSpace1Px,),

                              FlexoTextWidget().headingText16(
                                  text:'${localResourceProvider.getResourseByKey("order.orderTotal")}: '+e.orderTotal,
                                  maxLines: 2),

                              SizedBox(height: FlexoValues.heightSpace1Px,),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}