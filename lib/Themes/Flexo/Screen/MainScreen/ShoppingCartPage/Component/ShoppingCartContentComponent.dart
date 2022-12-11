/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Models/AttributeValueModel.dart';
import 'package:nopcommerce/Models/CheckoutAttribute.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetails/TopicBlockDetails.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetailsById/TopicBlockDetailsById.dart';
import 'package:nopcommerce/Screens/Home/CartEstimateShipping/CartEstimateShipping.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TaxDisplayType.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Enum/TopicType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';

class ShoppingCartContentComponent {

  attributeHeading({required String heading, required bool isRequired})
  {
    return Container(
      width: FlexoValues.controlsWidth,
      child: RichText(
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: new TextSpan(
            text: heading,
            style: TextStyleWidget.controlsHeadingTextStyle,
            children: [
              isRequired ?
              TextSpan(
                text:" *",
                style: TextStyleWidget.controlsRequiredTextStyle,
              ) : TextSpan(),
            ]
        ),
      ),
    );
  }

  radioListContainer({required BuildContext context, required CheckoutAttribute checkoutAttribute,required StateSetter setState})
  {
    var homeProvider = context.watch<HomeProvider>();

    if(checkoutAttribute.defaultValue==null){
      for(var i in checkoutAttribute.values){
        if (i.isPreSelected) {
          checkoutAttribute.defaultValue = i.id;
        }
      }
    }
    if(checkoutAttribute.defaultValue!=null){
      for(var i in checkoutAttribute.values){
        if(checkoutAttribute.defaultValue==i.id){
          i.isPreSelected = true;
        }else{
          i.isPreSelected = false;
        }
      }
    }

    return Container(
      width: FlexoValues.controlsWidth,
      child: Wrap(
        children: checkoutAttribute.values.map((item) {
          return Container(
            margin: EdgeInsets.only(right: FlexoValues.widthSpace3Px,bottom: FlexoValues.widthSpace3Px),
            child: GestureDetector(
              onTap: (){
               setState(()
               {
                 checkoutAttribute.defaultValue = item.id;
                 for(var it in checkoutAttribute.values)
                 {
                   if(it.id == item.id)
                   {
                     it.isPreSelected = true;
                   }else{
                     it.isPreSelected = false;
                   }
                 }
                 homeProvider.attributeOnChanged(context: context);
               });
              },
              child: ButtonWidget().getRatioButton(text: item.priceAdjustment == null ? item.name : item.name +" [${item.priceAdjustment}]", isCheck: item.isPreSelected),
            ),
          );
        }).toList(),
      ),
    );
  }

  checkBoxContainer({required BuildContext context,required CheckoutAttribute checkoutAttribute,required StateSetter setState})
  {
    var homeProvider = context.watch<HomeProvider>();

    return Container(
      width: FlexoValues.controlsWidth,
      child: Wrap(
        children: checkoutAttribute.values.map((item) {
          return Container(
            margin: EdgeInsets.only(right: FlexoValues.widthSpace4Px,bottom: FlexoValues.widthSpace3Px),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Transform.scale(
                    scale: FlexoValues.switchScale,
                    child: CupertinoSwitch(
                      onChanged: (val)
                      {
                        if(checkoutAttribute.attributeControlType != AttributeControlType.ReadonlyCheckboxes)
                        {
                          setState((){
                            if(item.isPreSelected)
                            {
                              item.isPreSelected = false;
                            }else{
                              item.isPreSelected = true;
                            }
                            homeProvider.attributeOnChanged(context: context);
                          });
                        }
                      },
                      value: item.isPreSelected,
                      activeColor: checkoutAttribute.attributeControlType == AttributeControlType.ReadonlyCheckboxes ? FlexoColorConstants.ACCENT_DE_ACTIVE_COLOR : FlexoColorConstants.ACCENT_COLOR,
                    ),
                  ),

                  Flexible(
                    child: Container(
                      child: Text(
                        item.priceAdjustment == null ? item.name : item.name +" [${item.priceAdjustment}]",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyleWidget.controlsTextStyle,
                      ),
                    ),
                  )

                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  customerAttributesSwitch({required BuildContext context,required List<CheckoutAttribute> customerAttributes})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return StatefulBuilder(
      builder: (context, setState)
      {
        return Container(
          width: FlexoValues.deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: customerAttributes.map((e)
            {
              Widget widget = Container();

              switch(e.attributeControlType)
              {
                case AttributeControlType.DropdownList:

                  List<DropDownModel> dropdownList = [];

                  if(!e.isRequired)
                  {
                    List<Value> values = e.values.where((element) => element.id == 0).toList();
                    if(values.isEmpty)
                    {
                      e.values.insert(0,new Value(name: "---", colorSquaresRgb: "", priceAdjustment: "", isPreSelected: true, id: 0, customProperties: CustomProperties()));
                    }
                  }
                  for(var item in e.values)
                  {
                    dropdownList.add(new DropDownModel(text: '${item.priceAdjustment == null || item.priceAdjustment == "" ? item.name : item.name +" [${item.priceAdjustment}]"}', value: item.id.toString())) ;
                  }

                  if(e.defaultValue == null)
                  {
                    for(var item in e.values)
                    {
                      if(item.isPreSelected)
                      {
                        e.defaultValue = item.id.toString();
                      }
                    }
                  }

                  if(e.defaultValue == null)
                  {
                    if(e.isRequired)
                    {
                      e.defaultValue = e.values[0].id.toString();
                    }else{
                      e.defaultValue = e.values[0].id.toString();
                    }
                  }

                  widget = Container(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                          SizedBox(height: FlexoValues.widthSpace1Px,),

                          FlexoDropDown(
                              width: FlexoValues.controlsWidth,
                              selectedValue: e.defaultValue,
                              showRequiredIcon: false,
                              items: dropdownList,
                              onChange: (val)
                              {
                                setState(()
                                {
                                  e.defaultValue = val.toString();
                                  homeProvider.attributeOnChanged(context: context);
                                });
                              }
                          ),

                          SizedBox(height: FlexoValues.widthSpace2Px,)
                        ],
                      ),
                    ),
                  );
                  break;

                case AttributeControlType.RadioList:
                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        radioListContainer(context: context,checkoutAttribute: e,setState: setState),

                        SizedBox(height: FlexoValues.widthSpace2Px,)
                      ],
                    ),
                  );
                  break;

                case AttributeControlType.Checkboxes:
                case AttributeControlType.ReadonlyCheckboxes:

                  if(e.defaultValue == null)
                  {
                    e.defaultValue="";
                  }

                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        checkBoxContainer(context: context,checkoutAttribute: e,setState: setState),

                        SizedBox(height: FlexoValues.widthSpace2Px,)
                      ],
                    ),
                  );
                  break;

                case AttributeControlType.TextBox:
                  if(e.defaultValue == null)
                  {
                    e.defaultValue="";
                  }

                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace1Px,),

                        TextFieldWidget(
                          width: FlexoValues.controlsWidth,
                          showRequiredIcon: false,
                          onChange: (value)
                          {
                            e.defaultValue = value;
                          },
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px,)
                      ],
                    ),
                  );
                  break;

                case AttributeControlType.MultilineTextbox:

                  if(e.defaultValue == null)
                  {
                    e.defaultValue="";
                  }

                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace1Px,),

                        TextFieldWidget(
                          width: FlexoValues.controlsWidth,
                          maxLine: 5,
                          showRequiredIcon: false,
                          onChange: (value)
                          {
                            e.defaultValue = value;
                          },
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px,),
                      ],
                    ),
                  );
                  break;

                case AttributeControlType.FileUpload:

                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start  ,
                          children: [
                            Container(
                              width: FlexoValues.controlsWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  GestureDetector(
                                    onTap: () async{
                                      if(await CheckConnectivity().checkInternet(context)){
                                        setState(()
                                        {
                                          homeProvider.openFileExplorer(context: context, attributeID: e.id);
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: FlexoColorConstants.BROWSE_BUTTON_COLOR,
                                          border: Border.all(
                                              color: FlexoColorConstants.BROWSE_BUTTON_BORDER_COLOR
                                          )
                                      ),
                                      child: FlexoTextWidget().browseButtonText(text: StringConstants.BROWSE_BUTTON),
                                    ),
                                  ),

                                  homeProvider.fileUploadMap[e.id] != null ?
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        homeProvider.fileUploadMap[e.id].toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: FlexoValues.fontSize15,
                                            color: Colors.green,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                  ) : Container()
                                ],
                              ),
                            ),
                            homeProvider.fileUploadMap[e.id] != null && homeProvider.removeShow ?
                            Container(
                              width: FlexoValues.deviceWidth * 0.3,
                              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                                    width: FlexoValues.deviceWidth * 0.3,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        homeProvider.downloadPDF(context: context);
                                      },
                                      child: Text(
                                        localResourceProvider.getResourseByKey("common.fileUploader.downloadUploadedFile"),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: FlexoValues.fontSize15,
                                          color: FlexoColorConstants.HIGHLIGHT_COLOR,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                                    width: FlexoValues.deviceWidth * 0.3,
                                    child: GestureDetector(
                                      onTap: (){
                                        setState((){
                                          homeProvider.removeShow=false;
                                          homeProvider.fileUploadMap[e.id]='';
                                        });
                                      },
                                      child: FlexoTextWidget().redirectText15(text: localResourceProvider.getResourseByKey("common.fileUploader.removeDownload"),),
                                    ),
                                  ),
                                ],
                              ),
                            ):Container(),
                          ],
                        )
                      ],
                    ),
                  );
                  break;

                case AttributeControlType.ColorSquares:

                  if(e.defaultValue == null)
                  {
                    e.defaultValue="";
                  }

                  widget = Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        attributeHeading(heading: e.textPrompt == null ? e.name : e.textPrompt, isRequired: e.isRequired),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Container(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: e.values.map((value)
                            {
                              int colorCode = int.parse(value.colorSquaresRgb.replaceAll("#", "0xff"));

                              return GestureDetector(
                                onTap: () async{
                                  if(await CheckConnectivity().checkInternet(context)){
                                    setState(()
                                    {
                                      e.defaultValue = value.id.toString();
                                      homeProvider.attributeOnChanged(context: context);
                                    });
                                  }

                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,bottom: FlexoValues.widthSpace2Px),
                                      height: e.defaultValue == value.id.toString() ? FlexoValues.deviceWidth * 0.09 : FlexoValues.deviceWidth * 0.08,
                                      width: e.defaultValue == value.id.toString() ? FlexoValues.deviceWidth * 0.09 : FlexoValues.deviceWidth * 0.08,
                                      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                      decoration: BoxDecoration(
                                          color: Color(colorCode),
                                          borderRadius: BorderRadius.all(Radius.circular(FlexoValues.widthSpace1Px)),
                                          border: Border.all(
                                              color: e.defaultValue == value.id.toString() ? Colors.blue.shade900 : Color(colorCode),
                                              width: FlexoValues.deviceWidth * 0.005
                                          )
                                      ),
                                      child: e.defaultValue == value.id.toString() ? Icon(
                                        Icons.check,
                                        color: Colors.blue.shade900,
                                        size: FlexoValues.iconSize20,
                                      ) : Container(),
                                    ),

                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          value.priceAdjustment == null ? value.name : value.name +" [${value.priceAdjustment}]",
                                          style: TextStyle(
                                              color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                              fontSize: FlexoValues.fontSize16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );

                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );

                  break;
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                child: widget,
              );
            }).toList(),
          ),
        );
      }
    );
  }

  getShoppingCartContentComponent({required BuildContext context}) {
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {

        homeProvider.prepareCartContentData();

        return Container(
            child: Column(
              children:[

                homeProvider.estimateShippingResponseModel == null ? Container() :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(height: FlexoValues.heightSpace1Px,),

                      ButtonWidget().getButton(
                          text: localResourceProvider.getResourseByKey("shoppingCart.estimateShipping.button").toString().toUpperCase(),
                          width: FlexoValues.controlsWidth,
                          onClick: ()
                          {
                            Navigator.push(context, PageTransition(type: selectedTransition, child: CartEstimateShippingPopup(estimateShippingResponseModel: homeProvider.estimateShippingModel,productEstimateShippingChangeRequestModel: homeProvider.preEstimateShipping))).then((value) {
                              if(value != null)
                              {
                                homeProvider.updateEstimateData(context: context, requestModel: value);
                              }
                            });
                          },
                          isApiLoad: false),
                    ],
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px),

                customerAttributesSwitch(context: context,customerAttributes: homeProvider.getCartModel.checkoutAttributes),

                SizedBox(height: FlexoValues.widthSpace2Px,),

                Container(
                  width: FlexoValues.controlsWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      TextFieldWidget(
                        width: FlexoValues.deviceWidth * 0.8,
                        showRequiredIcon: false,
                        required: true,
                        hintText: localResourceProvider.getResourseByKey("shoppingCart.DiscountCouponCode.tooltip"),
                        errorMsg: localResourceProvider.getResourseByKey("shoppingCart.discountCouponCode.empty"),
                        controller: homeProvider.discountCodeController,
                      ),

                      GestureDetector(
                        onTap: () async {
                          if (await CheckConnectivity().checkInternet(context)) {
                            homeProvider.discountCouponClickEvent(context: context);
                          }
                        },
                        child: Container(
                            width: FlexoValues.deviceWidth * 0.16,
                            height: FlexoValues.deviceHeight * 0.07,
                            decoration: BoxDecoration(
                              color: FlexoColorConstants.BUTTON_COLOR,
                            ),
                            child: Icon(
                              Ionicons.checkmark_outline,
                              color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                              size: FlexoValues.fontSize24,
                            )
                        ),
                      ),
                    ],
                  ),
                  height: FlexoValues.deviceHeight * 0.07,
                ),

                homeProvider.discountCouponMsg == "" ? Container() :
                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px, vertical: FlexoValues.widthSpace1Px),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    homeProvider.discountCouponMsg.trim(),
                    style: TextStyle(
                        fontSize: FlexoValues.fontSize14,
                        color: homeProvider.isDiscountApplied ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Container(
                  child: Column(
                    children: homeProvider.getCartModel.discountBox.appliedDiscountsWithCodes.map((e) {
                      return Container(
                        width: FlexoValues.controlsWidth,
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px, vertical: FlexoValues.widthSpace1Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: FlexoValues.deviceWidth * 0.8,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                localResourceProvider.getResourseByKey("shoppingCart.discountCouponCode.currentCode").toString().replaceAll("{0}", e.couponCode),
                                style: TextStyle(
                                    fontSize: FlexoValues.fontSize15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () async {
                                if (await CheckConnectivity().checkInternet(context)) {
                                  homeProvider.removeDiscountCouponClickEvent(context: context,appliedDiscountsWithCode: e);
                                }
                              },
                              child: Container(
                                child: Icon(
                                  Icons.close_outlined,
                                  color: Colors.grey,
                                  size: FlexoValues.fontSize20,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.controlsWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      TextFieldWidget(
                        width: FlexoValues.deviceWidth * 0.8,
                        showRequiredIcon: false,
                        required: true,
                        hintText: localResourceProvider.getResourseByKey("shoppingCart.giftCardCouponCode.label"),
                        errorMsg: localResourceProvider.getResourseByKey("shoppingCart.discountCouponCode.empty"),
                        controller: homeProvider.giftCardController,
                      ),

                      GestureDetector(
                        onTap: () async {
                          if (await CheckConnectivity().checkInternet(context)) {
                            homeProvider.giftCardCouponCodeClickEvent(context: context);
                          }
                        },
                        child: Container(
                            width: FlexoValues.deviceWidth * 0.16,
                            height: FlexoValues.deviceHeight * 0.07,
                            decoration: BoxDecoration(
                              color: FlexoColorConstants.BUTTON_COLOR,
                            ),
                            child: Icon(
                              Ionicons.checkmark_outline,
                              color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                              size: FlexoValues.fontSize24,
                            )
                        ),
                      ),

                    ],
                  ),
                  height: FlexoValues.deviceHeight * 0.07,
                ),

                homeProvider.giftCardCouponMsg == "" ? Container() :
                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px, vertical: FlexoValues.widthSpace1Px),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    homeProvider.giftCardCouponMsg.trim(),
                    style: TextStyle(
                        fontSize: FlexoValues.fontSize14,
                        color: homeProvider.isGiftCardApplied ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                homeProvider.getCartModel.isEditable && homeProvider.getCartModel.items.length > 0 && homeProvider.getCartModel.displayTaxShippingInfo ?
                Container(
                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: HTML.toTextSpan(
                              context,
                              homeProvider.taxTypeModel.currentTaxType == TaxDisplayType.IncludingTax
                                  ? localResourceProvider.getResourseByKey("wishlist.taxShipping.inclTax")
                                  : localResourceProvider.getResourseByKey("wishlist.taxShipping.exclTax"),
                              defaultTextStyle: TextStyleWidget.contentTextStyle15,
                              overrideStyle: {
                                "a": TextStyleWidget.redirectTextStyle16,
                              },
                              linksCallback: (url) {
                                setState(() {
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetailsById(name: "", seName: "ShippingInfo", topicId: 0, topicType: TopicType.SeName)));
                                });
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: FlexoValues.heightSpace2Px,),
                    ],
                  ),
                ) : Container(),

                Divider(
                  color: FlexoColorConstants.LIST_BORDER_COLOR,
                  thickness: 1,
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: FlexoColorConstants.LIST_BORDER_COLOR
                          )

                      )
                  ),
                  child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shoppingCart.totals.subtotal").toString().toUpperCase(),maxLines: 2),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                Container(
                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                  child: Column(
                    children: [

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: FlexoValues.deviceWidth * 0.5,
                              child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.subtotal") + ": ",maxLines: 2),
                            ),
                            Container(
                              width: FlexoValues.deviceWidth * 0.4,
                              alignment: Alignment.centerRight,
                              child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.subTotal == null
                                  ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout")
                                  : homeProvider.orderTotalResponseModel.subTotal,maxLines: 2),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px,),

                      homeProvider.orderTotalResponseModel.subTotalDiscount != null ?
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: FlexoValues.deviceWidth * 0.5,
                                  child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.subtotalDiscount") +":",maxLines: 2),
                                ),
                                Container(
                                  width: FlexoValues.deviceWidth * 0.4,
                                  alignment: Alignment.centerRight,
                                  child: FlexoTextWidget().subTotalRightText(text:  homeProvider.orderTotalResponseModel.subTotalDiscount == null
                                      ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout"): homeProvider.orderTotalResponseModel.subTotalDiscount,maxLines: 2),
                                ),
                              ],
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      !homeProvider.orderTotalResponseModel.hideShippingTotal ?
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    child: FlexoTextWidget().subTotalLeftText(text: homeProvider.orderTotalResponseModel
                                    .requiresShipping &&
                                    homeProvider.orderTotalResponseModel.selectedShippingMethod != null
                                    ? localResourceProvider.getResourseByKey("shoppingCart.totals.shipping") +
                                    ": (" + homeProvider.orderTotalResponseModel.selectedShippingMethod + ")"
                                    : localResourceProvider.getResourseByKey("shoppingCart.totals.shipping") + ":",maxLines: 2),
                                  ),

                                  homeProvider.orderTotalResponseModel.requiresShipping ?
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.shipping != null ? homeProvider.orderTotalResponseModel.shipping : localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout"),maxLines: 2),
                                  ) :
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout"),maxLines: 2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      homeProvider.orderTotalResponseModel.paymentMethodAdditionalFee != null ?
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.5,
                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.paymentMethodAdditionalFee") +":",maxLines: 2),
                                  ),

                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.paymentMethodAdditionalFee,maxLines: 2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      homeProvider.orderTotalResponseModel.displayTaxRates && homeProvider.orderTotalResponseModel.taxRates.length > 0 ?
                      Container(
                        child: Column(
                          children: [
                            Column(
                                children: homeProvider.orderTotalResponseModel.taxRates.map((taxRate) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: FlexoValues.deviceWidth * 0.5,
                                          child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.taxRateLine")
                                              .toString()
                                              .replaceAll(
                                              "{0}", taxRate.rate) + ":",maxLines: 2),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth * 0.4,
                                          alignment: Alignment.centerRight,
                                          child: FlexoTextWidget().subTotalRightText(text: taxRate.value,maxLines: 2),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList()
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      homeProvider.orderTotalResponseModel.displayTax ?
                      Container(
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.5,
                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.tax") + ":",maxLines: 2),
                                  ),

                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.tax == null
                                        ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout")
                                        : homeProvider.orderTotalResponseModel.tax,maxLines: 2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),


                      homeProvider.orderTotalResponseModel.orderTotalDiscount != null ?
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.5,
                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("messages.order.totalDiscount"),maxLines: 2),
                                  ),

                                  Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.orderTotalDiscount == null
                                        ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout")
                                        : homeProvider.orderTotalResponseModel
                                        .orderTotalDiscount,maxLines: 2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      homeProvider.orderTotalResponseModel.giftCards.length > 0 ?
                      Container(
                        child: Column(
                          children: [

                            Container(
                              child: Column(
                                children: homeProvider.orderTotalResponseModel.giftCards.map((e) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: FlexoValues.deviceWidth * 0.6,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo") +": " +localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo.code").toString().replaceAll("{0}",e.couponCode),maxLines: 2),
                                                    ),

                                                    GestureDetector(
                                                      onTap: () async {
                                                        homeProvider.removeGiftCardClickEvent(context: context,giftCardData: e);
                                                      },
                                                      child: Container(
                                                        width: FlexoValues.deviceWidth * 0.1,
                                                        child: Icon(
                                                          Icons.close_outlined,
                                                          color: Colors.grey,
                                                          size: FlexoValues.fontSize20,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                width: FlexoValues.deviceWidth * 0.3,
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo.remaining").toString().replaceAll("{0}", e.remaining),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                      fontStyle: FontStyle.italic,
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth * 0.3,
                                          alignment: Alignment.centerRight,
                                          child: FlexoTextWidget().subTotalRightText(text: e.amount,maxLines: 2),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      homeProvider.orderTotalResponseModel.redeemedRewardPoints > 0 ?
                      Container(
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.3,
                                    child: FlexoTextWidget().subTotalLeftText(text: localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints").toString().replaceAll("{0}",homeProvider.orderTotalResponseModel.redeemedRewardPoints.toString()) + " :",maxLines: 2),
                                  ),
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.6,
                                    alignment: Alignment.centerRight,
                                    child: FlexoTextWidget().subTotalRightText(text: homeProvider.orderTotalResponseModel.redeemedRewardPointsAmount,maxLines: 2),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: FlexoValues.deviceWidth * 0.3,
                              child: FlexoTextWidget().subTotalLeftTextBold(text: localResourceProvider.getResourseByKey("shoppingCart.totals.orderTotal") + ":",maxLines: 2),
                            ),
                            Container(
                              width: FlexoValues.deviceWidth * 0.6,
                              alignment: Alignment.centerRight,
                              child: FlexoTextWidget().subTotalRightTextBold(text: homeProvider.orderTotalResponseModel.orderTotal ==null || homeProvider.orderTotalResponseModel.orderTotal == ""
                                  ? localResourceProvider.getResourseByKey("shoppingCart.totals.calculatedDuringCheckout")
                                  : homeProvider.orderTotalResponseModel.orderTotal,maxLines: 2),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px,),

                      homeProvider.orderTotalResponseModel.willEarnRewardPoints > 0 ?
                      Container(
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.3,
                                    child: Text(
                                      localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints.willEarn") +":",
                                      style: TextStyle(
                                          fontSize: FlexoValues.fontSize15,
                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: FlexoValues.deviceWidth * 0.6,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      localResourceProvider.getResourseByKey("shoppingCart.totals.rewardPoints.willEarn.point").toString().replaceAll("{0}",homeProvider.orderTotalResponseModel.willEarnRewardPoints.toString()),
                                      style: TextStyle(
                                          fontSize: FlexoValues.fontSize15,
                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ) : Container(),

                    ],
                  ),
                ),

                homeProvider.getCartModel.isEditable ?
                homeProvider.getCartModel.minOrderSubtotalWarning != null ?
                Container(
                  width: FlexoValues.deviceWidth,
                  margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                  alignment: Alignment.center,
                  child: FlexoTextWidget().warningMessageText(text: homeProvider.getCartModel.minOrderSubtotalWarning,maxLines: 2),
                ) :
                Container() :
                Container(),

                SizedBox(height: FlexoValues.widthSpace2Px,),

                homeProvider.getCartModel.isEditable ?
                Container(
                  child: Column(
                    children: [

                      homeProvider.getCartModel.termsOfServiceOnShoppingCartPage ?
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: FlexoValues.switchScale,
                              child: CupertinoSwitch(
                                onChanged: (val) {
                                  setState(() {
                                    homeProvider.isStartCheckoutCheckbox = val;
                                  });
                                },
                                value: homeProvider.isStartCheckoutCheckbox,
                                activeColor: FlexoColorConstants.ACCENT_COLOR,
                              ),
                            ),

                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: localResourceProvider.getResourseByKey("checkout.termsOfService.iAccept") +" ",
                                      style: TextStyleWidget.contentTextStyle16,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: localResourceProvider.getResourseByKey("checkout.termsOfService.read"),
                                            style: TextStyleWidget.redirectTextStyle16,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(() {
                                                  if (homeProvider.getCartModel.termsOfServicePopup) {
                                                    DialogBoxWidget().informationDialogBox(context: context, title: homeProvider.topicTitle, body: homeProvider.topicBody, heading: localResourceProvider.getResourseByKey("checkout.termsOfService"));

                                                  } else {
                                                    Navigator.push(context,PageTransition(type: selectedTransition, child: TopicBlockDetails(topicTitle: homeProvider.topicTitle,topicBody: homeProvider.topicBody)));
                                                  }
                                                });
                                              }
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) :
                      Container(),

                      SizedBox(height: FlexoValues.widthSpace2Px,),

                      homeProvider.getCartModel.minOrderSubtotalWarning == null && !homeProvider.getCartModel.hideCheckoutButton ?

                      localResourceProvider.getSettingByName("orderSettings.checkoutDisabled") == "True" ?
                      Container(
                        child: Center(
                            child: Text(
                              localResourceProvider.getSettingByName("checkout.disabled"),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FlexoValues.fontSize16,
                                  color: Colors.red

                              ),
                            )
                        ),
                      ) :
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            GestureDetector(
                              onTap: () async {
                                if (await CheckConnectivity().checkInternet(context)) {
                                  if (!homeProvider.isStartCheckoutCheckbox) {
                                    DialogBoxWidget().informationDialogBox(context: context, title: "", body: localResourceProvider.getResourseByKey("checkout.termsOfService.pleaseAccept"), heading: localResourceProvider.getResourseByKey("checkout.termsOfService"));

                                  } else {
                                    homeProvider.startCheckout(context: context);
                                  }
                                }
                              },
                              child: Container(
                                width: FlexoValues.controlsWidth,
                                height: FlexoValues.controlsHeight,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: FlexoColorConstants.BUTTON_COLOR,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: FlexoTextWidget().buttonText(text: localResourceProvider.getResourseByKey("checkout.button").toString().toUpperCase(), maxLines: 1),
                                    ),

                                    SizedBox(width: FlexoValues.widthSpace1Px,),

                                    Container(
                                      child: Icon(
                                        Ionicons.arrow_forward_outline,
                                        color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                                        size: FlexoValues.fontSize18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) : Container(),
                    ],
                  ),
                ) : Container(),

                SizedBox(height: FlexoValues.heightSpace2Px,),
              ],
            )
        );
      },
    );
  }
}