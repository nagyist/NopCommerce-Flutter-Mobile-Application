/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/AddressAttributesValuesModel.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetails/TopicBlockDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProductsAndOrderTotal.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoCustomDropDown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class PaymentInfoAndConfirmOrderComponent extends StatefulWidget {
  final ScrollController scrollController;
  const PaymentInfoAndConfirmOrderComponent({required this.scrollController});

  @override
  State<PaymentInfoAndConfirmOrderComponent> createState() => _PaymentInfoAndConfirmOrderComponentState();
}

class _PaymentInfoAndConfirmOrderComponentState extends State<PaymentInfoAndConfirmOrderComponent> {

  TextEditingController cardHolderName=new TextEditingController();
  TextEditingController cardNumber=new TextEditingController();
  TextEditingController cardCode=new TextEditingController();
  TextEditingController poNumber=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
            child: IgnorePointer(
              ignoring: checkoutProvider.isAPILoader,
              child: new ExpansionTile(
                expandedAlignment: Alignment.topCenter ,
                textColor: Colors.white,
                key: GlobalKey(),
                collapsedTextColor: FlexoColorConstants.DARK_TEXT_COLOR,
                backgroundColor: FlexoColorConstants.COLLAPSE_SELECTED_COLOR,
                collapsedBackgroundColor: checkoutProvider.isPaymentInformationMethodTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                initiallyExpanded:  checkoutProvider.isPaymentInformationMethod,
                trailing: Container(width: 0,),
                onExpansionChanged: (val)
                {
                  checkoutProvider.paymentInfoTabExpand(context: context);
                },
                leading: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        right:BorderSide(
                          color:Colors.white,
                        )
                    ),
                    color: checkoutProvider.isPaymentInformationMethod || checkoutProvider.isPaymentInformationMethodTabCompleted ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
                  ),
                  width: FlexoValues.deviceWidth * 0.12,
                  alignment: Alignment.center,
                  child: Text(
                    checkoutProvider.paymentInformationTabIndex,
                    style: TextStyle(
                      color: checkoutProvider.isPaymentInformationMethod || checkoutProvider.isPaymentInformationMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                      fontSize: FlexoValues.fontSize17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                title: Container(
                    child: new Text(
                      localResourceProvider.getResourseByKey("checkout.paymentInfo"),
                      style: new TextStyle(
                        fontSize: FlexoValues.fontSize16,
                        fontWeight: FontWeight.normal,
                        color: checkoutProvider.isPaymentInformationMethod || checkoutProvider.isPaymentInformationMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                      ),
                    )
                ),
                children: <Widget>[
                  !checkoutProvider.isPaymentInfoLoad ? Container() :
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: FlexoValues.heightSpace2Px),

                        Column(
                          children: [
                            SizedBox(height: FlexoValues.widthSpace2Px),

                            checkoutProvider.isPaymentInformationMethod && checkoutProvider.isPaymentWorking?
                            Column(
                              children: [

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.CheckMoneyOrder"?
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      child: RichText(
                                        text: HTML.toTextSpan(
                                          context,
                                          checkoutProvider.getPaymentInfoModel.descriptionText,
                                          defaultTextStyle: TextStyle(
                                            color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                            fontSize: FlexoValues.fontSize15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: FlexoValues.widthSpace2Px),
                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.AuthorizeNet"?
                                Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardHolderName,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardHolderName.required"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardNumber.required"),
                                            ),
                                         ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width:FlexoValues.deviceWidth,
                                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            width:FlexoValues.controlsWidth,
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            alignment:Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    selectedValue: checkoutProvider.getPaymentInfoNetBankingModel.expireMonth,
                                                    items: checkoutProvider.getPaymentInfoNetBankingModel.expireMonths.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.getPaymentInfoNetBankingModel.expireMonth = val;
                                                      });
                                                    }
                                                ),

                                                Container(
                                                  child: FlexoTextWidget().headingBoldText17(text: ' / ',),
                                                ),

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    selectedValue: checkoutProvider.getPaymentInfoNetBankingModel.expireYear,
                                                    items: checkoutProvider.getPaymentInfoNetBankingModel.expireYears.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.getPaymentInfoNetBankingModel.expireYear = val;
                                                      });
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardCode,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardCode.required"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )

                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.BrainTree"?
                                Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardNumber.required"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Container(
                                            width:FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardNumber.required"),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: FlexoValues.controlsWidth,
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    selectedValue: checkoutProvider.getPaymentInfoNetBankingModel.expireMonth,
                                                    items: checkoutProvider.getPaymentInfoNetBankingModel.expireMonths.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.getPaymentInfoNetBankingModel.expireMonth = val;
                                                      });
                                                    }
                                                ),

                                                Container(
                                                  child: FlexoTextWidget().headingBoldText17(text: ' / ',),
                                                ),

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    selectedValue: checkoutProvider.getPaymentInfoNetBankingModel.expireYear,
                                                    items: checkoutProvider.getPaymentInfoNetBankingModel.expireYears.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.getPaymentInfoNetBankingModel.expireYear = val;
                                                      });
                                                    }
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardCode,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardCode.required"),
                                            ),
                                          ),

                                        ],
                                      ),
                                    )

                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.Manual"?
                                Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.selectCreditCard"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: FlexoCustomDropDown(
                                              width: FlexoValues.deviceWidth * 0.40,
                                              showRequiredIcon: false,
                                              height: FlexoValues.controlsHeight,
                                              selectedValue: checkoutProvider.manualPaymentModel.creditCardType,
                                              items: checkoutProvider.manualPaymentModel.creditCardTypes.map((e)
                                              {
                                                return DropDownModel(text: e.text, value: e.value);
                                              }).toList(),
                                              onChange: (val)
                                              {
                                                setState(()
                                                {
                                                  checkoutProvider.manualPaymentModel.creditCardType = val;
                                                });
                                              }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardHolderName,
                                              required: false,
                                              showRequiredIcon: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardHolderName.required"),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              required: false,
                                              showRequiredIcon: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardNumber.required"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width:FlexoValues.deviceWidth,
                                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            width:FlexoValues.controlsWidth,
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            alignment:Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    showRequiredIcon: false,
                                                    selectedValue: checkoutProvider.manualPaymentModel.expireMonth,
                                                    items: checkoutProvider.manualPaymentModel.expireMonths.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.manualPaymentModel.expireMonth = val;
                                                      });
                                                    }
                                                ),

                                                Container(
                                                  child: FlexoTextWidget().headingBoldText17(text: ' / ',),
                                                ),

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    showRequiredIcon: false,
                                                    selectedValue: checkoutProvider.manualPaymentModel.expireYear,
                                                    items: checkoutProvider.manualPaymentModel.expireYears.map((e)
                                                    {
                                                      return DropDownModel(text: e.text, value: e.value);
                                                    }).toList(),
                                                    onChange: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        checkoutProvider.manualPaymentModel.expireYear = val;
                                                      });
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                    Container(
                                      width: FlexoValues.deviceWidth,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.deviceWidth * 0.25,
                                              controller: cardCode,
                                              required: false,
                                              showRequiredIcon: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardCode.required"),
                                            ),
                                          ),

                                        ],
                                      ),
                                    )

                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.PayPalStandard"?
                                Column(
                                  children: [
                                    Container(
                                      width: FlexoValues.controlsWidth,
                                      child: FlexoTextWidget().headingText15(text: checkoutProvider.paypalStandardModel.redirectionTip,),
                                    ),
                                    SizedBox(height: FlexoValues.widthSpace2Px),
                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.PurchaseOrder"?
                                Column(
                                  children: [

                                    TextFieldWidget(
                                      width: FlexoValues.controlsWidth,
                                      controller: poNumber,
                                      required: false,
                                      errorMsg: localResourceProvider.getResourseByKey("plugins.payment.purchaseOrder.purchaseOrderNumber.required"),
                                      hintText: localResourceProvider.getResourseByKey("plugins.payment.purchaseOrder.purchaseOrderNumber"),
                                    ),
                                  ],
                                ):Container(),

                                checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.TwoCheckout"?
                                Column(
                                  children: [
                                    Container(
                                      width: FlexoValues.controlsWidth,
                                      child: FlexoTextWidget().headingText15(text: checkoutProvider.paypalStandardModel.redirectionTip,),
                                    ),
                                    SizedBox(height: FlexoValues.widthSpace2Px),
                                  ],
                                ):Container(),
                              ],
                            ):Container(),

                            SizedBox(height: FlexoValues.heightSpace3Px),

                            localResourceProvider.getSettingByName("orderSettings.onePageCheckoutDisplayOrderTotalsOnPaymentInfoTab")=='True'?
                           CheckoutProductsAndOrderTotal() : Container()

                          ],
                        ),

                        SizedBox(height: FlexoValues.heightSpace3Px),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              ButtonWidget().getBackButton(
                                  text: localResourceProvider.getResourseByKey("common.back").toString().toUpperCase(),
                                  width: FlexoValues.deviceWidth * 0.47,
                                  onClick: ()
                                  {
                                    checkoutProvider.paymentInfoBackButton(context: context,scrollController: widget.scrollController);
                                  },
                                  isApiLoad: false
                              ),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                                  width: FlexoValues.deviceWidth * 0.47,
                                  onClick: ()
                                  {
                                    String expireMonth = "";
                                    String expireYear = "";
                                    if(checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.AuthorizeNet" || checkoutProvider.getPaymentInfoModel.paymentMethodName=='Payments.BrainTree')
                                    {
                                      expireMonth = checkoutProvider.getPaymentInfoNetBankingModel.expireMonth;
                                      expireYear = checkoutProvider.getPaymentInfoNetBankingModel.expireYear;
                                    }else if(checkoutProvider.getPaymentInfoModel.paymentMethodName=='Payments.Manual')
                                    {
                                      expireMonth = checkoutProvider.manualPaymentModel.expireMonth;
                                      expireYear = checkoutProvider.manualPaymentModel.expireYear;
                                    }

                                    final body =''
                                        '{'
                                            '"paymentInfo":'
                                                ' {'
                                                '"CardholderName": "${cardHolderName.text.toString()}",'
                                                '"CardNumber": "${cardNumber.text.toString()}",'
                                                '"ExpireMonth": "$expireMonth",'
                                                '"ExpireYear": "$expireYear",'
                                                '"CardCode":"${cardCode.text.toString()}",'
                                                '"PurchaseOrderNumber": "${poNumber.text.toString()}"'
                                            '},'
                                        '}';

                                    checkoutProvider.paymentInfoNextButton(context: context,scrollController: widget.scrollController,body: body,isMultiCheckout: false);
                                  },
                                  isApiLoad: false
                              ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: FlexoValues.widthSpace2Px,
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
            child: IgnorePointer(
              ignoring: checkoutProvider.isAPILoader,
              child: new ExpansionTile(
                textColor: Colors.white,
                key: GlobalKey(),
                collapsedTextColor: FlexoColorConstants.DARK_TEXT_COLOR,
                backgroundColor: FlexoColorConstants.COLLAPSE_SELECTED_COLOR,
                collapsedBackgroundColor: checkoutProvider.isConfirmOrderTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
                tilePadding: EdgeInsets.zero,
                initiallyExpanded:  checkoutProvider.isConfirmOrder,
                childrenPadding: EdgeInsets.zero,
                trailing: Container(width: 0,),
                onExpansionChanged: (val)
                {
                  checkoutProvider.confirmOrderTabExpand(context: context);
                },
                leading: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        right:BorderSide(
                          color:Colors.white,
                        )
                    ),
                    color: checkoutProvider.isConfirmOrder || checkoutProvider.isConfirmOrderTabCompleted ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
                  ),

                  width: FlexoValues.deviceWidth * 0.12,
                  alignment: Alignment.center,
                  child: Text(
                    checkoutProvider.confirmOrderTabIndex,
                    style: TextStyle(
                      color: checkoutProvider.isConfirmOrder || checkoutProvider.isConfirmOrderTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                      fontSize: FlexoValues.fontSize17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                title: Container(
                    child: new Text(
                      localResourceProvider.getResourseByKey("checkout.confirmOrder"),
                      style: new TextStyle(
                        fontSize: FlexoValues.fontSize16,
                        fontWeight: FontWeight.normal,
                        color: checkoutProvider.isConfirmOrder || checkoutProvider.isConfirmOrderTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                      ),
                    )
                ),
                children: [
                  !checkoutProvider.isConfirmOrderLoad ? Container() :
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        //BillingAddress
                        Container(
                          width: FlexoValues.deviceWidth,
                          child: Container(
                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: FlexoColorConstants.LIST_BORDER_COLOR
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey( "checkout.billingAddress"),),
                                ),

                                SizedBox(height: FlexoValues.heightSpace1Px),

                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.firstName} ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.lastName}",),
                                ),
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("address.fields.email")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.email}",),
                                ),
                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.phoneEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.phoneNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.phoneNumber != "") ?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.phone")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.phoneNumber}",),
                                ) : Container(),

                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.faxEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.faxNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.faxNumber != "") ?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.shipments.fax")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.faxNumber}",),
                                ) : Container(),

                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.companyEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company != "") ?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company}",),
                                ):Container(),

                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.streetAddressEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1 != "")?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1}",),
                                ):Container(),

                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.streetAddress2Enabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2 != "" )?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2}",),
                                ) : Container(),

                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city},'}"
                                      "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName},'}"
                                      "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode}'}",),
                                ),

                                checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName != null && checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName != "")?
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName}",),
                                ):Container(),

                                Column(
                                    children: checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.customAddressAttributes.map((e){

                                      bool haveVal=true;
                                      List<AddressAttributesValues> values=[];

                                      if(e.attributeControlType==AttributeControlType.Checkboxes ||  e.attributeControlType==AttributeControlType.DropdownList || e.attributeControlType==AttributeControlType.RadioList ||e.attributeControlType==AttributeControlType.ReadonlyCheckboxes){
                                        setState((){
                                          values= e.values.where((element) => element.isPreSelected).toList();
                                        });
                                        if(values.length>0){
                                          setState((){
                                            haveVal=true;
                                          });
                                        }else{
                                          setState((){
                                            haveVal=false;
                                          });
                                        }
                                      }else if(e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox){
                                        if(e.defaultValue!=null){
                                          setState((){
                                            haveVal=true;
                                          });
                                        }else{
                                          setState((){
                                            haveVal=false;
                                          });
                                        }
                                      }
                                      return Container(
                                        width: FlexoValues.controlsWidth,
                                        child:haveVal?
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: FlexoValues.controlsWidth,
                                              child: FlexoTextWidget().headingBoldText16(text: haveVal?"${e.name}:":'',),
                                            ),

                                            e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                                            Container(
                                              width: FlexoValues.controlsWidth,
                                              child: FlexoTextWidget().headingText16(text: e.defaultValue,),
                                            ) :
                                            Container(
                                              width: FlexoValues.controlsWidth,
                                              child: Wrap(
                                                children: e.values.map((p){
                                                  return p.isPreSelected?
                                                  Container(
                                                    width: FlexoValues.controlsWidth,
                                                    child: FlexoTextWidget().headingText16(text: p.isPreSelected?p.name:'',),
                                                  ):Container();
                                                }).toList(),
                                              ),
                                            )
                                          ],
                                        ):Container(),
                                      );
                                    }).toList()
                                )

                              ],
                            ),
                          ),
                        ),

                        !checkoutProvider.getOrderSummaryModel.orderReviewData.selectedPickupInStore &&
                        !checkoutProvider.getOrderSummaryModel.orderReviewData.isShippable ? Container() :
                        Container(
                          width: FlexoValues.deviceWidth,
                          child: Container(
                            padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: FlexoColorConstants.LIST_BORDER_COLOR
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FlexoTextWidget().headingBoldText16(text: checkoutProvider.getOrderSummaryModel.orderReviewData.selectedPickupInStore ? localResourceProvider.getResourseByKey("order.pickupAddress")  : localResourceProvider.getResourseByKey("Order.ShippingAddress"),),
                                ),

                                !checkoutProvider.getOrderSummaryModel.orderReviewData.selectedPickupInStore ?
                                !checkoutProvider.getOrderSummaryModel.orderReviewData.isShippable ? Container() :
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: FlexoValues.heightSpace1Px),

                                      Container(
                                        child: FlexoTextWidget().contentText16(
                                            text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.firstName} ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.lastName}",
                                            maxLines: 10
                                        )
                                      ),

                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${localResourceProvider.getResourseByKey("address.fields.email")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.email}",
                                              maxLines: 10
                                          )
                                      ),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber != "") ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${localResourceProvider.getResourseByKey( "order.phone")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber != "") ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${localResourceProvider.getResourseByKey("order.shipments.fax")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.companyEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company != "") ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.streetAddressEnabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1 != "") ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.streetAddress2Enabled && (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != "") ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "a${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                      StatefulBuilder(
                                        builder: (context, setState)
                                        {
                                          String addressList = "";
                                          if ( (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.cityEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.city != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countyEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.county != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceName != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCodeEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode != null))
                                          {
                                            addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.city;
                                            if ((checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countyEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.county != null) ||
                                                (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceName != null) ||
                                                (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCodeEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode != null))
                                            {
                                              addressList += ",";
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countyEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.county != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.county;
                                              if ((checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceName != null) ||
                                                  (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCodeEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode != null))
                                              {
                                                addressList += ",";
                                              }
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceName != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.stateProvinceName;
                                              if (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCodeEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode != null)
                                              {
                                                addressList += ",";
                                              }
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCodeEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.zipPostalCode;
                                            }
                                          }
                                          return  Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: addressList,
                                                  maxLines: 10
                                              )
                                          );
                                        },
                                      ),

                                        checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countryEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countryName != null ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.countryName}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                        Column(
                                          children: checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.customAddressAttributes.map((e){

                                            bool haveVal=true;
                                            List<AddressAttributesValues> values=[];

                                            if(e.attributeControlType==AttributeControlType.Checkboxes ||  e.attributeControlType==AttributeControlType.DropdownList || e.attributeControlType==AttributeControlType.RadioList ||e.attributeControlType==AttributeControlType.ReadonlyCheckboxes){
                                              setState((){
                                                values= e.values.where((element) => element.isPreSelected).toList();
                                              });
                                              if(values.length>0){
                                                setState((){
                                                  haveVal=true;
                                                });
                                              }else{
                                                setState((){
                                                  haveVal=false;
                                                });
                                              }
                                            }else if(e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox){
                                              if(e.defaultValue!=null){
                                                setState((){
                                                  haveVal=true;
                                                });
                                              }else{
                                                setState((){
                                                  haveVal=false;
                                                });
                                              }
                                            }

                                            return Container(
                                              width: FlexoValues.controlsWidth,
                                              child:haveVal?
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: FlexoValues.controlsWidth,
                                                    child: FlexoTextWidget().headingBoldText16(text: haveVal?"${e.name}:":'',),
                                                  ),

                                                  e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                                                  Container(
                                                    width: FlexoValues.controlsWidth,
                                                    child: FlexoTextWidget().headingText16(text: e.defaultValue,),
                                                  ) :
                                                  Container(
                                                    width: FlexoValues.controlsWidth,
                                                    child: Wrap(
                                                      children: e.values.map((p){
                                                        return p.isPreSelected?
                                                        Container(
                                                          width: FlexoValues.controlsWidth,
                                                          child: FlexoTextWidget().headingText16(text: p.isPreSelected?p.name:'',),
                                                        ):Container();
                                                      }).toList(),
                                                    ),
                                                  )
                                                ],
                                              ):Container(),
                                            );
                                          }).toList()
                                      )

                                    ],
                                  ),
                                ) :
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.address1 != null ?
                                      Container(
                                          child: FlexoTextWidget().contentText15(
                                              text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.address1}",
                                              maxLines: 10
                                          )
                                      ) : Container(),

                                        StatefulBuilder(
                                        builder: (context, setState)
                                        {
                                          String addressList = "";
                                          if ((checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.city != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.stateProvinceName != null) ||
                                              (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode != null))
                                          {
                                            addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.city;
                                            if ((checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.county != null) ||
                                                (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.stateProvinceName != null) ||
                                                (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode != null))
                                            {
                                              addressList += ",";
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.county != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.county;
                                              if ((checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.stateProvinceName != null) ||
                                                  (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode != null))
                                              {
                                                addressList += ",";
                                              }
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.stateProvinceName != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.stateProvinceName;
                                              if (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode != null)
                                              {
                                                addressList += ",";
                                              }
                                            }
                                            if (checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode != null)
                                            {
                                              addressList += checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.zipPostalCode;
                                            }
                                          }

                                          return  Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: addressList,
                                                  maxLines: 10
                                              )
                                          );
                                        },
                                      ),

                                      checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.countryName != null ?
                                      Container(
                                          child: FlexoTextWidget().contentText16(
                                              text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.pickupAddress.countryName}",
                                              maxLines: 10
                                          )
                                      ) : Container(),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),

                        checkoutProvider.getOrderSummaryModel.orderReviewData.isShippable?
                        Container(
                          width: FlexoValues.deviceWidth,
                          child: Container(
                            padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: FlexoColorConstants.LIST_BORDER_COLOR
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("order.shipping"),),
                                ),
                                SizedBox(height: FlexoValues.heightSpace1Px),
                                Container(
                                  child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.shipping.name")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingMethod!=null ? checkoutProvider.getOrderSummaryModel.orderReviewData.shippingMethod :''}",),
                                ),

                              ],
                            ),
                          ),
                        ):Container(),

                        checkoutProvider.getOrderSummaryModel.orderReviewData.paymentMethod==null || checkoutProvider.getOrderSummaryModel.orderReviewData.paymentMethod==''?
                        Container():Container(
                            width: FlexoValues.deviceWidth,
                            padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
                            child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.progress.payment"),),
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace1Px),

                                  Container(
                                    child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.payment.method")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.paymentMethod}",),
                                  ),
                                ]
                            )
                        ),

                        CheckoutProductsAndOrderTotal(),

                        SizedBox(height: FlexoValues.widthSpace3Px),

                        (checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != null || checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != "null") && checkoutProvider.getOrderSummaryModel.termsOfServiceOnOrderConfirmPage ?
                        Container(
                          margin:EdgeInsets.all(FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: FlexoValues.switchScale,
                                child: CupertinoSwitch(
                                  onChanged: (val)
                                  {
                                    setState(()
                                    {
                                      checkoutProvider.isTermsOfServiceCheck = !checkoutProvider.isTermsOfServiceCheck;
                                    });
                                  },
                                  value: checkoutProvider.isTermsOfServiceCheck,
                                  activeColor: FlexoColorConstants.ACCENT_COLOR,
                                ),
                              ),

                              SizedBox(width: FlexoValues.widthSpace2Px),

                              Expanded(
                                child: Container(
                                  child:RichText(
                                    text: TextSpan(
                                        text: localResourceProvider.getResourseByKey("checkout.termsOfService.iAccept"),
                                        style: TextStyleWidget.contentTextStyle16,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: " "+localResourceProvider.getResourseByKey("checkout.termsOfService.read"),
                                              style: TextStyleWidget.redirectTextStyle16,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  setState(()
                                                  {
                                                    if(checkoutProvider.getOrderSummaryModel.termsOfServicePopup)
                                                    {
                                                      DialogBoxWidget().informationDialogBox(context: context, title: "${checkoutProvider.getTopicBlockModel.title}", body: "${checkoutProvider.getTopicBlockModel.body}", heading: localResourceProvider.getResourseByKey("checkout.termsOfService"));
                                                    }else{
                                                       Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetails(topicTitle: checkoutProvider.getTopicBlockModel.title,topicBody: checkoutProvider.getTopicBlockModel.body)));
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
                        ) : Container(),

                        SizedBox(height: FlexoValues.widthSpace3Px),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              ButtonWidget().getBackButton(
                                  text: localResourceProvider.getResourseByKey("common.back").toString().toUpperCase(),
                                  width: FlexoValues.deviceWidth * 0.47,
                                  onClick: ()
                                  {
                                    checkoutProvider.confirmOrderBackButton(context: context,scrollController: widget.scrollController);
                                  },
                                  isApiLoad: false
                              ),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("checkout.confirmButton").toString().toUpperCase(),
                                  width: FlexoValues.deviceWidth * 0.47,
                                  onClick: ()
                                  {
                                    if(checkoutProvider.getOrderSummaryModel.termsOfServiceOnOrderConfirmPage && !checkoutProvider.isTermsOfServiceCheck)
                                    {
                                      DialogBoxWidget().informationDialogBox(context: context, title: "", body: localResourceProvider.getResourseByKey("checkout.termsofservice.pleaseaccept"), heading: LocalResourceProvider().getResourseByKey("checkout.termsOfService"));
                                    }else{
                                      var body = "";
                                      if(!checkoutProvider.isRewardPointEnable && !checkoutProvider.paymentMethodsModel450.rewardPointsEnoughToPayForOrder)
                                      {
                                        String expireMonth = "";
                                        String expireYear = "";
                                        if(checkoutProvider.getPaymentInfoModel.paymentMethodName=="Payments.AuthorizeNet" || checkoutProvider.getPaymentInfoModel.paymentMethodName=='Payments.BrainTree')
                                        {
                                          expireMonth = checkoutProvider.getPaymentInfoNetBankingModel.expireMonth;
                                          expireYear = checkoutProvider.getPaymentInfoNetBankingModel.expireYear;
                                        }else if(checkoutProvider.getPaymentInfoModel.paymentMethodName=='Payments.Manual')
                                        {
                                          expireMonth = checkoutProvider.manualPaymentModel.expireMonth;
                                          expireYear = checkoutProvider.manualPaymentModel.expireYear;
                                        }

                                        body = ''
                                            '{'
                                            '"paymentInfo":'
                                            ' {'
                                            '"CardholderName": "${cardHolderName.text.toString()}",'
                                            '"CardNumber": "${cardNumber.text.toString()}",'
                                            '"ExpireMonth": "$expireMonth",'
                                            '"ExpireYear": "$expireYear",'
                                            '"PurchaseOrderNumber": "${poNumber.text.toString()}"'
                                            '},'
                                            ' "previousOrderGuid": "${checkoutProvider.validatePaymentInfo.orderGuid}",'
                                            '"previousOrderGuidGeneratedOnUtc": "${checkoutProvider.validatePaymentInfo.orderGuidGeneratedOnUtc}",'
                                            '}';
                                      }else{
                                        body = ''
                                            '{'
                                            '"paymentInfo":'
                                            ' {'
                                            '"CardholderName": "",'
                                            '"CardNumber": "",'
                                            '"ExpireMonth": "",'
                                            '"ExpireYear": "",'
                                            '"PurchaseOrderNumber": ""'
                                            '},'
                                            ' "previousOrderGuid": "",'
                                            '"previousOrderGuidGeneratedOnUtc": ""'
                                            '}';
                                      }
                                      checkoutProvider.confirmOrderConfirmButton(context: context,scrollController: widget.scrollController,body: body,isMultiCheckout: false);
                                    }

                                  },
                                  isApiLoad: false
                              ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: FlexoValues.widthSpace2Px,
                        )
                      ],

                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
