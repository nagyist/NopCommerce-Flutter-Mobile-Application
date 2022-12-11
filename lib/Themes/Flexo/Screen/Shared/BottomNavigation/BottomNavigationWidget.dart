/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Badge/Badge.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Badge/BadgePositioned.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Screens/Shared/BottomNavigationProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';

class FlexoBottomNavigationWidget {
  bottomNavigation({required BuildContext context,required String tabIndexType, required var headerData,required bool headerLoader})
  {
    context.read<BottomNavigationProvider>().loadBottomNavigationData(context: context,headerData: headerData,headerLoader: headerLoader);
    var bottomNavigationProvider = context.watch<BottomNavigationProvider>();

    switch(tabIndexType) {
      case BottomNavigationIndexType.Home:
        bottomNavigationProvider.tabIndex = 0;
        break;

      case BottomNavigationIndexType.Category:
        bottomNavigationProvider.tabIndex = 1;
        break;

      case BottomNavigationIndexType.Cart:
        bottomNavigationProvider.tabIndex = 2;
        break;

      case BottomNavigationIndexType.Profile:
        bottomNavigationProvider.tabIndex = 3;
        break;

      case BottomNavigationIndexType.Other:
        bottomNavigationProvider.tabIndex = 0;
        break;
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child:
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: FlexoColorConstants.BOTTOM_NAVIGATION_BAR_BORDER_COLOR
                          )
                      )
                  ),
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
                        icon: Image.asset(FlexoAssetsPath.HOME_TAB_UNSELECTED_ICON,width:FlexoValues.iconSize20,),
                        label: '',
                        tooltip: '',
                        activeIcon: Image.asset(FlexoAssetsPath.HOME_TAB_SELECTED_ICON,width:FlexoValues.iconSize20,),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(FlexoAssetsPath.CATEGORY_TAB_UNSELECTED_ICON,width:FlexoValues.iconSize20,),
                        label: '',
                        tooltip: '',
                        activeIcon: Image.asset(FlexoAssetsPath.CATEGORY_TAB_SELECTED_ICON,width:FlexoValues.iconSize20,),
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
                                child: BottomNavigationBadge(showBadge: !bottomNavigationProvider.isHeaderLoader,displayValue: bottomNavigationProvider.headerModel.shoppingCartItems),
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
                                child: BottomNavigationBadge(showBadge: !bottomNavigationProvider.isHeaderLoader,displayValue: bottomNavigationProvider.headerModel.shoppingCartItems),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(FlexoAssetsPath.PROFILE_TAB_UNSELECTED_ICON,width: FlexoValues.iconSize20,),
                        label: '',
                        tooltip: '',
                        activeIcon: Image.asset(FlexoAssetsPath.PROFILE_TAB_SELECTED_ICON,width: FlexoValues.iconSize20,),
                      ),
                    ],
                    currentIndex: bottomNavigationProvider.tabIndex,
                    onTap: (index)
                    {
                      if(index == 0)
                      {
                        Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 0)));
                      }else if(index == 1)
                      {
                        Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 1)));
                      }else if(index == 2)
                      {
                        Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 2)));
                      }else if(index == 3)
                      {
                        Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 3)));
                      }
                    },
                  ),
                ),
              )

          ),

        ],
      ),
    );
  }
}