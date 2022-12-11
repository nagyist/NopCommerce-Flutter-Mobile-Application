/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/UserAgreement/UserAgreement.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/DataProvider/APIConstants.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderProductListComponent{

  getOrderProductList({required BuildContext context})
  {

    final _scrollController = ScrollController();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          child: Column(
            children: [
              SizedBox(height: FlexoValues.widthSpace2Px,),

              Container(
                width:FlexoValues.deviceWidth,
                alignment: Alignment.center,
                margin: EdgeInsets.all( FlexoValues.widthSpace2Px),
                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                decoration: BoxDecoration(
                    border: Border.all(
                        color:FlexoColorConstants.LIST_BORDER_COLOR
                    )
                ),
                child: Text(
                  localResourceProvider.getResourseByKey("order.product(s)").toString().toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:FlexoValues.fontSize16
                  ),
                ),
              ),

              Container(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    showTrackOnHover: true,
                    controller: _scrollController,
                    thickness: 4,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Container(
                        padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                        child: Column(
                          children: [

                            Container(
                              width: orderDetailsProvider.getOrderDetailsModel.showSku ?FlexoValues.deviceWidth*2.7:FlexoValues.deviceWidth*2.3,
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(orderDetailsProvider.getOrderDetailsModel.showSku ?FlexoValues.deviceWidth*0.4:0),
                                  1:FlexColumnWidth(FlexoValues.deviceWidth*0.8),
                                  2:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  3:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  4:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  5:FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                },
                                border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      orderDetailsProvider.getOrderDetailsModel.showSku ?
                                      Container(
                                        width:FlexoValues.deviceWidth*0.4,
                                        height:FlexoValues.deviceHeight*0.06,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child:FlexoTextWidget().headingBoldText16(
                                            text: localResourceProvider.getResourseByKey("order.product(s).sku"))
                                         ) : Container( ),
                                      Container(
                                        width: FlexoValues.deviceWidth*0.8,
                                        height:FlexoValues.deviceHeight*0.06,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: FlexoTextWidget().headingBoldText16(
                                            text: localResourceProvider.getResourseByKey("order.product(s).name"),)
                                      ),
                                      Container(
                                        width:FlexoValues.deviceWidth*0.4,
                                        height:FlexoValues.deviceHeight*0.06,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color:  FlexoColorConstants.LIST_BORDER_COLOR
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: FlexoTextWidget().headingBoldText16(
                                            text:  localResourceProvider.getResourseByKey("order.product(s).price"),)
                                      ),
                                      Container(
                                        width:FlexoValues.deviceWidth*0.4,
                                        height:FlexoValues.deviceHeight*0.06,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color:  FlexoColorConstants.LIST_BORDER_COLOR
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: FlexoTextWidget().headingBoldText16(
                                            text:  localResourceProvider.getResourseByKey("order.product(s).quantity"),)
                                      ),
                                      Container(
                                        width:FlexoValues.deviceWidth*0.4,
                                        height:FlexoValues.deviceHeight*0.06,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child:FlexoTextWidget().headingBoldText16(
                                            text:  localResourceProvider.getResourseByKey("order.product(s).total"),)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: orderDetailsProvider.getOrderDetailsModel.showSku ?FlexoValues.deviceWidth*2.7:FlexoValues.deviceWidth*2.3,
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(orderDetailsProvider.getOrderDetailsModel.showSku ?FlexoValues.deviceWidth*0.4:0),
                                  1: FlexColumnWidth(FlexoValues.deviceWidth*0.8),
                                  2: FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  3: FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  4: FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                  5: FlexColumnWidth(FlexoValues.deviceWidth*0.4),
                                },
                                border: TableBorder.all(color:  FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: orderDetailsProvider.getOrderDetailsModel.items.map((e) {
                                  return TableRow(
                                      children: [
                                        orderDetailsProvider.getOrderDetailsModel.showSku ?
                                        Container(
                                          width:FlexoValues.deviceWidth*0.4,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                          alignment: Alignment.centerLeft,
                                          child:FlexoTextWidget().contentText16(
                                            text: e.sku!=null? e.sku : '',
                                            maxLines: 2
                                          )
                                        ): Container(),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.8,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Container(
                                                width:FlexoValues.deviceWidth*0.54,
                                                alignment: Alignment.topLeft,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId:e.productId , updateId: 0, isCart: false))).then((value)
                                                    {
                                                      orderDetailsProvider.getHeaderData(context: context);
                                                    });
                                                  },
                                                  child: Text(
                                                    "${e.productName}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyleWidget.redirectTextStyle16,
                                                  ),
                                                ),
                                              ),

                                              e.downloadId>0?
                                              Column(
                                                children: [

                                                  SizedBox(height: FlexoValues.heightSpace1Px,),

                                                  GestureDetector(
                                                    child: Container(
                                                      width:FlexoValues.deviceWidth*0.7,
                                                      alignment: Alignment.centerLeft,
                                                      child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("downloadableProducts.fields.download"),),
                                                    ),
                                                    onTap: (){
                                                      orderDetailsProvider.downloadableProductData(context: context, orderGuid: e.orderItemGuid, isAgree: false);
                                                      },
                                                  ),
                                                ],
                                              ) :Container(),

                                              e.licenseId>0?
                                              Column(
                                                children: [

                                                  SizedBox(height: FlexoValues.heightSpace1Px,),

                                                  GestureDetector(
                                                    child: Container(
                                                      width:FlexoValues.deviceWidth*0.7,
                                                      alignment: Alignment.centerLeft,
                                                      child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("downloadableproducts.fields.downloadlicense"),),
                                                    ),
                                                    onTap: (){
                                                      Navigator.push(context, PageTransition(type: selectedTransition, child: UserAgreement(e.orderItemGuid)));
                                                    },
                                                  ),
                                                ],
                                              ) :Container(),

                                              e.rentalInfo!=null?
                                              Column(
                                                children: [

                                                  SizedBox(height: FlexoValues.heightSpace1Px,),

                                                  Container(
                                                    width:FlexoValues.deviceWidth*0.7,
                                                    child: HtmlWidget(
                                                      '${e.rentalInfo.replaceAll("/images/uploaded", APIConstants.BASE_URL+"images/uploaded")}',
                                                      textStyle: TextStyleWidget.contentTextStyle16,
                                                      onTapUrl: (url)=> launch(url),
                                                    ),
                                                  ),
                                                ],
                                              ) :Container(),

                                              e.attributeInfo.isNotEmpty ?
                                              Container(
                                                child: Column(
                                                  children: [

                                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                                    Container(
                                                      width:FlexoValues.deviceWidth*0.7,
                                                      child: HtmlWidget(
                                                        '${e.attributeInfo.replaceAll("/images/uploaded", APIConstants.BASE_URL+"images/uploaded")}',
                                                        textStyle: TextStyleWidget.contentTextStyle16,
                                                        onTapUrl: (url)=> launch(url),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ):Container(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth*0.4,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().contentText16(
                                              text: "${e.unitPrice}",
                                              maxLines: 2
                                            )
                                          ),
                                        ),
                                        Container(
                                          width:FlexoValues.deviceWidth*0.4,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${e.quantity}",
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
                                        Container(
                                          width: FlexoValues.deviceWidth*0.4,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${e.subTotal}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize:FlexoValues.fontSize16,
                                                  color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }
}