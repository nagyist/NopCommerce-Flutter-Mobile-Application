/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderShipmate/OrderShipmateDetailProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';

class OrderShipmateDetailsComponent{

  getOrderShipmateDetails({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderShipmateDetailProvider = context.watch<OrderShipmateDetailProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                width: FlexoValues.deviceWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: FlexoValues.heightSpace1Px,),

                    Container(
                        width: FlexoValues.controlsWidth,
                        child: FlexoTextWidget().headingBoldText16(
                          text: "${localResourceProvider.getResourseByKey("order.order#")}${orderShipmateDetailProvider.getShipmentDetailsModel.order.customOrderNumber}",
                          maxLines: 2
                        )
                    ),

                    SizedBox(height:FlexoValues.heightSpace1Px,),

                    Container(
                        width:FlexoValues.controlsWidth,
                        child: FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.shipments.shippingMethod")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingMethod}",
                          maxLines: 2
                        )
                    ),

                    Container(
                        width:FlexoValues.controlsWidth,
                        child: FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.shipments.shippedDate")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.shippedDate != null ? '${DateFormat.MMMMEEEEd().format(DateTime.parse(orderShipmateDetailProvider.getShipmentDetailsModel.shippedDate))},${DateTime.parse(orderShipmateDetailProvider.getShipmentDetailsModel.shippedDate).year}' : localResourceProvider.getResourseByKey("order.shipments.shippedDate.notYet")}",
                          maxLines: 2,
                        )
                    ),

                    Container(
                        width: FlexoValues.controlsWidth,
                        child: FlexoTextWidget().contentText16(
                            text: "${localResourceProvider.getResourseByKey("order.shipments.deliveryDate")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.deliveryDate != null ? '${DateFormat.MMMMEEEEd().format(DateTime.parse(orderShipmateDetailProvider.getShipmentDetailsModel.deliveryDate))},${DateTime.parse(orderShipmateDetailProvider.getShipmentDetailsModel.deliveryDate).year}' : localResourceProvider.getResourseByKey("order.shipments.deliveryDate.notYet")}",
                            maxLines: 2
                        )
                    ),


                    orderShipmateDetailProvider.getShipmentDetailsModel.trackingNumber!=null ?
                    Container(
                        width: FlexoValues.controlsWidth,
                        child: FlexoTextWidget().contentText16(
                          text: "${localResourceProvider.getResourseByKey("order.shipments.trackingNumber")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.trackingNumber}",
                          maxLines: 2
                        )
                    ):Container(),

                    SizedBox(height: FlexoValues.widthSpace2Px,),
                  ],
                ),
              ),

              Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),

              Container(
                width:FlexoValues.deviceWidth,
                padding:EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    !orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupInStore?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: FlexoValues.controlsWidth,
                          child: Text(
                            "${localResourceProvider.getResourseByKey("order.shipments.shippingAddress")}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:FlexoValues.fontSize16,
                                color:FlexoColorConstants.LIGHT_TEXT_COLOR
                            ),
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Container(
                          child: FlexoTextWidget().contentText16(text: '${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.firstName} ${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.lastName}',
                            maxLines: 3
                          )
                        ),

                        Container(
                          child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.email")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.email}",
                          maxLines: 3
                          )
                        ),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.phoneEnabled? orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.phoneNumber == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.phoneNumber == "" ? Container() :
                        Container(
                           child: FlexoTextWidget().contentText16(
                           text: "${localResourceProvider.getResourseByKey("order.phone")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.phoneNumber}",
                           maxLines: 3
                           )
                        ):Container(),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.faxEnabled? orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.faxNumber == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.faxNumber == "" ? Container() :
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: "${localResourceProvider.getResourseByKey("order.fax")}: ${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.faxNumber}",
                                maxLines: 3
                            )
                        ) :Container(),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.companyEnabled?orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.company == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.company == "" ? Container() :
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.company,
                                maxLines: 3
                            )
                        ):Container(),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.streetAddressEnabled? orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address1 == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address1 == "" ? Container() :
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address1,
                                maxLines: 3
                            )
                        ) :Container(),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.streetAddress2Enabled ? orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address2 == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address2 == "" ? Container() :
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.address2,
                                maxLines: 3
                            )
                        ) :Container(),

                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: '${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.city!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.city!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.city+','}":''}'
                                    '${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.stateProvinceName!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.stateProvinceName!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.stateProvinceName+','}":''}'
                                    '${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.zipPostalCode!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.zipPostalCode!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.zipPostalCode}":''}',
                                maxLines: 3
                            )
                        ),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.countryEnabled?
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text:  orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.countryName!=null?orderShipmateDetailProvider.getShipmentDetailsModel.order.shippingAddress.countryName:'',
                                maxLines: 3
                            )
                        ) :Container(),
                      ],
                    ): Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: FlexoValues.controlsWidth,
                          child: Text(
                            "${localResourceProvider.getResourseByKey("order.shipments.pickupAddress")}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:FlexoValues.fontSize16,
                                color:FlexoColorConstants.LIGHT_TEXT_COLOR
                            ),
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.streetAddressEnabled? orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.address1 == null || orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.address1 == "" ? Container() :
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.address1,
                                maxLines: 3
                            )
                        ) :Container(),

                        Container(
                            child: FlexoTextWidget().contentText16(
                                text: '${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.city!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.city!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.city+','}":''}'
                                    '${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.county!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.county!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.county+','}":''}'
                                    '${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.stateProvinceName!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.stateProvinceName!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.stateProvinceName+','}":''}'
                                    '${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.zipPostalCode!=null && orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.zipPostalCode!='' ?"${orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.zipPostalCode}":''}',
                                maxLines: 3
                            )
                        ),

                        orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.countryEnabled?
                        Container(
                            child: FlexoTextWidget().contentText16(
                                text:  orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.countryName!=null?orderShipmateDetailProvider.getShipmentDetailsModel.order.pickupAddress.countryName:'',
                                maxLines: 3
                            )
                        ) :Container(),

                      ],
                    ),
                  ],
                ),
              ),

              Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),

              SizedBox(height:FlexoValues.widthSpace2Px,),

              orderShipmateDetailProvider.getShipmentDetailsModel.items.length>0?
              Column(
                children: [
                  Container(
                    width:FlexoValues.deviceWidth,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all( FlexoValues.widthSpace2Px),
                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: FlexoColorConstants.LIST_BORDER_COLOR
                        )
                    ),
                    child: Text(
                      localResourceProvider.getResourseByKey("order.shipments.product(s)").toString().toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:FlexoValues.fontSize16
                      ),
                    ),
                  ),
                  Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                child: Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.deviceWidth*1.4,
                                      child: Table(
                                        border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                        columnWidths: {
                                          0:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                          1:FlexColumnWidth(FlexoValues.deviceWidth*0.7),
                                          2:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                        },
                                        textBaseline: TextBaseline.alphabetic,
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color:FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                                            ),
                                            children: [
                                              orderShipmateDetailProvider.getShipmentDetailsModel.showSku ?
                                              Container(
                                                width:FlexoValues.deviceWidth*0.4,
                                                height:FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.product(s).sku"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ) : Container(),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.7,
                                                height:FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.product(s).name"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.3,
                                                height: FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.shipments.product(s).quantity"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16  ,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth*1.4,
                                      child: Table(
                                        border: TableBorder.all(color:FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                        columnWidths: {
                                          0:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                          1:FlexColumnWidth(FlexoValues.deviceWidth*0.7),
                                          2:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                        },
                                        textBaseline: TextBaseline.alphabetic,
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: orderShipmateDetailProvider.getShipmentDetailsModel.items.map((e){
                                          return  TableRow(

                                            children: [
                                              orderShipmateDetailProvider.getShipmentDetailsModel.showSku ?
                                              Container(
                                                  width: FlexoValues.deviceWidth*0.4,
                                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                  alignment: Alignment.centerLeft,
                                                  child:FlexoTextWidget().contentText16(text:  e.sku!=null? e.sku : '',
                                                      maxLines: 2
                                                  )
                                              ) : Container(),

                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color:FlexoColorConstants.LIST_BORDER_COLOR
                                                    ),
                                                    left: BorderSide(
                                                        color:FlexoColorConstants.LIST_BORDER_COLOR
                                                    ),
                                                  ),
                                                ),
                                                width: FlexoValues.deviceWidth*0.7,
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: ()
                                                      {
                                                        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                                        {
                                                          orderShipmateDetailProvider.getHeaderData(context: context);
                                                        });
                                                      },
                                                      child: Container(
                                                        width: FlexoValues.deviceWidth*0.7,
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                            "${e.productName}",
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            textAlign: TextAlign.start,
                                                            style: TextStyleWidget.redirectTextStyle16
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                                    e.rentalInfo!=null?
                                                    Column(
                                                      children: [

                                                        SizedBox(height:FlexoValues.heightSpace1Px,),

                                                        Container(
                                                          width: FlexoValues.deviceWidth*0.7,
                                                          child: RichText(
                                                            text: HTML.toTextSpan(
                                                              context,
                                                              e.rentalInfo,
                                                              defaultTextStyle: TextStyle(
                                                                color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                fontSize: FlexoValues.fontSize16,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ) :Container(),

                                                    e.attributeInfo.isNotEmpty ?
                                                    Container(
                                                      child: Column(
                                                        children: [

                                                          SizedBox(height: FlexoValues.heightSpace1Px,),

                                                          Container(
                                                            width:FlexoValues.deviceWidth*0.7,
                                                            child: RichText(
                                                              text: HTML.toTextSpan(
                                                                context,
                                                                e.attributeInfo,
                                                                defaultTextStyle: TextStyle(
                                                                  color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                  fontSize:FlexoValues.fontSize16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ):Container(),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.6,
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    Container(
                                                      width:FlexoValues.deviceWidth*0.3,
                                                      child: Container(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          "${e.quantityShipped}",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                              fontSize: FlexoValues.fontSize16,
                                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height:FlexoValues.widthSpace2Px,),
                ],
              ):Container(),

              orderShipmateDetailProvider.getShipmentDetailsModel.shipmentStatusEvents.length>0?
              Column(
                children: [
                  Container(
                    width:FlexoValues.deviceWidth,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all( FlexoValues.widthSpace2Px),
                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: FlexoColorConstants.LIST_BORDER_COLOR
                        )
                    ),
                    child: Text(
                      localResourceProvider.getResourseByKey("order.shipmentStatusEvents").toString().toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:FlexoValues.fontSize16
                      ),
                    ),
                  ),
                  Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                child: Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.deviceWidth*1.7,
                                      child: Table(
                                        border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                        columnWidths: {
                                          0:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                          1:FlexColumnWidth(FlexoValues.deviceWidth*0.7),
                                          2:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                          3:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                        },
                                        textBaseline: TextBaseline.alphabetic,
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color:FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                                            ),
                                            children: [

                                              Container(
                                                width:FlexoValues.deviceWidth*0.4,
                                                height:FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.shipmentStatusEvents.event"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.7,
                                                height:FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.shipmentStatusEvents.location"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.3,
                                                height: FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.shipmentStatusEvents.country"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16  ,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth*0.3,
                                                height: FlexoValues.deviceHeight*0.06,
                                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("order.shipmentStatusEvents.date"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16  ,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth*1.7,
                                      child: Table(
                                        border: TableBorder.all(color:FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                        columnWidths: {
                                          0:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                          1:FlexColumnWidth(FlexoValues.deviceWidth*0.7),
                                          2:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                          3:FlexColumnWidth(FlexoValues.deviceWidth*0.3),
                                        },
                                        textBaseline: TextBaseline.alphabetic,
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                        children: orderShipmateDetailProvider.getShipmentDetailsModel.shipmentStatusEvents.map((e){
                                          return  TableRow(
                                            children: [
                                              Container(
                                                  width: FlexoValues.deviceWidth*0.4,
                                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                  alignment: Alignment.centerLeft,
                                                  child:FlexoTextWidget().contentText16(text: e.eventName,
                                                      maxLines: 2
                                                  )
                                              ),

                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                width: FlexoValues.deviceWidth*0.7,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "${e.location}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: FlexoValues.fontSize16,
                                                        color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                ),
                                              ),

                                              Container(
                                                width:FlexoValues.deviceWidth*0.3,
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                child: Text(
                                                  "${e.country}",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                alignment: Alignment.centerLeft,
                                                width:FlexoValues.deviceWidth*0.3,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "${e.date}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: FlexoValues.fontSize16,
                                                        color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height:FlexoValues.widthSpace2Px,),
                ],
              ):Container(),
            ],
          ),
        );
      },
    );
  }
}