/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Screens/Catalog/SearchProducts/SearchProducts.dart';
import 'package:nopcommerce/Screens/Customer/GiftCardBalance/GiftCardBalance.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/ContactUs/ContactUs.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetailsById/TopicBlockDetailsById.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/CompareProduct.dart';
import 'package:nopcommerce/Screens/Products/NewProducts/NewProducts.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TopicType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';

class CategoryComponent{
  int selected=-1;
  bool isExpandCategory=false;

  HeaderInfoResponseModel headerModel = new HeaderInfoResponseModel(
      isAuthenticated: false,
      customerName: "",
      shoppingCartEnabled: false,
      shoppingCartItems: 0,
      wishlistEnabled: false,
      wishlistItems: 0,
      allowPrivateMessages: false,
      unreadPrivateMessages: "",
      alertMessage: "",
      registrationType: "",
      customProperties: CustomProperties()
  );


  getCategoryComponent({required BuildContext context})
  {
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [


            homeProvider.getTopMenuModel.displayProductSearchMenuItem ?
            categoryItem(
                context: context,
                title: localResourceProvider.getResourseByKey('search'),
                icon: Ionicons.search_outline,
                onTap: () {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: SearchProducts(searchTerms: "",isAppBarSearch: false,)));
                }
            ) : Container(),


            homeProvider.getTopMenuModel.topics.length > 0 ?
            Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: homeProvider.getTopMenuModel.topics.map((e) {
                        return Container(
                          child: categoryItem(
                              context: context,
                              title: e.name == null ? "" : e.name,
                              icon: Ionicons.folder_open_outline,
                              onTap: () {
                                Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetailsById(name: e.name,seName: e.seName,topicId: e.id,topicType: TopicType.Id)));
                              }
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ) : Container(),

            homeProvider.getTopMenuModel.newProductsEnabled && homeProvider.getTopMenuModel.displayNewProductsMenuItem ?
            categoryItem(
                context: context,
                title: localResourceProvider.getResourseByKey('products.newProducts'),
                icon: Ionicons.bag_outline,
                onTap: () {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: NewProducts()));
                }
            ):Container(),

            localResourceProvider.getSettingByName("CustomerSettings.AllowCustomersTocCheckGiftCardBalance")=='True'?
            categoryItem(
                context: context,
                title: localResourceProvider.getResourseByKey('pageTitle.checkGiftCardBalance'),
                icon: Ionicons.gift_outline,
                onTap: () {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: GiftCardBalance()));
                }
            ):Container(),

            homeProvider.getTopMenuModel.displayContactUsMenuItem ?
            categoryItem(
                context: context,
                title: localResourceProvider.getResourseByKey('contactus'),
                icon: Ionicons.call_outline,
                onTap: () {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: ContactUs()));
                }
            ): Container(),

            categoryItem(
                context: context,
                title: localResourceProvider.getResourseByKey('products.compare.list'),
                icon: Ionicons.git_compare_outline,
                onTap: () {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: CompareProduct()));
                }
            ),
          ],
        ),
      ),
    );
  }

  categoryItem({required BuildContext context ,required String title, required IconData icon, required Function() onTap})
  {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: Container(
              child: Icon(
                icon,
                color: FlexoColorConstants.DRAWER_ICON_COLOR,
                size: FlexoValues.fontSize18
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff2f2f2)
              ),
              height: FlexoValues.deviceWidth * 0.1,
              width: FlexoValues.deviceWidth * 0.1,
            ),
            title: FlexoTextWidget().menuItemText(text: title,maxLines: 1),
            onTap: onTap,
          ),
        ),

        Divider(thickness: 1,height: FlexoValues.heightSpace1Px,color: FlexoColorConstants.LIST_BORDER_COLOR,),
      ],
    );
  }
}