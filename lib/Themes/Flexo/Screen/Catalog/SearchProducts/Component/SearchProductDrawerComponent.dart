/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Screens/Catalog/SearchProducts/SearchProductsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTag.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/PopularTag.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class SearchProductDrawerComponent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  SearchProductDrawerComponent({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var searchProductsProvider = context.watch<SearchProductsProvider>();

    return StatefulBuilder(builder: (context,setState){
      return SafeArea(
        child: Container(
          height: FlexoValues.deviceHeight,
          width: FlexoValues.deviceWidth,
          child: Scaffold(
            appBar: FlexoAppBarWidget().appbar(context: context,title: StringConstants.FILTER_DRAWER_HEADER, backButton: true,actions: [
              searchProductsProvider.searchProductModel.availableCategories.where((element) => element.selected).isEmpty &&
              (searchProductsProvider.currentRangeValues.start == searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from || searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from == null)
                  && (searchProductsProvider.currentRangeValues.end == searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to || searchProductsProvider.maxPrice == 10000000 || searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to == null)
                  ? Container() :
                  searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.enabled ||
                  searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.enabled ?
              GestureDetector(
                onTap: (){
                  searchProductsProvider.clearAttributes(context: context);
                },
                child: Container(
                  height: FlexoValues.deviceWidth * 0.1,
                  width: FlexoValues.deviceWidth * 0.1,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child: Image.asset(FlexoAssetsPath.CLEAR_ICON),
                ),
              ):Container(),
            ]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: FlexoColorConstants.LIST_BORDER_COLOR
                      )
                  )
              ),
              height: searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.enabled || searchProductsProvider.searchProductModel.catalogProductsModel.manufacturerFilter.enabled || searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.enabled ? FlexoValues.controlsHeight + FlexoValues.widthSpace4Px : 0,
              child: searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.enabled || searchProductsProvider.searchProductModel.catalogProductsModel.manufacturerFilter.enabled || searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.enabled ?
              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    ButtonWidget().getButton(
                        text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.selectShippingOption.button"),
                        width: FlexoValues.deviceWidth * 0.3,
                        onClick: ()async
                        {
                          if(await CheckConnectivity().checkInternet(context))
                          {
                            scaffoldKey.currentState!.openEndDrawer();
                            KeyboardUtil.hideKeyboard(context);
                            searchProductsProvider.searchButtonClick(context: context,searchTerms: searchProductsProvider.searchProductModel.q);
                          }
                        },
                        isApiLoad: false
                    ),
                  ],
                ),
              ):Container(),
            ),
            body: Container(
              child: Column(
                children: [

                  searchProductsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

                  Expanded(
                    child: Container(
                      width: FlexoValues.deviceWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR
                            ),
                            width: FlexoValues.deviceWidth * 0.4,
                            child: Column(
                              children: [

                                searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      searchProductsProvider.selectedAttribute = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: searchProductsProvider.selectedAttribute == 0 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.priceRangeFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: searchProductsProvider.selectedAttribute == 0 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      searchProductsProvider.selectedAttribute = 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: searchProductsProvider.selectedAttribute == 1 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.specificationFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: searchProductsProvider.selectedAttribute == 1 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                searchProductsProvider.searchProductModel.catalogProductsModel.manufacturerFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      searchProductsProvider.selectedAttribute = 2;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: searchProductsProvider.selectedAttribute == 2 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.manufacturerFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: searchProductsProvider.selectedAttribute == 2 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                searchProductsProvider.getCatalogRootModel==null || searchProductsProvider.getCatalogRootModel.isEmpty?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      searchProductsProvider.selectedAttribute = 3;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: searchProductsProvider.selectedAttribute == 3 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("categories"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: searchProductsProvider.selectedAttribute == 3 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ),

                                searchProductsProvider.getPopularProductTagsModel==null?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      searchProductsProvider.selectedAttribute = 4;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: searchProductsProvider.selectedAttribute == 4 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("products.tags.popular"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: searchProductsProvider.selectedAttribute == 4 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SingleChildScrollView(
                            child: Container(
                              width: FlexoValues.deviceWidth * 0.6,
                              child: Column(
                                children: [

                                  searchProductsProvider.selectedAttribute == 0 ?
                                  searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.enabled?
                                  Column(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth * 06,
                                        child: RangeSlider(
                                          min: searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from,
                                          max: searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to,
                                          values: searchProductsProvider.currentRangeValues,
                                          activeColor: FlexoColorConstants.ACCENT_COLOR,
                                          divisions: searchProductsProvider.searchProductModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to.toInt(),
                                          onChanged: (RangeValues values){
                                            setState(() {
                                              searchProductsProvider.currentRangeValues = values;
                                            });
                                          },
                                        ),
                                      ),

                                      Container(
                                        width: FlexoValues.deviceWidth * 0.6,
                                        padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace3Px),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                searchProductsProvider.currentRangeValues.start.round().toString(),
                                                style: TextStyle(
                                                    fontSize: FlexoValues.fontSize15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                searchProductsProvider.currentRangeValues.end.round().toString(),
                                                style: TextStyle(
                                                    fontSize: FlexoValues.fontSize15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ):
                                  Container():
                                  Container(),

                                  searchProductsProvider.selectedAttribute == 1 ?
                                  searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.enabled?
                                  Container(
                                    child: Column(
                                      children: searchProductsProvider.searchProductModel.catalogProductsModel.specificationFilter.attributes.map((e){

                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                  child: Text(
                                                    e.name,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize:FlexoValues.fontSize16,
                                                        color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  child: Column(
                                                    children: e.values.map((p){
                                                      int selectedColor=0;
                                                      if(p.colorSquaresRgb!=null){
                                                        String color=p.colorSquaresRgb;
                                                        selectedColor=int.parse(color.replaceAll('#', '0xff'));
                                                      }
                                                      return Container(
                                                        width: FlexoValues.deviceWidth * 0.6,
                                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [

                                                                GestureDetector(
                                                                  onTap: ()
                                                                  {
                                                                    setState(() {
                                                                      p.selected = !p.selected;
                                                                    });
                                                                  },
                                                                  child: Container(
                                                                      child: Icon(
                                                                        p.selected ? Icons.check_box : Icons.check_box_outline_blank,
                                                                        color: p.selected ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                                                        size: FlexoValues.fontSize20,
                                                                      )
                                                                  ),
                                                                ),

                                                                SizedBox(width: FlexoValues.widthSpace2Px),

                                                                p.colorSquaresRgb==null?Container():
                                                                GestureDetector(
                                                                  onTap: ()
                                                                  {
                                                                    setState(() {
                                                                      p.selected = !p.selected;
                                                                    });
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        height: FlexoValues.widthSpace5Px,
                                                                        width: FlexoValues.widthSpace5Px,
                                                                        color:  Color(selectedColor),
                                                                      ),
                                                                      SizedBox(width: FlexoValues.widthSpace2Px),
                                                                    ],
                                                                  ),
                                                                ),

                                                                Flexible(
                                                                  child: GestureDetector(
                                                                    onTap: ()
                                                                    {
                                                                      setState(() {
                                                                        p.selected = !p.selected;
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      child: Text(
                                                                        p.name,
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize: FlexoValues.fontSize16,
                                                                            color: FlexoColorConstants.DARK_TEXT_COLOR
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ) :
                                  Container():
                                  Container(),

                                  searchProductsProvider.selectedAttribute == 2 ?
                                  searchProductsProvider.searchProductModel.catalogProductsModel.manufacturerFilter.enabled?
                                  Container(
                                    child: Column(
                                      children: searchProductsProvider.searchProductModel.catalogProductsModel.manufacturerFilter.manufacturers.map((e){

                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        e.selected = !e.selected;
                                                      });
                                                    },
                                                    child: Container(
                                                        child: Icon(
                                                          e.selected ? Icons.check_box : Icons.check_box_outline_blank,
                                                          color: e.selected ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                                          size: FlexoValues.fontSize20,
                                                        )
                                                    ),
                                                  ),

                                                  SizedBox(width: FlexoValues.widthSpace2Px),

                                                  Flexible(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          e.selected = !e.selected;
                                                        });
                                                      },
                                                      child: Container(
                                                        child: Text(
                                                          e.text,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: FlexoValues.fontSize15,
                                                              color: FlexoColorConstants.DARK_TEXT_COLOR
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ) :
                                  Container() :
                                  Container(),

                                  searchProductsProvider.selectedAttribute == 3 ?
                                  Container(
                                    width: FlexoValues.deviceWidth * 0.6,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: searchProductsProvider.getCatalogRootModel.map((e){

                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: e.id)));
                                            scaffoldKey.currentState!.openEndDrawer();
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: FlexoValues.fontSize12,
                                                    color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                  ),
                                                ),

                                                Flexible(
                                                  child: Container(
                                                    child: Text(
                                                      "${e.name}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          height: 1,
                                                          fontSize: FlexoValues.fontSize15,
                                                          color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                          fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ) : Container(),

                                  searchProductsProvider.selectedAttribute == 4 ?
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Wrap(
                                            children: searchProductsProvider.getPopularProductTagsModel.tags.map((e){
                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByPopularTag(tagId: e.id,tagName: e.name)));
                                                  scaffoldKey.currentState!.openEndDrawer();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                                  child: Text(
                                                    e.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: e.productCount > 15 ? FlexoValues.fontSize17 : FlexoValues.fontSize15,
                                                        color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                        fontWeight: e.productCount>15? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth * 0.6,
                                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, PageTransition(type: selectedTransition, child: PopularTag()));
                                              scaffoldKey.currentState!.openEndDrawer();
                                            },
                                            child: Text(
                                              localResourceProvider.getResourseByKey("products.tags.popular.viewAll"),
                                              style: TextStyleWidget.redirectTextStyle16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : Container(),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
