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
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class FlexoMultiPageCheckoutConfirmOrder extends StatefulWidget {
  var body;
  FlexoMultiPageCheckoutConfirmOrder({required this.body});

  @override
  State<FlexoMultiPageCheckoutConfirmOrder> createState() => _FlexoMultiPageCheckoutConfirmOrderState();
}

class _FlexoMultiPageCheckoutConfirmOrderState extends State<FlexoMultiPageCheckoutConfirmOrder> {
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

                        CheckoutProgressComponent(isShoppingCart: true, isAddress: true, isShipping: true, isPayment: true, isConfirm: true, isComplete: false, isShippable: checkoutProvider.isShippableProduct),

                        Container(
                          width: FlexoValues.controlsWidth,
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.confirmYourOrder").toString().toUpperCase(),maxLines: 2),
                        ),

                        Divider(
                          thickness: 1,
                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                        ),

                        Column(
                          children: [

                            checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != null && checkoutProvider.getOrderSummaryModel.warnings.length > 0 ?
                                Container(
                                  child: Column(
                                    children: [

                                      checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != null ?
                                          FlexoTextWidget().warningMessageText(text: "${checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning}"):
                                      Container(),

                                      checkoutProvider.getOrderSummaryModel.warnings.length > 0 ?
                                      Container(
                                        width: FlexoValues.deviceWidth,
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: checkoutProvider.getOrderSummaryModel.warnings.map((w){
                                                return Container(
                                                    width: FlexoValues.controlsWidth,
                                                    child: FlexoTextWidget().warningMessageText(text: w)
                                                );
                                              }).toList(),
                                            ),

                                            Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,)
                                          ],
                                        ),
                                      ) : Container(),

                                      SizedBox(height: FlexoValues.widthSpace2Px),
                                    ],
                                  ),
                                ):
                            Container(),

                            SizedBox(height: FlexoValues.widthSpace2Px),

                            //BillingAddress
                            Container(
                              width: FlexoValues.deviceWidth,
                              child: Container(
                                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: FlexoColorConstants.BORDER_COLOR
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey( "checkout.billingAddress"),maxLines: 2),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px),

                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.firstName} ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.lastName}",maxLines: 2),
                                    ),
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("address.fields.email")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.email}",maxLines: 2),
                                    ),
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey( "order.phone")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.phoneNumber}",maxLines: 2),
                                    ),
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${localResourceProvider.getResourseByKey("order.shipments.fax")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.faxNumber}",maxLines: 2),
                                    ),

                                    checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company==""?Container():
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.company}",maxLines: 2),
                                    ),

                                    checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1==""?Container():
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address1}",maxLines: 2),
                                    ),

                                    checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2==""?Container():
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.address2}",maxLines: 2),
                                    ),

                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.city},'}"
                                          "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.stateProvinceName},'}"
                                          "${(checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode =='')?"":'${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.zipPostalCode}'}",maxLines: 20),
                                    ),

                                    checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName==null || checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName==""?Container():
                                    Container(
                                      child: FlexoTextWidget().contentText16(text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.billingAddress.countryName}",maxLines: 2),
                                    ),

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

                                                SizedBox(height: FlexoValues.heightSpace1Px,),

                                                Container(
                                                  width: FlexoValues.controlsWidth,
                                                  child: FlexoTextWidget().headingBoldText16(text: haveVal?"${e.name}:":'',maxLines: 2),
                                                ),

                                                e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                                                Container(
                                                  width: FlexoValues.controlsWidth,
                                                  child: FlexoTextWidget().headingText16(text: e.defaultValue,maxLines: 2),
                                                ) :
                                                Container(
                                                  width: FlexoValues.controlsWidth,
                                                  child: Wrap(
                                                    children: e.values.map((p){
                                                      return p.isPreSelected?
                                                      Container(
                                                        width: FlexoValues.controlsWidth,
                                                        child: FlexoTextWidget().headingText16(text: p.isPreSelected?p.name:'',maxLines: 2),
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

                            Container(
                              width: FlexoValues.deviceWidth,
                              child: Container(
                                padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: FlexoColorConstants.BORDER_COLOR
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FlexoTextWidget().headingBoldText16(text: checkoutProvider.getOrderSummaryModel.orderReviewData.selectedPickupInStore ? localResourceProvider.getResourseByKey("order.pickupAddress")  : localResourceProvider.getResourseByKey("Order.ShippingAddress"),maxLines: 2),
                                    ),

                                    !checkoutProvider.getOrderSummaryModel.orderReviewData.selectedPickupInStore ?
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
                                                  maxLines : 10
                                              )
                                          ),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber != "" ?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${localResourceProvider.getResourseByKey( "order.phone")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.phoneNumber}",
                                                  maxLines: 10
                                              )
                                          ) : Container(),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber != ""?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${localResourceProvider.getResourseByKey("order.shipments.fax")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.faxNumber}",
                                                  maxLines: 10
                                              )
                                          ) : Container(),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.companyEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company != ""?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.company}",
                                                  maxLines: 10
                                              )
                                          ) : Container(),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.streetAddressEnabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1 != null  && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1 != ""?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address1}",
                                                  maxLines: 10
                                              )
                                          ) : Container(),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.streetAddress2Enabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != ""?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2}",
                                                  maxLines: 10
                                              )
                                          ) : Container(),

                                          checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.streetAddress2Enabled && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != null && checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2 != ""?
                                          Container(
                                              child: FlexoTextWidget().contentText16(
                                                  text: "${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingAddress.address2}",
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

                                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                                      Container(
                                                        width: FlexoValues.controlsWidth,
                                                        child: FlexoTextWidget().headingBoldText16(text: haveVal?"${e.name}:":'',maxLines: 2),
                                                      ),

                                                      e.attributeControlType==AttributeControlType.TextBox || e.attributeControlType==AttributeControlType.MultilineTextbox?
                                                      Container(
                                                        width: FlexoValues.controlsWidth,
                                                        child: FlexoTextWidget().headingText16(text: e.defaultValue,maxLines: 2),
                                                      ) :
                                                      Container(
                                                        width: FlexoValues.controlsWidth,
                                                        child: Wrap(
                                                          children: e.values.map((p){
                                                            return p.isPreSelected?
                                                            Container(
                                                              width: FlexoValues.controlsWidth,
                                                              child: FlexoTextWidget().headingText16(text: p.isPreSelected?p.name:'',maxLines: 2),
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
                                              child: FlexoTextWidget().contentText16(
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

                            SizedBox(height: FlexoValues.heightSpace1Px),

                            checkoutProvider.getOrderSummaryModel.orderReviewData.isShippable?
                            Container(
                              width: FlexoValues.deviceWidth,
                              child: Container(
                                padding:  EdgeInsets.all(FlexoValues.widthSpace2Px),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: FlexoColorConstants.BORDER_COLOR
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("order.shipping"),maxLines: 2),
                                    ),
                                    SizedBox(height: FlexoValues.heightSpace1Px),
                                    Container(
                                      child: FlexoTextWidget().headingText16(text: "${localResourceProvider.getResourseByKey("order.shipping.name")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.shippingMethod!=null ? checkoutProvider.getOrderSummaryModel.orderReviewData.shippingMethod :''}",maxLines: 2),
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
                                        child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.progress.payment"),maxLines: 2),
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace1Px),

                                      Container(
                                        child: FlexoTextWidget().headingText16(text: "${localResourceProvider.getResourseByKey("order.payment.method")}: ${checkoutProvider.getOrderSummaryModel.orderReviewData.paymentMethod}",maxLines: 2),
                                      ),

                                      SizedBox(
                                        height: FlexoValues.widthSpace2Px,
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
                                            style: TextStyleWidget.contentTextStyle15,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: " "+localResourceProvider.getResourseByKey("checkout.termsOfService.read"),
                                                  style: TextStyleWidget.redirectTextStyle15,
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

                          ],
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px),

                        (checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != null || checkoutProvider.getOrderSummaryModel.minOrderSubtotalWarning != "null") && checkoutProvider.getOrderSummaryModel.termsOfServiceOnOrderConfirmPage ?
                        ButtonWidget().getButton(
                            text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                            width: FlexoValues.controlsWidth,
                            onClick: () async
                            {
                              checkoutProvider.confirmOrderConfirmButton(context: context,scrollController: scrollController,body: widget.body,isMultiCheckout: true);
                            },
                            isApiLoad: false
                        ) : Container(),

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

