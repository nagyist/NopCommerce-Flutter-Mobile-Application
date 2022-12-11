/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';
import 'Component/OrderBillingAddressComponent.dart';
import 'Component/OrderDetailComponent.dart';
import 'Component/OrderNotesComponent.dart';
import 'Component/OrderPickupAddressComponent.dart';
import 'Component/OrderProductListComponent.dart';
import 'Component/OrderShipmentComponent.dart';
import 'Component/OrderShippingAddressComponent.dart';
import 'Component/OrderTotalPriceComponent.dart';

class FlexoOrderDetails extends StatelessWidget {
  const FlexoOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
            bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: orderDetailsProvider.headerModel,headerLoader:orderDetailsProvider.isAPILoader),
            appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ?"Order Information" : localResourceProvider. getResourseByKey('order.orderInformation')  ),
            body: orderDetailsProvider.isPageLoader ? Loaders.pageLoader() :  Column(
              children: [
                orderDetailsProvider.isAPILoader ? Loaders.apiLoader() : Container(),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          OrderDetailComponent().getOrderDetail(context:context),

                          OrderBillingAddressComponent().getOrderBillingAddress(context:context),

                          orderDetailsProvider.getOrderDetailsModel.paymentMethod==null ||  orderDetailsProvider.getOrderDetailsModel.paymentMethod==''?Container():
                          Container(
                            width: FlexoValues.deviceWidth,
                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:FlexoColorConstants.LIST_BORDER_COLOR
                                  )
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                    child: FlexoTextWidget().headingBoldText16(
                                        text: localResourceProvider.getResourseByKey("order.payment"),
                                        maxLines: 3
                                    )
                                ),

                                SizedBox(height:FlexoValues.heightSpace1Px,),

                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.payment.method")}: ${orderDetailsProvider.getOrderDetailsModel.paymentMethod}",),
                                ),

                                SizedBox(height:FlexoValues.widthSpace1Px,),

                                !orderDetailsProvider.getOrderDetailsModel.printMode?
                                Column(
                                  children: [

                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.payment.status")}: ${orderDetailsProvider.getOrderDetailsModel.paymentMethodStatus}",),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace2Px,),
                                  ],
                                ):Container(),

                                !orderDetailsProvider.getOrderDetailsModel.printMode && orderDetailsProvider.getOrderDetailsModel.canRePostProcessPayment?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async{
                                        if(await CheckConnectivity().checkInternet(context))
                                        {
                                          orderDetailsProvider.reOrderOnClickEvent(context: context, orderId: orderDetailsProvider.getOrderDetailsModel.id);
                                        }
                                      },
                                      child: Container(
                                        width: FlexoValues.deviceWidth*0.5,
                                        height: FlexoValues.deviceWidth*0.1,
                                        color:FlexoColorConstants.BUTTON_COLOR,
                                        alignment: Alignment.center,
                                        child: Text(
                                          localResourceProvider.getResourseByKey("order.retryPayment").toString().toUpperCase(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize:FlexoValues.fontSize17,
                                              color: FlexoColorConstants.BUTTON_TEXT_COLOR
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.deviceWidth*0.015,),

                                    Container(
                                        child: FlexoTextWidget().headingText16(
                                            text: localResourceProvider.getResourseByKey("order.retryPayment.hint"),
                                            maxLines: 3
                                        )
                                    ),
                                  ],
                                ):Container(),
                              ],
                            ),
                          ),

                          orderDetailsProvider.getOrderDetailsModel.isShippable?
                          Column(
                            children: [
                              !orderDetailsProvider.getOrderDetailsModel.pickupInStore?
                              OrderShippingAddressComponent().getOrderShippingAddress(context:context):
                              OrderPickupAddressComponent().getOrderPickupAddress(context:context),

                              SizedBox(height: FlexoValues.heightSpace1Px),

                              Container(
                                width: FlexoValues.deviceWidth,
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:FlexoColorConstants.LIST_BORDER_COLOR
                                      )
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      child: FlexoTextWidget().headingBoldText16(
                                          text:  localResourceProvider.getResourseByKey("order.shipping"),
                                          maxLines: 3
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.shipments.shippingMethod")}: ${orderDetailsProvider.getOrderDetailsModel.shippingMethod}",),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace1Px,),

                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.shipping.status")}: ${orderDetailsProvider.getOrderDetailsModel.shippingStatus}",),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace2Px,),
                                  ],
                                ),
                              ),
                            ],
                          ):
                          Container(),

                          !orderDetailsProvider.getOrderDetailsModel.printMode && orderDetailsProvider.getOrderDetailsModel.shipments.length > 0 ?
                          OrderShipmentComponent().getOrderShipmentComponent(context:context):Container(),

                          orderDetailsProvider.getOrderDetailsModel.items.length>0?
                          Column(
                            children: [
                              !orderDetailsProvider.getOrderDetailsModel.printMode && orderDetailsProvider.getOrderDetailsModel.orderNotes.length>0?
                              OrderNotesComponent().getOrderNotesComponent(context:context):
                              Container(),

                              OrderProductListComponent().getOrderProductList(context:context),

                              OrderTotalPriceComponent().getOrderTotalPrice(context:context),
                            ],
                          ):Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}







