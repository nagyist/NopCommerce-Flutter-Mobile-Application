/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class PaymentMethodComponent extends StatefulWidget {
  final ScrollController scrollController;
  const PaymentMethodComponent({required this.scrollController});

  @override
  State<PaymentMethodComponent> createState() => _PaymentMethodComponentState();
}

class _PaymentMethodComponentState extends State<PaymentMethodComponent> {


  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return StatefulBuilder(builder: (context,setState)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
        child: IgnorePointer(
          ignoring: checkoutProvider.isAPILoader,
          child: new ExpansionTile(
            textColor: Colors.white,
            key: GlobalKey(),
            collapsedTextColor: FlexoColorConstants.DARK_TEXT_COLOR,
            backgroundColor: FlexoColorConstants.COLLAPSE_SELECTED_COLOR,
            collapsedBackgroundColor: checkoutProvider.isPaymentMethodTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            initiallyExpanded:  checkoutProvider.isPaymentMethod,
            trailing: Container(width: 0,),
            onExpansionChanged: (val)
            {
              checkoutProvider.paymentMethodTabExpand(context: context);
            },
            leading: Container(
              decoration: BoxDecoration(
                border: Border(
                    right:BorderSide(
                      color:Colors.white,
                    )
                ),
                color: checkoutProvider.isPaymentMethod || checkoutProvider.isPaymentMethodTabCompleted  ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
              ),
              width: FlexoValues.deviceWidth * 0.12,
              alignment: Alignment.center,
              child: Text(
                checkoutProvider.paymentMethodTabIndex,
                style: TextStyle(
                  color: checkoutProvider.isPaymentMethod || checkoutProvider.isPaymentMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            title: Container(
                child: new Text(
                  localResourceProvider.getResourseByKey("checkout.paymentMethod"),
                  style: new TextStyle(
                    fontSize: FlexoValues.fontSize16,
                    fontWeight: FontWeight.normal,
                    color: checkoutProvider.isPaymentMethod || checkoutProvider.isPaymentMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  ),
                )
            ),
            children: <Widget>[

              !checkoutProvider.isPaymentMethodsLoad ? Container() :
              Container(
                color: Colors.white,
                child: new Column(
                  children: [

                    SizedBox(height: FlexoValues.widthSpace2Px),

                    checkoutProvider.paymentMethodsModel450.displayRewardPoints?
                    GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          checkoutProvider.isRewardPointEnable = !checkoutProvider.isRewardPointEnable;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Container(
                                child: Icon(
                                  checkoutProvider.isRewardPointEnable ? Icons.check_box : Icons.check_box_outline_blank,
                                  color: checkoutProvider.isRewardPointEnable ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                  size: FlexoValues.iconSize20,
                                )
                            ),
                          ),

                          SizedBox(width: FlexoValues.widthSpace1Px),



                          Container(
                            width: FlexoValues.deviceWidth * 0.9,
                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("checkout.useRewardPoints").toString().replaceAll("{0}", checkoutProvider.paymentMethodsModel450.rewardPointsToUseAmount.toString()).replaceAll("{1}", checkoutProvider.paymentMethodsModel450.rewardPointsToUseAmount),),
                          ),

                          SizedBox(height: FlexoValues.widthSpace2Px),
                        ],
                      ),
                    ):Container(),

                    checkoutProvider.paymentMethodsModel450.paymentMethods.isNotEmpty?
                    Container(
                      child: Column(
                        children: checkoutProvider.paymentMethodsModel450.paymentMethods.map((e){
                          return Container(
                            width: FlexoValues.deviceWidth,
                            child: Column(
                              children: [
                                checkoutProvider.isRewardPointEnable && checkoutProvider.paymentMethodsModel450.rewardPointsEnoughToPayForOrder ? Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(() {
                                      for(var it in checkoutProvider.paymentMethodsModel450.paymentMethods)
                                      {
                                        it.selected = false;
                                      }

                                      e.selected = true;
                                      checkoutProvider.selectedPaymentMethod = e.paymentMethodSystemName;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                            )
                                        )
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: FlexoValues.deviceWidth * 0.1,
                                          height: FlexoValues.deviceWidth * 0.15,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                          child: Container(
                                              child: Icon(
                                                e.selected ? Icons.radio_button_checked : Icons.radio_button_off_outlined,
                                                color: e.selected ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                                size: FlexoValues.iconSize20,
                                              )
                                          ),

                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth * 0.9,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: FlexoValues.deviceWidth * 0.2,
                                                    child: CachedNetworkImage(
                                                      imageUrl: e.logoUrl,
                                                    ),
                                                  ),

                                                  SizedBox(width: FlexoValues.widthSpace2Px),

                                                  Container(
                                                    width: FlexoValues.deviceWidth * 0.55,
                                                    child: FlexoTextWidget().headingBoldText16(text: e.name,maxLines: 2),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: FlexoValues.heightSpace1Px),

                                              Container(
                                                width: FlexoValues.deviceWidth * 0.85,
                                                child: FlexoTextWidget().contentText15(text: e.description,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),

                          );
                        }).toList() ,
                      ),
                    ) :
                    Container(
                        width: FlexoValues.deviceWidth * 0.9,
                        alignment: Alignment.center,
                        child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("checkout.noPaymentMethods"),),
                    ),

                    SizedBox(height: FlexoValues.heightSpace2Px),

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
                                checkoutProvider.paymentMethodBackButton(context: context, scrollController: widget.scrollController);
                              },
                              isApiLoad: false
                          ),

                          ButtonWidget().getButton(
                              text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                              width: FlexoValues.deviceWidth * 0.47,
                              onClick: ()
                              {
                                checkoutProvider.uploadPaymentMethod(context: context, scrollController: widget.scrollController,isMultiCheckout: false);
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
              )
            ],
          ),
        ),
      );
    });
  }
}