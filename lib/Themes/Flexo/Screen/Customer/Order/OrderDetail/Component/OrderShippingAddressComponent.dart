/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/Model/GetOrderDetailsModel.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class OrderShippingAddressComponent{

  getOrderShippingAddress({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:FlexoColorConstants.LIST_BORDER_COLOR
                )
            ),
          ),
          width: FlexoValues.deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: FlexoValues.widthSpace2Px),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlexoTextWidget().headingBoldText16(
                    text: "${localResourceProvider.getResourseByKey('order.shipments.shippingAddress')}",
                  ),

                  SizedBox(height:FlexoValues.widthSpace2Px,),

                  Container(
                    child: FlexoTextWidget().contentText16(
                      text: '${orderDetailsProvider.getOrderDetailsModel.shippingAddress.firstName} ${orderDetailsProvider.getOrderDetailsModel.shippingAddress.lastName}',
                      maxLines: 3
                    ),
                  ),

                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: "${localResourceProvider.getResourseByKey("order.email")}: ${orderDetailsProvider.getOrderDetailsModel.shippingAddress.email}",
                        maxLines: 3
                    ),
                  ),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.phoneEnabled? orderDetailsProvider.getOrderDetailsModel.shippingAddress.phoneNumber == null || orderDetailsProvider.getOrderDetailsModel.shippingAddress.phoneNumber == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: "${localResourceProvider.getResourseByKey("order.phone")}: ${orderDetailsProvider.getOrderDetailsModel.shippingAddress.phoneNumber}",
                        maxLines: 3
                    ),
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.faxEnabled? orderDetailsProvider.getOrderDetailsModel.shippingAddress.faxNumber == null || orderDetailsProvider.getOrderDetailsModel.shippingAddress.faxNumber == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: "${localResourceProvider.getResourseByKey("order.fax")}: ${orderDetailsProvider.getOrderDetailsModel.shippingAddress.faxNumber}",
                        maxLines: 3
                    ),
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.companyEnabled?orderDetailsProvider.getOrderDetailsModel.shippingAddress.company == null || orderDetailsProvider.getOrderDetailsModel.shippingAddress.company == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: orderDetailsProvider.getOrderDetailsModel.shippingAddress.company,
                        maxLines: 3
                    ),
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.streetAddressEnabled? orderDetailsProvider.getOrderDetailsModel.shippingAddress.address1 == null || orderDetailsProvider.getOrderDetailsModel.shippingAddress.address1 == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: orderDetailsProvider.getOrderDetailsModel.shippingAddress.address1,
                        maxLines: 3
                    ),
                  ) :Container(),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.streetAddress2Enabled ? orderDetailsProvider.getOrderDetailsModel.shippingAddress.address2 == null || orderDetailsProvider.getOrderDetailsModel.shippingAddress.address2 == "" ? Container() :
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: orderDetailsProvider.getOrderDetailsModel.shippingAddress.address2,
                        maxLines: 3
                    ),
                  ) :Container(),

                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: '${orderDetailsProvider.getOrderDetailsModel.shippingAddress.city!=null && orderDetailsProvider.getOrderDetailsModel.shippingAddress.city!='' ?"${orderDetailsProvider.getOrderDetailsModel.shippingAddress.city+','}":''}'
                            '${orderDetailsProvider.getOrderDetailsModel.shippingAddress.stateProvinceName!=null && orderDetailsProvider.getOrderDetailsModel.shippingAddress.stateProvinceName!='' ?"${orderDetailsProvider.getOrderDetailsModel.shippingAddress.stateProvinceName+','}":''}'
                            '${orderDetailsProvider.getOrderDetailsModel.shippingAddress.zipPostalCode!=null && orderDetailsProvider.getOrderDetailsModel.shippingAddress.zipPostalCode!='' ?"${orderDetailsProvider.getOrderDetailsModel.shippingAddress.zipPostalCode}":''}',
                        maxLines: 3
                    ),
                  ),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.countryEnabled?
                  Container(
                    child: FlexoTextWidget().contentText16(
                        text: orderDetailsProvider.getOrderDetailsModel.shippingAddress.countryName!=null?orderDetailsProvider.getOrderDetailsModel.shippingAddress.countryName:'',
                        maxLines: 3
                    ),
                  ) :Container(height: 0,),

                  orderDetailsProvider.getOrderDetailsModel.shippingAddress.formattedCustomAddressAttributes.isNotEmpty || orderDetailsProvider.getOrderDetailsModel.shippingAddress.formattedCustomAddressAttributes!=null?
                  Column(
                    children: [
                      Container(
                        width: FlexoValues.controlsWidth,
                        child: RichText(
                          text: HTML.toTextSpan(
                            context,
                            '${orderDetailsProvider.getOrderDetailsModel.shippingAddress.formattedCustomAddressAttributes}',
                            defaultTextStyle: TextStyle(
                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                              fontSize:FlexoValues.fontSize16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container(height: 0,),

                  // orderDetailsProvider.getOrderDetailsModel.shippingAddress.customAddressAttributes.isNotEmpty?
                  // Column(
                  //   children: [
                  //     Container(
                  //       child: Column(
                  //             children:orderDetailsProvider.getOrderDetailsModel.shippingAddress.customAddressAttributes.map((e){
                  //             bool haveVal=true;
                  //             List<Value> values=[];
                  //             if(e.attributeControlType==AttributeControlType.Checkboxes ||  e.attributeControlType==AttributeControlType.DropdownList || e.attributeControlType==AttributeControlType.RadioList ||e.attributeControlType==AttributeControlType.ReadonlyCheckboxes){
                  //               setState((){
                  //                  values= e.values.where((element) => element.isPreSelected).toList();
                  //               });
                  //               if(values.length>0){
                  //                 setState((){
                  //                   haveVal=true;
                  //                 });
                  //               }else{
                  //                 setState((){
                  //                   haveVal=false;
                  //                 });
                  //               }
                  //             }else if(e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox){
                  //               if(e.defaultValue!=null){
                  //                 setState((){
                  //                   haveVal=true;
                  //                 });
                  //               }else{
                  //                 setState((){
                  //                   haveVal=false;
                  //                 });
                  //               }
                  //             }
                  //             return Container(
                  //               width:FlexoValues.controlsWidth,
                  //               child:haveVal?
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Container(
                  //                     width:FlexoValues.controlsWidth,
                  //                     margin:EdgeInsets.only(top:FlexoValues.widthSpace1Px),
                  //                     child: Text(
                  //                       haveVal?"${e.name}:":'',
                  //                       maxLines: 2,
                  //                       overflow: TextOverflow.ellipsis,
                  //                       style: TextStyle(
                  //                           fontSize: FlexoValues.fontSize16,
                  //                           color: FlexoColorConstants.DARK_TEXT_COLOR,
                  //                           fontWeight: FontWeight.bold
                  //                       ),
                  //                     ),
                  //                   ),
                  //
                  //                   e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                  //                   Container(
                  //                     width:FlexoValues.controlsWidth,
                  //                     child: Text(
                  //                       e.defaultValue,
                  //                       maxLines: 2,
                  //                       overflow: TextOverflow.ellipsis,
                  //                       style: TextStyle(
                  //                           fontSize: FlexoValues.fontSize16,
                  //                           color:FlexoColorConstants.DARK_TEXT_COLOR
                  //                       ),
                  //                     ),
                  //                   ) :
                  //                   Container(
                  //                     width:FlexoValues.controlsWidth,
                  //                     child: Wrap(
                  //                       children: e.values.map((p){
                  //                         return p.isPreSelected?
                  //                         Container(
                  //                           width:FlexoValues.controlsWidth,
                  //                           child: Text(
                  //                             p.isPreSelected?p.name:'',
                  //                             maxLines: 2,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                                 fontSize: FlexoValues.fontSize16,
                  //                                 color: FlexoColorConstants.DARK_TEXT_COLOR
                  //                             ),
                  //                           ),
                  //                         ):Container();
                  //                       }).toList(),
                  //                     ),
                  //                   ),
                  //
                  //                 ],
                  //               ):Container(),
                  //             );
                  //           }).toList(),
                  //
                  //       ),
                  //     ),
                  //     SizedBox(height:FlexoValues.widthSpace2Px,),
                  //   ],
                  // ):Container(),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}