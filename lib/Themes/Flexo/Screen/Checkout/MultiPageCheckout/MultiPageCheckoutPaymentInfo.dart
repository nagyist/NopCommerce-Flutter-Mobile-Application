/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProductsAndOrderTotal.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoCustomDropDown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class FlexoMultiPageCheckoutPaymentInfo extends StatefulWidget {
  const FlexoMultiPageCheckoutPaymentInfo({Key? key}) : super(key: key);

  @override
  State<FlexoMultiPageCheckoutPaymentInfo> createState() => _FlexoMultiPageCheckoutPaymentInfoState();
}

class _FlexoMultiPageCheckoutPaymentInfoState extends State<FlexoMultiPageCheckoutPaymentInfo> {

  final ScrollController scrollController = ScrollController();
  TextEditingController cardHolderName=new TextEditingController();
  TextEditingController cardNumber=new TextEditingController();
  TextEditingController cardCode=new TextEditingController();
  TextEditingController poNumber=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.checkout"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: checkoutProvider.isPageLoader ? Loaders.pageLoader() :
        StatefulBuilder(builder: (context, setState){
          return Column(
            children: [

              checkoutProvider.isAPILoader ? Loaders.apiLoader() : Container(),

              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [

                        CheckoutProgressComponent(isShoppingCart: true, isAddress: true, isShipping: true, isPayment: true, isConfirm: false, isComplete: false, isShippable: checkoutProvider.isShippableProduct),

                        Container(
                          width: FlexoValues.controlsWidth,
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.paymentInfo").toString().toUpperCase(),maxLines: 2),
                        ),

                        Divider(
                          thickness: 1,
                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                        ),

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
                                      child: HtmlWidget(
                                        '${checkoutProvider.getPaymentInfoModel.descriptionText}',
                                        textStyle: TextStyleWidget.contentTextStyle16,
                                        onTapUrl: (url)=> launch(url),
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
                                            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardHolderName,
                                              showRequiredIcon: false,
                                              required: false,
                                              errorMsg: localResourceProvider.getResourseByKey("payment.cardHolderName.required"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:FlexoValues.deviceWidth,
                                            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),maxLines: 2),
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
                                                  child: FlexoTextWidget().headingBoldText17(text: " / ",maxLines: 2),
                                                ),

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardCode,
                                              showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardNumber,
                                              showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),maxLines: 2),
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
                                                    showRequiredIcon: false,
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
                                                  child: FlexoTextWidget().headingBoldText17(text: " / ",maxLines: 2),
                                                ),

                                                FlexoCustomDropDown(
                                                    width: FlexoValues.deviceWidth * 0.25,
                                                    height: FlexoValues.controlsHeight,
                                                    showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.3,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              controller: cardCode,
                                              showRequiredIcon: false,
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
                                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: FlexoValues.deviceWidth * 0.4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                              child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.selectCreditCard"),maxLines: 2),
                                            ),

                                            SizedBox(height: FlexoValues.widthSpace1Px),


                                            FlexoCustomDropDown(
                                                width: FlexoValues.deviceWidth * 0.40,
                                                height: FlexoValues.controlsHeight,
                                                showRequiredIcon: false,
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
                                          ],
                                        ),
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardHolderName"),maxLines: 2),
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardNumber"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            width: FlexoValues.deviceWidth,
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            child : TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              showRequiredIcon: false,
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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.expirationDate"),maxLines: 2),
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

                                                Container(child: FlexoTextWidget().headingBoldText17(text: " / ",maxLines: 2),),

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
                                            child: FlexoTextWidget().headingText14(text: localResourceProvider.getResourseByKey("payment.cardCode"),maxLines: 2),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                            alignment: Alignment.centerLeft,
                                            child: TextFieldWidget(
                                              width: FlexoValues.deviceWidth * 0.25,
                                              controller: cardCode,
                                              showRequiredIcon: false,
                                              required: false,
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
                                      child: FlexoTextWidget().headingText15(text: checkoutProvider.paypalStandardModel.redirectionTip,maxLines: 2),
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
                                      showRequiredIcon: false,
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
                                      child: FlexoTextWidget().headingText15(text: checkoutProvider.paypalStandardModel.redirectionTip,maxLines: 2),
                                    ),
                                    SizedBox(height: FlexoValues.widthSpace2Px),
                                  ],
                                ):Container(),
                              ],
                            ):Container(),

                          ],
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px),

                        ButtonWidget().getButton(
                            text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                            width: FlexoValues.controlsWidth,
                            onClick: () async
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

                              checkoutProvider.paymentInfoNextButton(context: context,scrollController: scrollController,body: body,isMultiCheckout: true);
                            },
                            isApiLoad: false
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        CheckoutProductsAndOrderTotal(),

                        SizedBox(height: FlexoValues.widthSpace2Px,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
