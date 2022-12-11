/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProductsAndOrderTotal.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class FlexoMultiPageCheckoutPaymentMethod extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

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
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.selectPaymentMethod").toString().toUpperCase(),maxLines: 2),
                        ),

                        Divider(
                          thickness: 1,
                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                        ),

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
                                child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("checkout.useRewardPoints").toString().replaceAll("{0}", checkoutProvider.paymentMethodsModel450.rewardPointsToUseAmount.toString()).replaceAll("{1}", checkoutProvider.paymentMethodsModel450.rewardPointsToUseAmount),maxLines: 2),
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
                                                    child: FlexoTextWidget().contentText15(text: e.description,maxLines: 2),
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
                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("checkout.noPaymentMethods"),maxLines: 2),
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px),

                        ButtonWidget().getButton(
                            text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                            width: FlexoValues.controlsWidth,
                            onClick: () async
                            {
                              checkoutProvider.uploadPaymentMethod(context: context, scrollController: scrollController,isMultiCheckout: true);
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
