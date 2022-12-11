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
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class FlexoOrderConfirmPage extends StatelessWidget {
  const FlexoOrderConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var orderConfirmPageProvider = context.watch<OrderConfirmPageProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("checkout.confirmorder"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: orderConfirmPageProvider.headerModel,headerLoader: orderConfirmPageProvider.isPageLoader),
        body: orderConfirmPageProvider.isPageLoader ? Loaders.pageLoader() :
        Column(
          children: [

            orderConfirmPageProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      SizedBox(height: FlexoValues.widthSpace4Px),

                      Container(
                        child: FlexoTextWidget().headingBoldText17(text: localResourceProvider.getResourseByKey("checkout.thankyou"),),
                      ),

                      SizedBox(height: FlexoValues.widthSpace2Px),

                      Container(
                        child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("checkout.yourorderhasbeensuccessfullyprocessed"),),
                      ),

                      SizedBox(height: FlexoValues.deviceWidth * 0.1),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: FlexoTextWidget().headingText16(text: '${localResourceProvider.getResourseByKey("account.customerorders.ordernumber")}: ${orderConfirmPageProvider.getOrderDetailsModel.customOrderNumber}',),
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
                          child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("checkout.placedorderdetails")),
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
                                alignment: Alignment.center,
                                height: FlexoValues.controlsHeight,
                                color: FlexoColorConstants.BUTTON_COLOR,
                                child: FlexoTextWidget().buttonText(text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),maxLines: 1)
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
        ),
      ),
    );
  }
}
