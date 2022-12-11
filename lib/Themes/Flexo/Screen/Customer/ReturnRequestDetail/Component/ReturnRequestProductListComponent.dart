/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestDetailProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoCustomDropDown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';

class ReturnRequestProductListComponent{

  getReturnRequestProductListComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var returnRequestDetailProvider = context.watch<ReturnRequestDetailProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            Container(
              child: Column(
                children: returnRequestDetailProvider.getReturnRequestModel.items.map((e) {
                  if(returnRequestDetailProvider.qnt[e.id]==null){
                    returnRequestDetailProvider.selectQnt[e.id]=0;
                    returnRequestDetailProvider.qnt[e.id]=0;
                  }
                  if(returnRequestDetailProvider.selectedIndex[e.id] == null)
                  {
                    returnRequestDetailProvider.selectedIndex[e.id] = 0;
                  }
                  int i=0;
                  List<int> qnts=[];
                  while(i<=e.quantity){
                    qnts.add(i);
                    i++;
                  }
                  returnRequestDetailProvider.quantity[e.id]=qnts;
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: FlexoColorConstants.LIST_BORDER_COLOR
                            )
                        )
                    ),
                    width: FlexoValues.deviceWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Container(
                            width:FlexoValues.controlsWidth,
                            child: GestureDetector(
                              onTap:(){
                                Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                {
                                  returnRequestDetailProvider.getHeaderData(context: context);
                                });
                              },
                              child: Text(
                                  e.productName,
                                  style:TextStyleWidget.redirectTextStyle16
                              ),
                            )
                        ),

                        SizedBox(height:  FlexoValues.widthSpace2Px,),

                        Container(
                          padding: EdgeInsets.only(left:  FlexoValues.widthSpace2Px,right:  FlexoValues.widthSpace2Px,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                    localResourceProvider.getResourseByKey("returnRequests.products.price")+": ",
                                    style: TextStyle(
                                        color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                        fontSize: FlexoValues.fontSize16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                              ),
                              Container(
                                  child: FlexoTextWidget().headingBoldText15(
                                    text: e.unitPrice,
                                  )
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        Container(
                         width: FlexoValues.deviceWidth ,
                         padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child:FlexoTextWidget().contentText16(
                                    text: localResourceProvider.getResourseByKey("returnRequests.products.quantity")+": ",
                                 )
                              ),
                              Container(
                                child: FlexoCustomDropDown(
                                    width:FlexoValues.deviceWidth * 0.2 ,
                                    height:FlexoValues.deviceWidth * 0.08,
                                    selectedValue: returnRequestDetailProvider.qnt[e.id].toString(),
                                    items: returnRequestDetailProvider.quantity[e.id]!.map((p) {
                                      return DropDownModel(text: "$p", value: p.toString());
                                    }).toList(),
                                    onChange: (value){
                                      setState(() {
                                        returnRequestDetailProvider.qnt[e.id] = int.parse(value);
                                      });
                                    },),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height:  FlexoValues.widthSpace2Px,),

                        e.attributeInfo == "" || e.attributeInfo == null ?  Container() :
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: HTML.toTextSpan(
                              context,
                              e.attributeInfo,
                              defaultTextStyle: TextStyle(
                                color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                fontSize: FlexoValues.fontSize16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:  FlexoValues.widthSpace2Px,)

                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height:  FlexoValues.widthSpace2Px,),
          ],
        );
      },
    );
  }
}

