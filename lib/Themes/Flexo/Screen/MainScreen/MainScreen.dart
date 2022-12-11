/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Screens/Wishlist/Wishlist/Wishlist.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Badge/Badge.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Badge/BadgePositioned.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class FlexoMainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    Future<bool> handleWillPop(BuildContext context) async {

      if(homeProvider.currentTabIndex != 0)
      {
        homeProvider.changeTabIndex(newIndex: 0);
        return false;
      }else{
        SystemNavigator.pop();
        return true;
      }
    }

    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: homeProvider.homeTabs[homeProvider.currentTabIndex],
            bottomNavigationBar:Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: FlexoColorConstants.BOTTOM_NAVIGATION_BAR_BG_COLOR
                      )
                  )
              ),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    localResourceProvider.isLocalDataLoad ? Container() :
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height:
                      homeProvider.currentTabIndex == 3 && !homeProvider.isHeaderLoader ?
                      FlexoValues.deviceHeight * 0.1 :
                      0.0 ,
                      child: SingleChildScrollView(
                        child: Card(
                          color: Colors.grey.shade200,
                          margin: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: FlexoColorConstants.LIST_BORDER_COLOR,
                                width: 1
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                            ),
                          ),
                          child: Container(
                            width: FlexoValues.deviceWidth,
                            height: FlexoValues.deviceHeight * 0.1,
                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                            child: homeProvider.isHeaderLoader ? Container(): Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                GestureDetector(
                                  onTap: ()
                                  {
                                    Navigator.push(context, PageTransition(type: selectedTransition, child: Wishlist())).then((value){
                                      homeProvider.getHeaderData(context: context);
                                    });
                                  },
                                  child: Stack(
                                    fit: StackFit.loose,
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.horizontalPadding,vertical: FlexoValues.verticalPadding),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: FlexoColorConstants.LIST_BORDER_COLOR
                                            ),
                                            color: Colors.white
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Container(
                                              child: Icon(
                                                Ionicons.heart_outline,
                                                color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                size: FlexoValues.iconSize20,
                                              ),
                                            ),

                                            SizedBox(width: FlexoValues.widthSpace1Px),

                                            Container(
                                              child: Text(
                                                localResourceProvider.getResourseByKey("pageTitle.wishlist"),
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    height: 1.2,
                                                    fontWeight: FontWeight.w500,
                                                    color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                    fontSize: FlexoValues.fontSize15
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      BadgePositioned(
                                        position: BadgePosition.topEnd(),
                                        child: BottomNavigationBadge(showBadge: !homeProvider.isHeaderLoader,displayValue: homeProvider.headerModel.wishlistItems),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: SingleChildScrollView(
                        child: Container(
                          child: BottomNavigationBar(
                            iconSize: 20,
                            enableFeedback: false,
                            backgroundColor: FlexoColorConstants.BOTTOM_NAVIGATION_BAR_BG_COLOR,
                            selectedItemColor: Colors.black,
                            unselectedItemColor: Colors.grey,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            type: BottomNavigationBarType.fixed,
                            items: [
                              BottomNavigationBarItem(
                                icon: Image.asset(FlexoAssetsPath.HOME_TAB_UNSELECTED_ICON,width: FlexoValues.fontSize20,),
                                label: '',
                                tooltip: '',
                                activeIcon: Image.asset(FlexoAssetsPath.HOME_TAB_SELECTED_ICON,width: FlexoValues.fontSize20,),
                              ),
                              BottomNavigationBarItem(
                                  icon: Image.asset(FlexoAssetsPath.CATEGORY_TAB_UNSELECTED_ICON,width: FlexoValues.fontSize20,),
                                  label: '',
                                  tooltip: '',
                                  activeIcon: Image.asset(FlexoAssetsPath.CATEGORY_TAB_SELECTED_ICON,width: FlexoValues.fontSize20,),
                              ),
                              BottomNavigationBarItem(
                                  icon: Container(
                                    child: Stack(
                                      fit: StackFit.loose,
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Image.asset(FlexoAssetsPath.CART_TAB_UNSELECTED_ICON,width: FlexoValues.fontSize20,),
                                        BadgePositioned(
                                          position: BadgePosition.topEnd(),
                                          child: BottomNavigationBadge(showBadge: !homeProvider.isHeaderLoader,displayValue: homeProvider.headerModel.shoppingCartItems),
                                        ),
                                      ],
                                    ),
                                  ),
                                  label: '',
                                  tooltip: '',
                                  activeIcon:  Container(
                                    child: Stack(
                                      fit: StackFit.loose,
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Image.asset(FlexoAssetsPath.CART_TAB_SELECTED_ICON,width: FlexoValues.fontSize20,),
                                        BadgePositioned(
                                          position: BadgePosition.topEnd(),
                                          child: BottomNavigationBadge(showBadge: !homeProvider.isHeaderLoader,displayValue: homeProvider.headerModel.shoppingCartItems),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                              BottomNavigationBarItem(
                                icon: Image.asset(FlexoAssetsPath.PROFILE_TAB_UNSELECTED_ICON,width: FlexoValues.fontSize20,),
                                label: '',
                                tooltip: '',
                                activeIcon: Image.asset(FlexoAssetsPath.PROFILE_TAB_SELECTED_ICON,width: FlexoValues.fontSize20,),
                              ),
                            ],
                            currentIndex: homeProvider.currentTabIndex,
                            onTap: (index)
                            {
                              homeProvider.onTapHandler(context: context, index: index);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
