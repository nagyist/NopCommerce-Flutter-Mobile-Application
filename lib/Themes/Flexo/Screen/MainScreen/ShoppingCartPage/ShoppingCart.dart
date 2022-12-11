/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'Component/ShoppingCartContentComponent.dart';
import 'Component/ShoppingCartCrossSellProductComponent.dart';
import 'Component/ShoppingCartProductListComponent.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.shoppingCart"), backButton: false),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      body: homeProvider.isTopMenuLoader ? Loaders.pageLoader() :
      localResourceProvider.isLocalDataLoad? Loaders.pageLoader() :
      homeProvider.isCartLoader?
      Loaders.pageLoader() :
      homeProvider.getCartModel != null && homeProvider.getCartModel.items.length==0 ?
      Container(
          height: FlexoValues.deviceHeight,
          width: FlexoValues.deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.horizontalPadding,vertical: FlexoValues.verticalPadding),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  width: FlexoValues.deviceWidth * 0.3,
                  child: Image.asset(FlexoAssetsPath.EMPTY_CART),
                ),

                SizedBox(height: FlexoValues.heightSpace3Px,),

                Container(
                  child: FlexoTextWidget().contentText17(text: localResourceProvider.getResourseByKey("shoppingCart.CartIsEmpty"),),
                ),

                SizedBox(height: FlexoValues.heightSpace5Px,),

                ButtonWidget().getButton(
                    text: localResourceProvider.getResourseByKey("ShoppingCart.ContinueShopping").toString().toUpperCase(),
                    width: FlexoValues.controlsWidth,
                    onClick: ()
                    {
                      homeProvider.changeTabIndex(newIndex: 0);
                    },
                    isApiLoad: false
                ),

              ],
            ),
          )
      ) :
      Container(
        child: Column(
          children: [

            homeProvider.isCartDataRefresh ? Loaders.apiLoader() : Container(),

            localResourceProvider.isLocalDataLoad && homeProvider.isCartLoader ? Container() :

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  controller: homeProvider.cartScrollController,
                  child: Column(
                    children: [
                      localResourceProvider.getSettingByName("OrderSettings.OnePageCheckOutEnabled")=='False'?
                      CheckoutProgressComponent(isShoppingCart: true, isAddress: false, isShipping: false, isPayment: false, isConfirm: false, isComplete: false, isShippable: false) : Container(),

                      ShoppingCartProductListComponent().getShoppingCartProductListComponent(context: context),

                      homeProvider.orderTotalResponseModel == null ? Container() :
                      ShoppingCartContentComponent().getShoppingCartContentComponent(context: context),

                      homeProvider.crossSellProduct.length > 0 ?
                      ShoppingCartCrossSellProductComponent().getCrossSellProduct(context: context):
                      Container()
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
