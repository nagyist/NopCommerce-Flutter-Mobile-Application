/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/BackInStockSubscriptions/BackInStockSubscriptionsProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/CheckboxWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class BackInSubscriptionComponent{

  getBackInSubscriptionComponent({required BuildContext context}){

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        var localResourceProvider = context.watch<LocalResourceProvider>();
        var backInStockSubscriptionsProvider = context.watch<BackInStockSubscriptionsProvider>();
        return Container(
          child: Column(
            children: [
              SizedBox(height:FlexoValues.widthSpace2Px),

              Container(
                width:FlexoValues.deviceWidth,
                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                child: FlexoTextWidget().headingText17(text: localResourceProvider.getResourseByKey("account.backInStockSubscriptions.description"),
                  maxLines: 2
                )
              ),

              SizedBox(height: FlexoValues.widthSpace5Px),

              Container(
                child: Column(
                  children: [
                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Table(
                        columnWidths: {
                          0:FlexColumnWidth(FlexoValues.deviceWidth * 0.16,),
                          1:FlexColumnWidth(FlexoValues.deviceWidth * 0.8,),
                        },
                        border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                        textBaseline: TextBaseline.alphabetic,
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color:FlexoColorConstants.HEADING_BACKGROUND_COLOR
                            ),
                            children: [
                              Container(
                                width:FlexoValues.deviceWidth * 0.16,
                                height: FlexoValues.deviceHeight * 0.06,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                    setState(() {
                                      backInStockSubscriptionsProvider.isAll=!backInStockSubscriptionsProvider.isAll;
                                      for(var i in backInStockSubscriptionsProvider.getCustomerSubscriptionsResponseModel.subscriptions){
                                        if(backInStockSubscriptionsProvider.isAll){
                                          backInStockSubscriptionsProvider.productList[i.id]=true;
                                          backInStockSubscriptionsProvider.removeList.add(i.id);
                                        }else if(backInStockSubscriptionsProvider.isAll==false){
                                          backInStockSubscriptionsProvider.productList[i.id]=false;
                                          backInStockSubscriptionsProvider.removeList.remove(i.id);
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: checkboxWidget(isCheck: backInStockSubscriptionsProvider.isAll,isReadOnly: false),
                                  ),
                                ),
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.8,
                                height: FlexoValues.deviceHeight * 0.06,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace3Px,),
                                child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey('account.backInStockSubscriptions.productColumn'),
                                  maxLines: 1
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Table(
                        columnWidths: {
                          0:FlexColumnWidth(FlexoValues.deviceWidth* 0.16),
                          1:FlexColumnWidth(FlexoValues.deviceWidth * 0.8),
                        },
                        border: TableBorder.all(color:FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                        textBaseline: TextBaseline.alphabetic,
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: backInStockSubscriptionsProvider.getCustomerSubscriptionsResponseModel.subscriptions.map((e){
                          if(backInStockSubscriptionsProvider.productList[e.id]==null){
                            backInStockSubscriptionsProvider.productList[e.id]=false;
                          }
                          return TableRow(
                            children: [
                              Container(
                                width: FlexoValues.deviceWidth * 0.16,
                                height:FlexoValues.deviceHeight * 0.06,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                    setState(() {
                                      backInStockSubscriptionsProvider.productList[e.id] = !backInStockSubscriptionsProvider.productList[e.id]!;
                                      if(backInStockSubscriptionsProvider.productList[e.id]==true){
                                        backInStockSubscriptionsProvider.removeList.add(e.id);
                                      }else if(backInStockSubscriptionsProvider.productList[e.id]==false) {
                                        backInStockSubscriptionsProvider.removeList.remove(e.id);
                                      }
                                      int selCnt = backInStockSubscriptionsProvider.productList.values.where((element) => element == true).toList().length;
                                      if(backInStockSubscriptionsProvider.getCustomerSubscriptionsResponseModel.subscriptions.length == selCnt)
                                      {
                                        backInStockSubscriptionsProvider.isAll = true;
                                      }else{
                                        backInStockSubscriptionsProvider.isAll = false;
                                      }

                                    });
                                  },
                                  child: Container(
                                    child: checkboxWidget(isCheck: backInStockSubscriptionsProvider.productList[e.id]!,isReadOnly: false),
                                  ),
                                ),
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.8,
                                height:FlexoValues.deviceHeight * 0.06,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace3Px,),
                                child: GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                    {
                                      backInStockSubscriptionsProvider.getHeaderData(context: context);
                                    });
                                  },
                                  child: Text(
                                    e.productName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleWidget.redirectTextStyle16,
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

              SizedBox(
                height: FlexoValues.widthSpace5Px,
              ),

              ButtonWidget().getButton(
                  text:localResourceProvider.getResourseByKey("account.backInStockSubscriptions.deleteSelected").toString().toUpperCase(),
                  width: FlexoValues.controlsWidth,
                  onClick: ()async{
                    if(await CheckConnectivity().checkInternet(context)){
                      backInStockSubscriptionsProvider.deleteButtonClickEvent(context: context, removePid: backInStockSubscriptionsProvider.removeList);}
                    },
                  isApiLoad: false
              ),
              
            ],
          ),
        );
      },
    );
  }
}

