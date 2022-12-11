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

class OrderNotesComponent{
  getOrderNotesComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                        child: FlexoTextWidget().headingBoldText16(

                          text: localResourceProvider.getResourseByKey("order.notes"),
                        )
                    ),

                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: FlexoValues.deviceWidth* 1.28,
                            child: Table(
                              columnWidths: {
                                0:FlexColumnWidth(FlexoValues.deviceWidth* 0.48),
                                1:FlexColumnWidth(FlexoValues.deviceWidth* 0.8)
                              },
                              border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                                  ),
                                  children: [
                                    Container(
                                        width: FlexoValues.deviceWidth* 0.48,
                                        height: FlexoValues.deviceWidth* 0.1,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: FlexoTextWidget().headingBoldText16(
                                          text:localResourceProvider.getResourseByKey("order.notes.createdOn"),
                                        )
                                    ),

                                    Container(
                                        width: FlexoValues.deviceWidth* 0.8,
                                        height: FlexoValues.deviceWidth* 0.1,
                                        padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                        child: FlexoTextWidget().headingBoldText16(
                                          text: localResourceProvider.getResourseByKey("order.notes.note"),
                                        )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: FlexoValues.deviceWidth* 1.28,
                            child: Table(
                              columnWidths: {
                                0:FlexColumnWidth(FlexoValues.deviceWidth* 0.48),
                                1:FlexColumnWidth(FlexoValues.deviceWidth* 0.8)
                              },
                              border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                              children: orderDetailsProvider.getOrderDetailsModel.orderNotes.map((e){
                                return TableRow(
                                  children: [
                                    Container(
                                        width: FlexoValues.deviceWidth* 0.48,
                                        height:FlexoValues.deviceWidth* 0.15,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: FlexoTextWidget().headingText16(
                                          text:'${DateFormat('dd/MM/yyyy hh:mm:ss a').format(e.createdOn)}',
                                          maxLines: 2
                                        )
                                    ),

                                    Container(
                                      width: FlexoValues.deviceWidth* 0.8,
                                      height: FlexoValues.deviceWidth* 0.15,
                                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                              child: FlexoTextWidget().headingText16(
                                                  text: e.note,
                                              )
                                          ),

                                          e.hasDownload?
                                          GestureDetector(
                                            onTap: ()async {
                                              if (await CheckConnectivity().checkInternet(context))
                                              {
                                                orderDetailsProvider.downloadButtonClickEvent(context: context, orderNoteId: e.id);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                              child: Text(
                                                localResourceProvider.getResourseByKey("order.notes.download"),
                                                style: TextStyle(
                                                  fontSize: FlexoValues.fontSize16,
                                                  color: FlexoColorConstants.HIGHLIGHT_COLOR,
                                                ),
                                              ),
                                            ),
                                          )
                                              :Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}