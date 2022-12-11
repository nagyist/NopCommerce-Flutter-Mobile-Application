/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTag.dart';
import 'package:nopcommerce/Screens/Products/ProductByPopularTag/ProductByPopularTagProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/CheckboxWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Screens/Products/ProductTag/PopularTag.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';

class ProductByPopularTagDrawerComponent{

  getProductByPopularTagDrawerComponent(BuildContext context)
  {
    var productByPopularTagProvider = context.watch<ProductByPopularTagProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return StatefulBuilder(builder: (context,setState){
      return SafeArea(
        child: Container(
          height: FlexoValues.deviceHeight ,
          width: FlexoValues.deviceWidth,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: SafeArea(
                child: Container(
                  width: FlexoValues.deviceWidth,
                  height:FlexoValues.deviceHeight*0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: FlexoValues.deviceHeight*0.07,
                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace3Px,vertical: FlexoValues.heightSpace1Px),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Icon(
                              CheckDeviceType().isIOS() ? Icons.arrow_back_ios : Icons.arrow_back,
                              size:CheckDeviceType().isIOS() ? FlexoValues.iconSize20 : FlexoValues.iconSize22,
                              color: FlexoColorConstants.APPBAR_ICON_COLOR,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: FlexoValues.deviceHeight*0.07,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            StringConstants.FILTER_BUTTON_STRING,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: FlexoValues.fontSize17,
                                fontWeight: FontWeight.bold,
                                color: FlexoColorConstants.APPBAR_TEXT_COLOR
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: FlexoColorConstants.APPBAR_BACKGROUND_COLOR,
              brightness: Brightness.light,
              elevation: 1.0,
              toolbarHeight: FlexoValues.deviceHeight*0.07,
              actions: [
                 productByPopularTagProvider.filterByAttributes.isEmpty && productByPopularTagProvider.filterAttributes.isEmpty && (productByPopularTagProvider.currentRangeValues.start == productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from || productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from == null) && (productByPopularTagProvider.currentRangeValues.end == productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to || productByPopularTagProvider.maxPrice == 10000000 || productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to == null) ? Container() :
                 productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.enabled ||  productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled ?
                 GestureDetector(
                  onTap: (){
                    setState((){
                      productByPopularTagProvider.filterByAttributes.clear();
                      productByPopularTagProvider.filterAttributesDrawer='${productByPopularTagProvider.filterByAttributes}';
                      productByPopularTagProvider.filterAttributesDrawer = productByPopularTagProvider.filterAttributesDrawer.substring(1, productByPopularTagProvider.filterAttributesDrawer.length-1);
                      productByPopularTagProvider.pageNumber = 1;
                      productByPopularTagProvider.minPrice=0;
                      productByPopularTagProvider.maxPrice=100000000;
                    });
                    productByPopularTagProvider.getProductTagData(context: context, minPrice: productByPopularTagProvider.minPrice, maxPrice: productByPopularTagProvider.maxPrice, orderBy: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.orderBy, pageSize:  productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.pageSize, pageNumber: productByPopularTagProvider.pageNumber, filterAttributes: productByPopularTagProvider.filterAttributesDrawer);
                    },
                  child: Container(
                    height: FlexoValues.deviceWidth*0.1,
                    width:FlexoValues.deviceWidth*0.1,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: Image.asset(FlexoAssetsPath.CLEAR_ICON),
                  ),
                ):Container(),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color:FlexoColorConstants.LIST_BORDER_COLOR
                      )
                  )
              ),
              height: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.enabled || productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled ? FlexoValues.deviceHeight*0.07+ FlexoValues.widthSpace4Px : 0,
              child: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.enabled || productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()async {
                      if(await CheckConnectivity().checkInternet(context))
                      {
                        productByPopularTagProvider.doneOnclickEvent(context: context);
                      }
                    },
                    child: Container(
                      height:FlexoValues.deviceHeight*0.07,
                      margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
                      padding: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth*0.1),
                      alignment: Alignment.center,
                      color: FlexoColorConstants.BORDER_COLOR,
                      child: Text(
                        StringConstants.APPLY_BUTTON.toUpperCase(),
                        style: TextStyle(
                            fontSize: FlexoValues.fontSize17,
                            fontWeight: FontWeight.bold,
                            color:FlexoColorConstants.BUTTON_TEXT_COLOR
                        ),
                      ),
                    ),
                  ),
                ],
              ):Container(),
            ),
            body: Container(
              child: Column(
                children: [
                  productByPopularTagProvider.isAPILoader ? Loaders.apiLoader() : Container(),
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
                            width: FlexoValues.deviceWidth*0.4,
                            child: Column(
                              children: [

                                productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      productByPopularTagProvider.selectedAttribute = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: productByPopularTagProvider.selectedAttribute == 0 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth*0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.priceRangeFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: productByPopularTagProvider.selectedAttribute == 0 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.enabled?
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      productByPopularTagProvider. selectedAttribute = 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: productByPopularTagProvider.selectedAttribute == 1 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth*0.4,
                                    padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("filtering.specificationFilter"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: productByPopularTagProvider.selectedAttribute == 1 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ) : Container(),

                                productByPopularTagProvider.getCatalogRootModel==null || productByPopularTagProvider.getCatalogRootModel.isEmpty?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      productByPopularTagProvider.selectedAttribute = 3;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: productByPopularTagProvider.selectedAttribute == 3 ? FlexoColorConstants.THEME_COLOR :FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth*0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("categories"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: productByPopularTagProvider.selectedAttribute == 3 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FlexoValues.fontSize15
                                      ),
                                    ),
                                  ),
                                ),

                                productByPopularTagProvider.getPopularProductTagsModel==null ?Container():
                                GestureDetector(
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      productByPopularTagProvider.selectedAttribute = 6;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: productByPopularTagProvider.selectedAttribute == 6 ? FlexoColorConstants.THEME_COLOR : FlexoColorConstants.FILTER_SLIDE_BACKGROUND_COLOR,
                                    ),
                                    width: FlexoValues.deviceWidth*0.4,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace3Px),
                                    child: Text(
                                      localResourceProvider.getResourseByKey("products.tags.popular"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: productByPopularTagProvider.selectedAttribute == 6 ? Colors.white : Colors.black,
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
                              width: FlexoValues.deviceWidth*0.6,
                              child: Column(
                                children: [
                                  productByPopularTagProvider.selectedAttribute == 0 ?
                                  productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.enabled?
                                  Column(
                                    children: [
                                      Container(
                                        width: FlexoValues.deviceWidth*0.6,
                                        child: RangeSlider(
                                          min: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.from,
                                          max: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to,
                                          values: productByPopularTagProvider.currentRangeValues,
                                          activeColor: FlexoColorConstants.ACCENT_COLOR,
                                          divisions: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.priceRangeFilter.availablePriceRange.to.toInt(),
                                          onChanged: (RangeValues values){
                                            setState(() {
                                              productByPopularTagProvider.currentRangeValues = values;
                                              productByPopularTagProvider.minPrice=productByPopularTagProvider.currentRangeValues.start.toInt();
                                              productByPopularTagProvider.maxPrice=productByPopularTagProvider.currentRangeValues.end.toInt();

                                            });
                                          },
                                        ),
                                      ),

                                      Container(
                                        width:FlexoValues.deviceWidth*0.6,
                                        padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px,horizontal: FlexoValues.widthSpace3Px),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                productByPopularTagProvider.currentRangeValues.start.round().toString(),
                                                style: TextStyle(
                                                    fontSize: FlexoValues.fontSize17,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                productByPopularTagProvider.currentRangeValues.end.round().toString(),
                                                style: TextStyle(
                                                    fontSize: FlexoValues.fontSize17,
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

                                  productByPopularTagProvider.selectedAttribute == 1 ?
                                  productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.enabled?
                                  Container(
                                    child: Column(
                                      children: productByPopularTagProvider.getProductsByTagModel.catalogProductsModel.specificationFilter.attributes.map((e){

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
                                                        fontSize: FlexoValues.fontSize16,
                                                        color:FlexoColorConstants.DARK_TEXT_COLOR,
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
                                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical:FlexoValues.widthSpace2Px),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:(){
                                                                      productByPopularTagProvider.filterAttributesOnclickEvent(setState, p);
                                                                      },
                                                                    child: checkboxWidget(isCheck: true , isReadOnly: false)
                                                                  ),

                                                                  SizedBox(width: FlexoValues.widthSpace2Px,),

                                                                  p.colorSquaresRgb==null ? Container() :
                                                                  GestureDetector(
                                                                    onTap:(){
                                                                      productByPopularTagProvider.filterAttributesOnclickEvent(setState, p);
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
                                                                      onTap:(){
                                                                        productByPopularTagProvider.filterAttributesOnclickEvent(setState, p);
                                                                        },
                                                                      child: Container(
                                                                        child: Text(
                                                                          p.name,
                                                                          maxLines: 2,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: FlexoValues.fontSize16,
                                                                              color:FlexoColorConstants.DARK_TEXT_COLOR
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
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

                                  productByPopularTagProvider.selectedAttribute == 3 ?
                                  Container(
                                    width: FlexoValues.deviceWidth*0.6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: productByPopularTagProvider.getCatalogRootModel.map((e){
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: e.id)));
                                            },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace1Px,horizontal: FlexoValues.widthSpace1Px),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: FlexoValues.iconSize12,
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
                                                          fontSize: FlexoValues.fontSize16,
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

                                  productByPopularTagProvider.selectedAttribute == 6 ?
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Wrap(
                                            children: productByPopularTagProvider.getPopularProductTagsModel.tags.map((e){
                                              return GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByPopularTag(tagId: e.id, tagName: e.name)));
                                                  },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace1Px,horizontal: FlexoValues.widthSpace1Px),
                                                  child: Text(
                                                    e.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: e.productCount > 15 ? FlexoValues.fontSize18 : FlexoValues.fontSize16,
                                                        color:FlexoColorConstants.DARK_TEXT_COLOR,
                                                        fontWeight: e.productCount>15? FontWeight.bold:FontWeight.normal
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth*0.6,
                                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){
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