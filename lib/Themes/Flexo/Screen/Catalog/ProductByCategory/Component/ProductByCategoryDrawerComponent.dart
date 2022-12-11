/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/GetCatalogRootModel.dart';
import 'package:nopcommerce/Models/GetPopularProductTagsModel.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/Model/GetCategoryResponseModel.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTag.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/PopularTag.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/CheckboxWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductByCategoryDrawerComponent{

  getProductByCategoryDrawerComponent({
    required BuildContext context,
    required StateSetter setState,
    required bool isApiLoader,
    required int pageNumber,
    required GetCategoryResponseModel getCategoryResponseModel,
    required categoryProductMethod,
    required int selectedAttribute,
    required List<GetCatalogRootModel> getCatalogRootModel,
    required GetPopularProductTagsModel getPopularProductTagsModel,
    required RangeValues currentRangeValues,
    required prepareData,
    required clearAttributes,
    required GlobalKey<ScaffoldState> scaffold,
  })
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return StatefulBuilder(builder: (context,setState){
      List<int> specsList = [];
      for(var item in getCategoryResponseModel.catalogProductsModel.specificationFilter.attributes)
      {
        for(var it in item.values.where((element) => element.selected))
        {
          specsList.add(it.id);
        }
      }

      return SafeArea(
        child: Container(
          height: FlexoValues.deviceHeight,
          width: FlexoValues.deviceWidth,
          child: Scaffold(
            appBar: FlexoAppBarWidget().appbar(context: context,title: StringConstants.FILTER_DRAWER_HEADER, backButton: true,actions: [
              specsList.isEmpty &&
              (currentRangeValues.start == getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from || getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from == null)
              && (currentRangeValues.end == getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to || currentRangeValues.end == 10000000 || getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to == null) ? Container() :
              getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled || getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled ?

              GestureDetector(
                onTap: () {
                  clearAttributes();
                },
                child: Container(
                  height:FlexoValues.deviceWidth * 0.1,
                  width: FlexoValues.deviceWidth * 0.1,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px),
                  child: Image.asset(FlexoAssetsPath.CLEAR_ICON),
                ),
              ):Container()
            ]),
            bottomNavigationBar: Container(
              height:  getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled || getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled ? FlexoValues.deviceHeight * 0.07 + FlexoValues.widthSpace4Px: 0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:FlexoColorConstants.LIST_BORDER_COLOR
                  )
                )
              ),
              child: getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled || getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()async {
                      prepareData();
                    },
                    child: Container(
                      height: FlexoValues.deviceHeight * 0.07,
                      margin: EdgeInsets.all( FlexoValues.widthSpace2Px),
                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth * 0.1),
                      alignment: Alignment.center,
                      color: FlexoColorConstants.BUTTON_COLOR,
                      child: Text(
                        StringConstants.APPLY_BUTTON.toUpperCase(),
                        style: TextStyle(
                            fontSize:FlexoValues.fontSize17,
                            fontWeight: FontWeight.bold,
                            color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ):Container(),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isApiLoader ? Loaders.apiLoader() : Container(),
                  Expanded(
                    child: Container(
                      width:FlexoValues.deviceWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                            ),
                            width: FlexoValues.deviceWidth * 0.4,
                            child: Column(
                              children: [
                                getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      selectedAttribute = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  selectedAttribute == 0 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width:FlexoValues.deviceWidth * 0.4 ,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.priceRangeFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: selectedAttribute == 0 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      selectedAttribute = 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  selectedAttribute == 1 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.specificationFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color:  selectedAttribute == 1 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                getCatalogRootModel==null ?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      selectedAttribute = 2;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  selectedAttribute == 2 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("categories"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color:  selectedAttribute == 2 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ),

                                getPopularProductTagsModel==null?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      selectedAttribute = 3;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  selectedAttribute == 3 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width:FlexoValues.deviceWidth * 0.4 ,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("products.tags.popular"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color:  selectedAttribute == 3 ? Colors.white : Colors.black,
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
                              width:FlexoValues.deviceWidth * 0.6,
                              child: Column(
                                children: [
                                  selectedAttribute == 0 ?
                                  getCategoryResponseModel.catalogProductsModel.priceRangeFilter.enabled?
                                  Column(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth * 0.6,
                                        child: RangeSlider(
                                          min:  getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from,
                                          max:  getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to,
                                          values:  currentRangeValues,
                                          activeColor: FlexoColorConstants.ACCENT_COLOR,
                                          divisions:  getCategoryResponseModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to.toInt(),
                                          onChanged: (RangeValues values){
                                            setState(() {
                                              currentRangeValues = values;
                                              getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.from = values.start;
                                              getCategoryResponseModel.catalogProductsModel.priceRangeFilter.selectedPriceRange.to = values.end;
                                            });
                                          },
                                        ),
                                      ),

                                      Container(
                                        width: FlexoValues.deviceWidth * 0.6,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace3Px),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: FlexoTextWidget().headingBoldText15(text: currentRangeValues.start.round().toString(),),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: FlexoTextWidget().headingBoldText15(text: currentRangeValues.end.round().toString(),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ):
                                  Container():
                                  Container(),

                                  selectedAttribute == 1 ?
                                  getCategoryResponseModel.catalogProductsModel.specificationFilter.enabled?
                                  Container(
                                    child: Column(
                                      children:  getCategoryResponseModel.catalogProductsModel.specificationFilter.attributes.map((e){
                                        return Container(
                                         padding: EdgeInsets.symmetric(vertical:  FlexoValues.widthSpace2Px),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px),
                                                  child: FlexoTextWidget().headingBoldText15(text: e.name,),
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
                                                        padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                setState(()
                                                                {
                                                                  p.selected = !p.selected;
                                                                });
                                                              },
                                                              child: Container(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [

                                                                    checkboxWidget(isCheck: p.selected,isReadOnly: false),

                                                                    SizedBox(width: FlexoValues.widthSpace2Px,),

                                                                    p.colorSquaresRgb==null ? Container() :
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height: FlexoValues.deviceWidth * 0.05,
                                                                          width:  FlexoValues.deviceWidth * 0.05,
                                                                          color:  Color(selectedColor),
                                                                        ),
                                                                        SizedBox(width:  FlexoValues.widthSpace2Px,),
                                                                      ],
                                                                    ),

                                                                    Flexible(
                                                                      child: Container(
                                                                        child: FlexoTextWidget().contentText16(text: p.name,maxLines: 2),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
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

                                  selectedAttribute == 2 ?
                                  Container(
                                    width:FlexoValues.deviceWidth * 0.6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: getCatalogRootModel.map((e){

                                        return GestureDetector(
                                          onTap: (){
                                            scaffold.currentState!.openEndDrawer();
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: e.id)));
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.symmetric(vertical:FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace1Px),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:  FlexoValues.widthSpace1Px),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: FlexoValues.fontSize12,
                                                    color:FlexoColorConstants.DARK_TEXT_COLOR,
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

                                  selectedAttribute == 3 ?
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Wrap(
                                            children: getPopularProductTagsModel.tags.map((e){
                                              return GestureDetector(
                                                onTap: (){
                                                  scaffold.currentState!.openEndDrawer();
                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByPopularTag(tagId: e.id, tagName: e.name)));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical:FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace1Px),
                                                  child: Text(
                                                    e.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: e.productCount > 15 ? FlexoValues.fontSize17 : FlexoValues.fontSize15,
                                                        color: FlexoColorConstants.DARK_TEXT_COLOR,
                                                        fontWeight: e.productCount>15 ? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth * 0.6,
                                          padding: EdgeInsets.all( FlexoValues.widthSpace2Px),
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              scaffold.currentState!.openEndDrawer();
                                              Navigator.push(context, PageTransition(type: selectedTransition, child: PopularTag()));
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