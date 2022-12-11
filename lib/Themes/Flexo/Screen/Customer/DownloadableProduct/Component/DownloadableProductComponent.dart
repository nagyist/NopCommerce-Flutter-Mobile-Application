/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/DownloadableProductProvider.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetails.dart';
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

class DigitalDownloadComponent{

  getDigitalDownloadComponent({required BuildContext context})
  {
    var downloadableProductProvider = context.watch<DownloadableProductProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: FlexoValues.deviceWidth * 0.95,
          child: Column(
            children: [

              Container(
                child: Column(
                  children: downloadableProductProvider.getDownloadableProductModel.items.map((e) {
                    if(downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]!=true || downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]==null){
                      downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]=false;
                    }
                    DateTime date=e.createdOn;
                    return Column(
                      children: [
                        Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: FlexoValues.deviceWidth * 0.1,
                                  height: FlexoValues.deviceHeight * 0.07,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                      ),
                                      left:  BorderSide(
                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                      ),
                                      bottom:  BorderSide(
                                          color: FlexoColorConstants.LIST_BORDER_COLOR
                                      ),
                                    ),
                                  ),
                                 padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  alignment: Alignment.center,
                                  child: downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]! ?Icon(Icons.remove):Icon(Icons.add),
                                ),
                                onTap: (){
                                  setState((){
                                    downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]=!downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]!;
                                  });
                                },
                              ),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: e.orderId)));
                                },
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color: FlexoColorConstants.LIST_BORDER_COLOR
                                        ),
                                        bottom:  BorderSide(
                                            color: FlexoColorConstants.LIST_BORDER_COLOR
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width: FlexoValues.deviceWidth * 0.35,
                                    height: FlexoValues.deviceHeight * 0.07,
                                    child: Text(
                                      '${e.orderId}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleWidget.redirectTextStyle16,
                                    )
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                  {
                                    downloadableProductProvider.getHeaderData(context: context);
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            color:FlexoColorConstants.LIST_BORDER_COLOR
                                        ),
                                        bottom:  BorderSide(
                                            color:FlexoColorConstants.LIST_BORDER_COLOR
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width: FlexoValues.deviceWidth * 0.5,
                                    height: FlexoValues.deviceHeight * 0.07,
                                    child: Container(
                                      child: Text(
                                        e.productName,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyleWidget.redirectTextStyle16,
                                      ),
                                    )
                                ),
                              ),

                            ]
                        ),

                        downloadableProductProvider.expandRow[downloadableProductProvider.getDownloadableProductModel.items.indexOf(e)]!?
                        Container(
                          width: FlexoValues.deviceWidth * 0.95,
                          color: Colors.grey.shade200,
                          child: Column(
                            children: [
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(FlexoValues.deviceWidth * 0.3),
                                  1: FlexColumnWidth(FlexoValues.deviceWidth * 0.65),
                                },
                                border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace2Px),
                                        width: FlexoValues.deviceWidth * 0.3,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          localResourceProvider.getResourseByKey("downloadAbleProducts.fields.date"),
                                          style: TextStyle(
                                              fontSize: FlexoValues.fontSize16,
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      Container(
                                          width: FlexoValues.deviceWidth * 0.65,
                                          margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                          alignment: Alignment.center,
                                          child: FlexoTextWidget().contentText16(
                                              text: '${date.day}/${date.month}/${date.year}',
                                              maxLines: 1
                                          )
                                      ),
                                    ],
                                  ),

                                  TableRow(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth * 0.3,
                                        margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace2Px),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          localResourceProvider.getResourseByKey("downloadAbleProducts.fields.download"),
                                          style: TextStyle(
                                              fontSize: FlexoValues.fontSize16,
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width:FlexoValues.deviceWidth * 0.65,
                                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: ()async{
                                            if(e.downloadId>0){
                                              downloadableProductProvider.getDownloadableProductDetailsData(context: context, orderGuid: e.orderItemGuid, isAgree: false);
                                            }
                                           },
                                          child: Text(
                                            e.downloadId>0 ? localResourceProvider.getResourseByKey("downloadAbleProducts.fields.download"):localResourceProvider.getResourseByKey("downloadAbleProducts.fields.download.na"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: e.downloadId>0 ? TextStyleWidget.redirectTextStyle16 : TextStyle(
                                                fontSize: FlexoValues.fontSize16,
                                                color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              e.licenseId>0?
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(FlexoValues.deviceWidth * 0.3),
                                  1: FlexColumnWidth(FlexoValues.deviceWidth * 0.65),
                                },
                                border: TableBorder(
                                  left: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  bottom:BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  right: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  horizontalInside: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  verticalInside: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                ),
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth * 0.3,
                                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                        padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          localResourceProvider.getResourseByKey("downloadAbleProducts.fields.downloadLicense"),
                                          style: TextStyle(
                                              fontSize: FlexoValues.fontSize16,
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: FlexoValues.deviceWidth * 0.65,
                                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          child: Text(
                                            e.licenseId>0 ? localResourceProvider.getResourseByKey('downloadAbleProducts.fields.downloadLicense'):localResourceProvider.getResourseByKey("downloadableProducts.fields.download.na"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:FlexoValues.fontSize16,
                                                color: e.licenseId>0 ? FlexoColorConstants.HIGHLIGHT_COLOR : FlexoColorConstants.DARK_TEXT_COLOR,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          onTap: ()async{
                                              downloadableProductProvider.getOrderItemLicenseData(context: context, orderGuid: e.orderItemGuid);
                                            },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ):Container(),

                              e.productAttributes=='' || e.productAttributes==null? Container() :
                              Table(
                                columnWidths: {
                                  0: FlexColumnWidth(FlexoValues.deviceWidth * 0.3),
                                  1: FlexColumnWidth(FlexoValues.deviceWidth * 0.65),
                                },
                                border: TableBorder(
                                  left: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  bottom:BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  right: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  horizontalInside: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                  verticalInside: BorderSide(
                                      color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1
                                  ),
                                ),
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth * 0.3,
                                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              fontSize: FlexoValues.fontSize16,
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: FlexoValues.deviceWidth * 0.65,
                                        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal:FlexoValues.widthSpace2Px ),
                                        alignment: Alignment.center,
                                        child:  RichText(
                                          text: HTML.toTextSpan(
                                            context,
                                            e.productAttributes,
                                            defaultTextStyle: TextStyle(
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontSize: FlexoValues.fontSize16,
                                            ),
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ):Container(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ),
        );
      },
    );
  }
}