/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestList/ReturnRequestProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomerReturnRequestComponent{

  getCustomerReturnRequestComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var returnRequestProvider = context.watch<ReturnRequestProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          child: Column(
            children: returnRequestProvider.getCustomerReturnRequestModel.items.map((e){
              return Container(
                width: FlexoValues.deviceWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color:FlexoColorConstants.LIST_BORDER_COLOR
                            ),
                            top: BorderSide(
                                color:FlexoColorConstants.LIST_BORDER_COLOR
                            )
                        ),
                        color:FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                      ),
                      width:FlexoValues.deviceWidth,
                      padding: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px),
                      child:FlexoTextWidget().headingBoldText16(
                        text: localResourceProvider.getResourseByKey("account.customerReturnRequests.title").toString().replaceAll("{0}",e.customNumber).replaceAll("{1}",e.returnRequestStatus),
                        maxLines: 1,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: FlexoValues.widthSpace2Px,),

                          Container(
                            width:FlexoValues.deviceWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: FlexoTextWidget().headingText16(
                                        text:"${localResourceProvider.getResourseByKey("account.customerReturnRequests.item")} ",
                                        maxLines: 1,
                                     )
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text.rich(
                                      TextSpan(
                                          text:e.productName,
                                          style: TextStyleWidget.redirectTextStyle16,
                                          recognizer: new TapGestureRecognizer()..onTap = () {
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                            {
                                              returnRequestProvider.getHeaderData(context: context);
                                            });
                                          },
                                          children: [
                                            TextSpan(
                                              text:" x ${e.quantity}",
                                              style: TextStyle(
                                                  fontSize: FlexoValues.fontSize16,
                                                  color:FlexoColorConstants.DARK_TEXT_COLOR,
                                                  fontWeight: FontWeight.normal
                                              ),
                                            ),
                                          ]
                                        ),
                                      ),
                                   ),
                                 ),
                               ],
                             ),
                          ),

                          SizedBox(height: FlexoValues.heightSpace1Px,),

                          Container(
                              child: FlexoTextWidget().headingText16(
                                text: localResourceProvider.getResourseByKey("account.customerReturnRequests.reason")+' '+e.returnReason,)
                          ),

                          SizedBox(height:  FlexoValues.heightSpace1Px,),

                          Container(
                              child: FlexoTextWidget().headingText16(
                                text: localResourceProvider.getResourseByKey("returnRequests.returnAction")+': '+e.returnAction,)
                          ),

                          SizedBox(height:  FlexoValues.heightSpace1Px,),

                          Container(
                              child: FlexoTextWidget().headingText16(
                                text: "${localResourceProvider.getResourseByKey("account.customerReturnRequests.date")+ " " +'${DateFormat("M/d/yyyy hh:mm:ss aa").format(e.createdOn)}'}",),
                          ),

                          SizedBox(height:  FlexoValues.heightSpace1Px,),

                          e.uploadedFileGuid != StringConstants.DEFAULT_GUID ?
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    child:  FlexoTextWidget().headingText16(text:localResourceProvider.getResourseByKey("account.customerReturnRequests.uploadedFile")+" ",)
                                ),
                                GestureDetector(
                                  onTap: ()async {
                                    if (await CheckConnectivity().checkInternet(context) )
                                    {
                                      returnRequestProvider.pdfDownloadClickButton(context: context, downloadGuild: e.uploadedFileGuid);
                                    }
                                  },
                                  child: Container(
                                      child: Text(
                                        "${localResourceProvider.getResourseByKey("account.customerReturnRequests.uploadedFile.download")}",
                                        style: TextStyleWidget.redirectTextStyle16,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ) :Container(),

                          SizedBox(height:  FlexoValues.heightSpace1Px,),

                          e.comments!="" && e.comments!=null ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: FlexoTextWidget().headingText16(
                                    text: "${e.comments != null ? localResourceProvider.getResourseByKey("account.customerReturnRequests.comments"): ""}",)
                              ),

                              SizedBox(height:FlexoValues.widthSpace2Px,),

                              Container(
                                  child:FlexoTextWidget().headingText16(text: "${e.comments!=null?e.comments:''}",)
                              ),
                            ],
                          ): Container(),

                          SizedBox(height: FlexoValues.heightSpace1Px,),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

