/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestDetailProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class  ReturnRequestCommentComponent{
  getReturnRequestCommentComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var returnRequestDetailProvider = context.watch<ReturnRequestDetailProvider>();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          child: Column(
            children: [

              SizedBox(height:  FlexoValues.widthSpace2Px,),

              Container(
                width: FlexoValues.controlsWidth,
                alignment: Alignment.topLeft,
                child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("returnRequests.whyReturning")),
              ),

              SizedBox(height:  FlexoValues.widthSpace2Px,),

              Container(
                margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                alignment: Alignment.centerLeft,
                child: FlexoTextWidget().contentText15(
                  text:  localResourceProvider.getResourseByKey("returnRequests.returnReason"),
                )
              ),

              SizedBox(height: FlexoValues.widthSpace1Px),

              FlexoDropDown(width:FlexoValues.controlsWidth , showRequiredIcon: false, selectedValue: returnRequestDetailProvider.selectedReason, items: returnRequestDetailProvider.reasonDropdown, onChange: returnRequestDetailProvider.reasonChange),

              SizedBox(height:  FlexoValues.widthSpace2Px,),

              Container(
                margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px),
                alignment: Alignment.centerLeft,
                child:FlexoTextWidget().contentText15(
                  text: localResourceProvider.getResourseByKey("returnRequests.returnAction"),)
              ),

              SizedBox(height:FlexoValues.widthSpace1Px ),

              FlexoDropDown(width:FlexoValues.controlsWidth,showRequiredIcon: false, selectedValue: returnRequestDetailProvider.selectedAction, items: returnRequestDetailProvider.actionDropdown, onChange: returnRequestDetailProvider.actionChange),

              SizedBox(height:  FlexoValues.widthSpace2Px,),

              returnRequestDetailProvider.getReturnRequestModel.allowFiles ?
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                      alignment: Alignment.centerLeft,
                      child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("returnRequests.uploadedFile"))
                    ),

                    SizedBox(height: FlexoValues.deviceWidth * 0.01),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: () async{
                              returnRequestDetailProvider.openFileExplorer(context: context);
                            },
                            child: Container(
                              padding: EdgeInsets.all( FlexoValues.widthSpace2Px,),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:  FlexoColorConstants.BROWSE_BUTTON_COLOR,
                                  border: Border.all(
                                      color: FlexoColorConstants.BROWSE_BUTTON_BORDER_COLOR
                                  )
                              ),
                              child: FlexoTextWidget().browseButtonText(text: StringConstants.BROWSE_BUTTON),
                            ),
                          ),

                          returnRequestDetailProvider.base64 == "" ?
                          Container(
                            child: FlexoTextWidget().contentText14(text: StringConstants.NO_FILE_SELECTED,)) :
                          Container(
                            width: FlexoValues.deviceWidth * 0.55,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                            color: Colors.green,
                            child: Text(
                              returnRequestDetailProvider.fileName==null?"":returnRequestDetailProvider.fileName!,
                              style: TextStyle(
                                  fontSize: FlexoValues.fontSize16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height:  FlexoValues.widthSpace2Px,),
                  ],
                ),
              ) : Container(),

              Container(
                margin: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,),
                alignment: Alignment.centerLeft,
                child:FlexoTextWidget().contentText15(
                      text: localResourceProvider.getResourseByKey("returnRequests.comments"))
              ),

              SizedBox(height:FlexoValues.widthSpace1Px),

              TextFieldWidget(
                width: FlexoValues.controlsWidth,
                showRequiredIcon: false,
                controller:returnRequestDetailProvider.returnRequest,
                maxLine: 5,
              ),

              SizedBox(height:  FlexoValues.widthSpace3Px),

              ButtonWidget().getButton(text:localResourceProvider.getResourseByKey("returnRequests.submit").toString().toUpperCase(), width: FlexoValues.controlsWidth,
                  onClick: ()async{
                    if(await CheckConnectivity().checkInternet(context)){
                      KeyboardUtil.hideKeyboard(context);
                      returnRequestDetailProvider.updateButtonClickEvent(context: context, orderId: returnRequestDetailProvider.getReturnRequestModel.orderId);
                    }
                  }, isApiLoad:false),

              SizedBox(height:  FlexoValues.widthSpace3Px),
            ],
          ),
        );
      },
    );
  }
}

