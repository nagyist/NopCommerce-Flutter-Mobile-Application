/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/Model/GetOrderDetailsModel.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:provider/provider.dart';

class OrderPickupAddressComponent{
  getOrderPickupAddress({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          width:FlexoValues.deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
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
              SizedBox(height: FlexoValues.widthSpace2Px,),

              Container(
                  child: FlexoTextWidget().headingBoldText16(
                      text: localResourceProvider.getResourseByKey("order.pickupAddress") ,
                  )
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),

              orderDetailsProvider.getOrderDetailsModel.pickupAddress.address1!="" && orderDetailsProvider.getOrderDetailsModel.pickupAddress.address1!=null?
              Container(
                  child: FlexoTextWidget().contentText16(
                    text:"${orderDetailsProvider.getOrderDetailsModel.pickupAddress.address1}",
                  )
              ):Container(),

              Container(
                  child: FlexoTextWidget().contentText16(
                    text:'${orderDetailsProvider.getOrderDetailsModel.pickupAddress.city!=null && orderDetailsProvider.getOrderDetailsModel.pickupAddress.city!='' ?"${orderDetailsProvider.getOrderDetailsModel.pickupAddress.city+','}":''}'
                        '${orderDetailsProvider.getOrderDetailsModel.pickupAddress.stateProvinceName!=null && orderDetailsProvider.getOrderDetailsModel.pickupAddress.stateProvinceName!='' ?"${orderDetailsProvider.getOrderDetailsModel.pickupAddress.stateProvinceName+','}":''}'
                        '${orderDetailsProvider.getOrderDetailsModel.pickupAddress.zipPostalCode!=null && orderDetailsProvider.getOrderDetailsModel.pickupAddress.zipPostalCode!='' ?"${orderDetailsProvider.getOrderDetailsModel.pickupAddress.zipPostalCode}":''}',
                    maxLines: 3,
                  )
              ),

              (orderDetailsProvider.getOrderDetailsModel.pickupAddress.countryName!=""&&orderDetailsProvider.getOrderDetailsModel.pickupAddress.countryName!=null)?
              Container(
                  child: FlexoTextWidget().contentText16(
                    text:  orderDetailsProvider.getOrderDetailsModel.pickupAddress.countryName,
                  )
              ):Container(),

              SizedBox(height: FlexoValues.widthSpace2Px,),
            ],
          ),
        );
      },
    );
  }
}