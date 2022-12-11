/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderShipmate/OrderShipmateDetail.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class  OrderShipmentComponent{

  getOrderShipmentComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          child: Column(
            children: orderDetailsProvider.getOrderDetailsModel.shipments.map((e){
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:FlexoColorConstants.LIST_BORDER_COLOR
                        )
                    )
                ),
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace2Px),
                child: Row(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                                child: Text(
                                  localResourceProvider.getResourseByKey("order.shipments"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FlexoValues.fontSize16
                                  ),
                                )
                            ),

                            SizedBox(height:  FlexoValues.heightSpace1Px,),

                            Container(
                              child: FlexoTextWidget().contentText16(
                                  text:"${localResourceProvider.getResourseByKey("order.shipments.id")} ${e.id}",
                                  maxLines: 2
                              ),
                            ),

                            Container(
                              child: FlexoTextWidget().contentText16(
                                  text:"${localResourceProvider.getResourseByKey("order.shipments.trackingNumber")}: ${e.trackingNumber!=null?e.trackingNumber:''}",
                                  maxLines: 2
                              ),
                            ),


                            Container(
                              child: FlexoTextWidget().contentText16(
                                  text: "${localResourceProvider.getResourseByKey("order.shipments.shippedDate")}: ${e.shippedDate!=null ?'${DateFormat.MMMMEEEEd().format(DateTime.parse(e.shippedDate))},${DateTime.parse(e.shippedDate).year}' :localResourceProvider.getResourseByKey("order.shipments.shippedDate.notYet")}",
                                  maxLines: 2
                              ),
                            ),


                            Container(
                              child: FlexoTextWidget().contentText16(
                                  text: "${localResourceProvider.getResourseByKey("order.shipments.deliveryDate")}: ${e.deliveryDate!=null ? "${DateFormat.MMMMEEEEd().format(DateTime.parse(e.deliveryDate))},${DateTime.parse(e.deliveryDate).year}" :localResourceProvider.getResourseByKey("order.shipments.deliveryDate.notYet")}",
                                  maxLines: 2
                              ),
                            ),


                            SizedBox(height:FlexoValues.widthSpace2Px,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: selectedTransition, child: OrderShipmateDetail(e.id)));
                              },
                              child: Container(
                                  child: Text(
                                    "${localResourceProvider.getResourseByKey("order.shipments.viewDetails")}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize:FlexoValues.fontSize16,
                                      color: FlexoColorConstants.HIGHLIGHT_COLOR,
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}