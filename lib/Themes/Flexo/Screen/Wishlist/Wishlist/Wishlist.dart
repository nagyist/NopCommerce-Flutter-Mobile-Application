/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Wishlist/Wishlist/WishlistProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'Component/WishlistContentComponent.dart';
import 'Component/WishlistProductsComponent.dart';

class FlexoWishlist extends StatelessWidget {
  const FlexoWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var wishlistProvider = context.watch<WishlistProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.wishlist"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: wishlistProvider.headerModel,headerLoader: wishlistProvider.isPageLoader),
        body: wishlistProvider.isPageLoader ? Loaders.pageLoader() :
        Column(
          children: [

            wishlistProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            wishlistProvider.wishlistModel.items.length == 0 ?
            Expanded(
              child: Container(
                 height: FlexoValues.deviceHeight,
                  width: FlexoValues.deviceWidth,
                 padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.heightSpace2Px),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        width: FlexoValues.deviceWidth * 0.3,
                        child: Image.asset(FlexoAssetsPath.EMPTY_WISHLIST),
                      ),

                      SizedBox(height: FlexoValues.heightSpace3Px),

                      Container(
                        child:FlexoTextWidget().contentText16(
                            text: localResourceProvider.getResourseByKey("wishlist.cartIsEmpty")
                        ),
                      ),
                    ],
                  )
              ),
            ):
            Expanded(
              child: localResourceProvider.isLocalDataLoad ? Container() :Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      WishlistContentComponent().getWishlistContentComponent(context: context),

                      WishlistProductsComponent().getWishlistProductListComponent(context: context),

                      SizedBox(height: FlexoValues.heightSpace2Px),

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
