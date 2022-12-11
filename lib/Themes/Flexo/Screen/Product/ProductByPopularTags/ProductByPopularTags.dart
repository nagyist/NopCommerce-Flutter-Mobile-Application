/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTagProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductsByTagModel.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:provider/provider.dart';
import 'Component/ProductByPopularTagDrawerComponent.dart';

class FlexoProductByPopularTags extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffold=new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var productByPopularTagProvider = context.watch<ProductByPopularTagProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffold,
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: productByPopularTagProvider.headerModel,headerLoader: productByPopularTagProvider.isPageLoader),
        appBar: FlexoAppBarWidget().appbar(context: context,title: productByPopularTagProvider.isPageLoader ? "" : localResourceProvider.getResourseByKey("pageTitle.productsByTag").toString().replaceAll('{0}', productByPopularTagProvider.getProductsByTagModel.tagName), backButton: true),
        drawer: ProductByPopularTagDrawerComponent().getProductByPopularTagDrawerComponent(context),
        body: productByPopularTagProvider.isPageLoader ? Loaders.pageLoader() :  Column(
          children: [
            productByPopularTagProvider.isAPILoader ? Loaders.apiLoader() : Container(),
            Expanded(
              child: Container(
                child: LazyLoadScrollView(
                  isLoading: productByPopularTagProvider.isLazyLoader,
                  onEndOfPage:(){
                    productByPopularTagProvider.loadMoreProduct(context: context);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          width: FlexoValues.deviceWidth,
                          child:  Container(
                            child: Column(
                            children: [

                              SizedBox(height: FlexoValues.widthSpace2Px,),
                              Container(
                              width: FlexoValues.deviceWidth,
                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  productByPopularTagProvider.products.isEmpty ? Container() :
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => StatefulBuilder(builder: (ctx, setState)
                                        {
                                          List<AvailableSortOption> list = productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.availableSortOptions.where((element) => element.text == productByPopularTagProvider.selectedSort).toList();
                                          if(list.isNotEmpty)
                                          {
                                            productByPopularTagProvider.selectedSortRadioGroup = int.parse(list[0].value);
                                          }
                                          return SingleChildScrollView(
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color:FlexoColorConstants.LIST_BORDER_COLOR
                                                            )
                                                        )
                                                    ),
                                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            localResourceProvider.getResourseByKey("catalog.orderBy").toString().toUpperCase(),
                                                            style: TextStyle(
                                                                color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                fontSize: FlexoValues.fontSize17,
                                                                fontWeight: FontWeight.normal
                                                            ),
                                                          ),
                                                        ),

                                                        GestureDetector(
                                                          onTap: ()
                                                          {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            child: Icon(
                                                              Ionicons.close_outline,
                                                              color:FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                              size: FlexoValues.iconSize20,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    child: Column(
                                                      children: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.availableSortOptions.map((data) {
                                                        return Container(
                                                          height:FlexoValues.heightSpace5Px,
                                                          child: RadioListTile(
                                                            title: Text(
                                                              "${data.text}",
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  color:FlexoColorConstants.DARK_TEXT_COLOR,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: FlexoValues.fontSize16
                                                              ),
                                                            ),
                                                            activeColor: FlexoColorConstants.THEME_COLOR,
                                                            groupValue: productByPopularTagProvider.selectedSortRadioGroup,
                                                            value: int.parse(data.value),
                                                            controlAffinity: ListTileControlAffinity.trailing,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                productByPopularTagProvider.selectedSort = data.text;
                                                                productByPopularTagProvider.selectedSortRadioGroup = int.parse(data.value);
                                                                Navigator.pop(context);
                                                                productByPopularTagProvider.sortByChange(val: productByPopularTagProvider.selectedSort, context: context);
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),

                                                  SizedBox(height: FlexoValues.heightSpace2Px,)
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                    child: Container(
                                      width: FlexoValues.deviceWidth * 0.47,
                                      height:FlexoValues.heightSpace5Px,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                          )
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Container(
                                            child: Text(
                                              StringConstants.SORT_BUTTON_STRING.toUpperCase(),
                                              style: TextStyle(
                                                  color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: FlexoValues.fontSize16
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: FlexoValues.widthSpace2Px,),

                                          Container(
                                            child: Icon(
                                              Ionicons.filter_outline,
                                              size: FlexoValues.iconSize20,
                                              color:FlexoColorConstants.DARK_TEXT_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
                                      scaffold.currentState!.openDrawer();
                                    },
                                    child: Container(
                                      width: FlexoValues.deviceWidth * 0.47,
                                      height:FlexoValues.heightSpace5Px,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                          )
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          Container(
                                            child: Text(
                                              StringConstants.FILTER_BUTTON_STRING.toUpperCase(),
                                              style: TextStyle(
                                                  color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:  FlexoValues.fontSize16
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: FlexoValues.widthSpace2Px,),

                                          Container(
                                            child: Icon(
                                              Ionicons.funnel_outline,
                                              size: FlexoValues.iconSize20,
                                              color: FlexoColorConstants.DARK_TEXT_COLOR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.products.isEmpty?
                            Container(
                              margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
                              child: Text(
                                localResourceProvider.getResourseByKey("catalog.products.noResult"),
                                style: TextStyle(
                                    fontSize:  FlexoValues.fontSize17,
                                    fontWeight: FontWeight.normal,
                                    color: FlexoColorConstants.DARK_TEXT_COLOR
                                  ),
                                ),
                              ):
                              Container(
                              width: FlexoValues.deviceWidth,
                              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: productByPopularTagProvider.products.map((e){
                                  return Container(
                                    child: ProductBox().getProductBox(context: context,productBoxModel: e,localResourceProvider: localResourceProvider,updateHeaderData: productByPopularTagProvider.getHeaderData),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                         ),
                        ),
                       ),

                        productByPopularTagProvider.isLazyLoader? Loaders.lazyLoader():Container()
                      ],
                    ),
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
