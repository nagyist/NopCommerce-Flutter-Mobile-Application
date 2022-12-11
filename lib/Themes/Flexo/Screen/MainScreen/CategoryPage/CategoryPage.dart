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
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'Components/CategoryComponent.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("menu"), backButton: false),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      body: homeProvider.isTopMenuLoader || localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :  SingleChildScrollView(
        controller: homeProvider.categoryScrollController,
        child: Column(
          children: [

            SizedBox(height: FlexoValues.heightSpace1Px,),

            homeProvider.isTopMenuLoader ? Container() :
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: FlexoColorConstants.LIST_BORDER_COLOR
                  ),
              ),
              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.heightSpace1Px),
              child: Column(
                children: [

                  Theme(
                    data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("NopAdvance.plugin.PublicApi.DefaultClean.ShopByCategory"),maxLines: 1),
                      initiallyExpanded: homeProvider.isExpandCategory,
                      onExpansionChanged: (val){
                          homeProvider.changeCategoryStatus();
                          if(!homeProvider.isExpandCategory){
                            for(var i in homeProvider.getTopMenuModel.categories){
                              homeProvider.changeExpandListStatus(listId: i.id,status: false);
                            }
                          }
                      },
                      trailing:
                      Icon(homeProvider.isExpandCategory?Ionicons.caret_up_outline: Ionicons.caret_down_outline,
                        color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                        size: FlexoValues.iconSize18,
                      ),
                      children: [

                        Container(
                          child: Column(
                            children: homeProvider.getTopMenuModel.categories.map((p) {
                              if(homeProvider.categoryExpandList[p.id]==null){
                                homeProvider.initialExpandListStatus(listId: p.id,status: false);
                              }
                              return Container(
                                child: p.haveSubCategories ?
                                Container(
                                  child: Column(
                                    children: [
                                      Divider(thickness: 1,height: CheckDeviceType().isTab() ? FlexoValues.heightSpace1Px : 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: homeProvider.categoryExpandList[p.id]! ? FlexoValues.heightSpace1Px : 0),
                                        child: Theme(
                                          data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            maintainState: true,
                                            backgroundColor: Colors.grey.shade200,
                                            title: FlexoTextWidget().headingText16(text: p.name,maxLines: 1),
                                            onExpansionChanged: (val){
                                              homeProvider.changeExpandListStatus(listId: p.id,status: val);
                                            },
                                            trailing:  Icon(
                                              homeProvider.categoryExpandList[p.id]!? Ionicons.caret_up_outline : Ionicons.caret_down_outline,
                                              color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                                              size: FlexoValues.iconSize18,
                                            ),
                                            children: p.subCategories.map((c) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Divider(thickness: 1,height: CheckDeviceType().isTab() ? FlexoValues.heightSpace1Px : 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                                                    Container(
                                                      color: Colors.grey.shade100,
                                                      child: ListTile(
                                                        title: FlexoTextWidget().headingText16(text: c.name,maxLines: 1),
                                                        onTap: () {

                                                          Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: c.id)));

                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) :
                                Column(
                                  children: [

                                    Divider(thickness: 1,height: CheckDeviceType().isTab() ? FlexoValues.heightSpace1Px : 1,color: FlexoColorConstants.LIST_BORDER_COLOR,),

                                    Container(
                                      child: ListTile(
                                        title: FlexoTextWidget().headingText16(text: p.name,maxLines: 1),
                                        onTap: () {

                                          Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: p.id)));

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(thickness: 1,height: FlexoValues.heightSpace1Px,color: FlexoColorConstants.LIST_BORDER_COLOR,),

            CategoryComponent().getCategoryComponent(context: context),
          ],
        ),
      ),
    );
  }
}
