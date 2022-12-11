/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetails.dart';
import 'package:nopcommerce/Screens/Customer/OrderConfirmPage/OrderConfirmPageProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class FlexoMultiPageCheckoutCompleteOrder extends StatelessWidget {
  const FlexoMultiPageCheckoutCompleteOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderConfirmPageProvider = context.watch<OrderConfirmPageProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.checkout"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: orderConfirmPageProvider.isPageLoader ? Loaders.pageLoader() :
        StatefulBuilder(builder: (context, setState){
          return Column(
            children: [

              orderConfirmPageProvider.isAPILoader ? Loaders.apiLoader() : Container(),

              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(height: FlexoValues.widthSpace4Px),

                        Container(
                          child: FlexoTextWidget().headingBoldText17(text: localResourceProvider.getResourseByKey("checkout.thankYou"),maxLines: 2),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        Container(
                          child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("checkout.yourOrderHasBeenSuccessFullyProcessed"),maxLines: 2),
                        ),

                        SizedBox(height: FlexoValues.deviceWidth * 0.1),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  '${localResourceProvider.getResourseByKey("account.customerOrders.orderNumber")}: ${orderConfirmPageProvider.getOrderDetailsModel.customOrderNumber}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: FlexoValues.fontSize16,
                                      color:Colors.black
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: orderConfirmPageProvider.getOrderDetailsModel.id)));
                          },
                          child: Container(
                            child: Text(
                              localResourceProvider.getResourseByKey("checkout.placedOrderDetails"),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: FlexoColorConstants.HIGHLIGHT_COLOR,
                                  fontSize: FlexoValues.fontSize16
                              ),),
                          ),
                        ),

                        SizedBox(height: FlexoValues.deviceWidth * 0.07),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0,)));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace5Px),
                                  height: FlexoValues.controlsHeight,
                                  color: FlexoColorConstants.BUTTON_COLOR,
                                  alignment: Alignment.center,
                                  child: Text(
                                    localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style:TextStyle(
                                        color: Colors.white,
                                        fontSize: FlexoValues.fontSize17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

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
