/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/Model/GetOrderDetailsModel.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class OrderBillingAddressComponent{
  getOrderBillingAddress({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          width:FlexoValues.deviceWidth,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color:FlexoColorConstants.LIST_BORDER_COLOR
                  )
              )
          ),
          padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    child: FlexoTextWidget().headingBoldText16(
                         text:"${localResourceProvider.getResourseByKey('order.billingAddress')}",
                         maxLines: 3
                    )
                  ),

                  SizedBox(height: FlexoValues.heightSpace1Px),

                  Container(
                      child: FlexoTextWidget().contentText16(
                          text:'${orderDetailsProvider.getOrderDetailsModel.billingAddress.firstName} ${orderDetailsProvider.getOrderDetailsModel.billingAddress.lastName}',
                          maxLines: 3
                      )
                  ),

                  Container(
                      child: FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey("order.email")}: ${orderDetailsProvider.getOrderDetailsModel.billingAddress.email}",
                          maxLines: 3
                      )
                  ),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.phoneEnabled? orderDetailsProvider.getOrderDetailsModel.billingAddress.phoneNumber == null ||  orderDetailsProvider.getOrderDetailsModel.billingAddress.phoneNumber == "" ? Container() :
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey("order.phone")}: ${orderDetailsProvider.getOrderDetailsModel.billingAddress.phoneNumber}",
                          maxLines: 3
                      )
                  ):Container(),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.faxEnabled? orderDetailsProvider.getOrderDetailsModel.billingAddress.faxNumber == null ||  orderDetailsProvider.getOrderDetailsModel.billingAddress.faxNumber == "" ? Container() :
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text:"${localResourceProvider.getResourseByKey("order.fax")}: ${orderDetailsProvider.getOrderDetailsModel.billingAddress.faxNumber}",
                          maxLines: 3
                      )
                  ):Container(),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.companyEnabled?orderDetailsProvider.getOrderDetailsModel.billingAddress.company == null ||  orderDetailsProvider.getOrderDetailsModel.billingAddress.company == "" ? Container() :
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.billingAddress.company,
                          maxLines: 3
                      )
                  ):Container(),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.streetAddressEnabled? orderDetailsProvider.getOrderDetailsModel.billingAddress.address1 == null ||  orderDetailsProvider.getOrderDetailsModel.billingAddress.address1 == "" ? Container() :
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.billingAddress.address1,
                          maxLines: 3
                      )
                  ):Container(),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.streetAddress2Enabled ? orderDetailsProvider.getOrderDetailsModel.billingAddress.address2 == null ||  orderDetailsProvider.getOrderDetailsModel.billingAddress.address2 == "" ? Container() :
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text: orderDetailsProvider.getOrderDetailsModel.billingAddress.address2,
                          maxLines: 3
                      )
                  ) :Container(),

                  Container(
                      child: FlexoTextWidget().contentText16(
                          text: '${ orderDetailsProvider.getOrderDetailsModel.billingAddress.city!=null &&  orderDetailsProvider.getOrderDetailsModel.billingAddress.city!='' ?"${ orderDetailsProvider.getOrderDetailsModel.billingAddress.city+','}":''}'
                              '${orderDetailsProvider.getOrderDetailsModel.billingAddress.stateProvinceName!=null &&  orderDetailsProvider.getOrderDetailsModel.billingAddress.stateProvinceName!='' ?"${ orderDetailsProvider.getOrderDetailsModel.billingAddress.stateProvinceName+','}":''}'
                              '${ orderDetailsProvider.getOrderDetailsModel.billingAddress.zipPostalCode!=null &&  orderDetailsProvider.getOrderDetailsModel.billingAddress.zipPostalCode!='' ?"${ orderDetailsProvider.getOrderDetailsModel.billingAddress.zipPostalCode}":''}',
                          maxLines: 3
                      )
                  ),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.countryEnabled?
                  Container(
                      child: FlexoTextWidget().contentText16(
                          text:  orderDetailsProvider.getOrderDetailsModel.billingAddress.countryName!=null? orderDetailsProvider.getOrderDetailsModel.billingAddress.countryName:'',
                          maxLines: 3
                      )
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.vatNumber!=null?
                  Column(
                    children: [
                      Container(
                          child: FlexoTextWidget().contentText16(
                              text: "${localResourceProvider.getResourseByKey("order.vatNumber")}: ${ orderDetailsProvider.getOrderDetailsModel.vatNumber}",
                              maxLines: 3
                          )
                      ),
                    ],
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.billingAddress.formattedCustomAddressAttributes.isNotEmpty || orderDetailsProvider.getOrderDetailsModel.billingAddress.formattedCustomAddressAttributes!=null?
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: FlexoValues.controlsWidth,
                          child: RichText(
                            text: HTML.toTextSpan(
                              context,
                              '${orderDetailsProvider.getOrderDetailsModel.billingAddress.formattedCustomAddressAttributes}',
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
            ],
          ),
        );
      },
    );
  }
}