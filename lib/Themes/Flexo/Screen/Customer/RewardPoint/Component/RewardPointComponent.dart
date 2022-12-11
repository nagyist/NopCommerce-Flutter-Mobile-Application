/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/RewardPoint/RewardPointProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class RewardPointComponent{

  getRewardPointComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var rewardPointProvider = context.watch<RewardPointProvider>();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(width: FlexoValues.widthSpace2Px,),

          Container(
            padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px),
            child:Text(
              localResourceProvider.getResourseByKey("rewardPoints.currentBalance").toString().replaceAll("{0}", "${rewardPointProvider.getCustomerRewardPointsModel.rewardPointsBalance}").replaceAll("{1}", "${rewardPointProvider.getCustomerRewardPointsModel.rewardPointsAmount}"),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal
              ),
            ) ,
          ),

          SizedBox(height:FlexoValues.widthSpace2Px,),

          rewardPointProvider.getCustomerRewardPointsModel.minimumRewardPointsBalance.bitLength==0?Container():
          Container(
            padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px,),
            child:Text(
              localResourceProvider.getResourseByKey("rewardPoints.minimumBalance").toString().replaceAll("{0}", "${rewardPointProvider.getCustomerRewardPointsModel.minimumRewardPointsBalance}").replaceAll("{1}", "${rewardPointProvider.getCustomerRewardPointsModel.minimumRewardPointsAmount}"),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal
              ),
            ) ,
          ),

          SizedBox(height: FlexoValues.widthSpace2Px,),

          Container(
            padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace2Px),
            child:Text(
              localResourceProvider.getResourseByKey("rewardPoints.history"),
              style: TextStyle(
                  color: Colors.black,
                  fontSize:FlexoValues.fontSize17,
                  fontWeight: FontWeight.bold
              ),
            ) ,
          ),

          SizedBox(height: FlexoValues.widthSpace2Px),

          rewardPointProvider.getCustomerRewardPointsModel.rewardPoints.isNotEmpty?
          Container(
            width: FlexoValues.deviceWidth,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.only(left: FlexoValues.widthSpace2Px,right:FlexoValues.widthSpace2Px,top: FlexoValues.widthSpace2Px),
                child: Column(
                  children: [
                    Container(
                      width:FlexoValues.deviceWidth * 2.7,
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(FlexoValues.deviceWidth * 0.6,),
                          1: FlexColumnWidth(FlexoValues.deviceWidth * 0.35,),
                          2: FlexColumnWidth(FlexoValues.deviceWidth * 0.35,),
                          3: FlexColumnWidth(FlexoValues.deviceWidth * 0.8,),
                          4: FlexColumnWidth(FlexoValues.deviceWidth * 0.6,),
                        },
                        border: TableBorder.all(color:FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                        textBaseline: TextBaseline.alphabetic,
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Container(
                                width: FlexoValues.deviceWidth * 0.6,
                                height: FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color:FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: FlexoTextWidget().headingBoldText16(
                                    text: localResourceProvider.getResourseByKey("rewardPoints.fields.createdDate")
                                )
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.35,
                                height: FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                               padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: FlexoTextWidget().headingBoldText16(
                                    text: localResourceProvider.getResourseByKey("rewardPoints.fields.points"),
                                )
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.35,
                                height: FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color:FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: FlexoTextWidget().headingBoldText16(
                                    text: localResourceProvider.getResourseByKey("rewardPoints.fields.pointsBalance"),
                                 )
                              ),

                              Container(
                                width:FlexoValues.deviceWidth * 0.8,
                                height: FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color:FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: FlexoTextWidget().headingBoldText16(
                                    text: localResourceProvider.getResourseByKey("rewardPoints.fields.message"),
                                )
                              ),

                              Container(
                                width:FlexoValues.deviceWidth * 0.6,
                                height: FlexoValues.deviceHeight * 0.06,
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
                                    text:localResourceProvider.getResourseByKey("rewardPoints.fields.endDate"),
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width:FlexoValues.deviceWidth * 2.7,
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(FlexoValues.deviceWidth * 0.6,),
                          1: FlexColumnWidth(FlexoValues.deviceWidth * 0.35,),
                          2: FlexColumnWidth(FlexoValues.deviceWidth * 0.35,),
                          3: FlexColumnWidth(FlexoValues.deviceWidth * 0.8,),
                          4: FlexColumnWidth(FlexoValues.deviceWidth * 0.6,),
                        },
                        border: TableBorder.all(color: FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                        textBaseline: TextBaseline.alphabetic,
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: rewardPointProvider.rewardPoints.map((e) {
                          DateTime date=e.createdOn;
                          return TableRow(
                              children: [

                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width:FlexoValues.deviceWidth * 0.6,
                                    height:FlexoValues.deviceHeight * 0.07,
                                    child:FlexoTextWidget().contentText16(text:DateFormat("MM/dd/yyyy HH:mm:ss a").format(e.createdOn),
                                    maxLines: 1)
                                ),

                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width:FlexoValues.deviceWidth* 0.35,
                                    height: FlexoValues.deviceHeight * 0.07,
                                    child: FlexoTextWidget().contentText16(text: '${e.points}',
                                      maxLines: 1
                                    )
                                ),

                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width:FlexoValues.deviceWidth * 0.35,
                                    height:FlexoValues.deviceHeight * 0.07,
                                    child:FlexoTextWidget().contentText16(text:'${e.pointsBalance}',
                                      maxLines: 1
                                    )
                                ),

                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width:FlexoValues.deviceWidth * 0.8,
                                    height:FlexoValues.deviceHeight * 0.07,
                                    child: FlexoTextWidget().contentText16(
                                      text: e.message!=null?e.message:'' ,
                                        maxLines: 1
                                    )
                                ),

                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    width:FlexoValues.deviceWidth * 0.6,
                                    height: FlexoValues.deviceHeight * 0.07,
                                    child:FlexoTextWidget().contentText16(
                                      text:  e.endDate==null?'':DateFormat("MM/dd/yyyy HH:mm:ss a").format(e.endDate!),
                                      maxLines: 1
                                    )
                                ),
                              ]
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ):
          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
            child: Text(
              localResourceProvider.getResourseByKey("rewardPoints.nohistory"),
              style: TextStyle(
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ],
      ),
    );
  }
}