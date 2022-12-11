/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/HeaderInfoResponseModel.dart';
import 'package:nopcommerce/Models/ProductBoxModel.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/Model/GetCategoryResponseModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';

class FlexoProductByCategory{

  getView({
    required BuildContext context,
    required bool isPageLoader,
    required bool isApiLoader,
    required bool isLoadProduct,
    required HeaderInfoResponseModel headerModel,
    required getHeaderData,
    required ScrollController scrollController,
    required GetCategoryResponseModel getCategoryResponseModel,
    required int selectedSortRadioGroup,
    required List<ProductBoxModel> products,
    required GlobalKey<ScaffoldState> scaffold,
    required Function() prepareData,
  })
  {
    return Container(
      child: Column(
        children: [

          SizedBox(height: FlexoValues.widthSpace2Px,),

          Container(
            width: FlexoValues.deviceWidth,
            margin: EdgeInsets.symmetric(horizontal: FlexoValues.horizontalSpace),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCategoryResponseModel.catalogProductsModel.products.isEmpty ? Container():
                    GestureDetector(
                      onTap: ()
                      {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => StatefulBuilder(builder: (context, setState)
                          {
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
                                      padding: EdgeInsets.all(FlexoValues.horizontalSpace),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          StatefulBuilder(builder: (context, setState){
                                            return Container(
                                              child: FlexoTextWidget().contentText17(text: context.watch<LocalResourceProvider>().getResourseByKey("catalog.orderby").toString().toUpperCase(),),
                                            );
                                          }),

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
                                        children: getCategoryResponseModel.catalogProductsModel.availableSortOptions.map((data) {
                                          return GestureDetector(
                                            onTap: ()
                                            {
                                              setState(()
                                              {
                                                getCategoryResponseModel.catalogProductsModel.orderBy = int.parse(data.value);
                                              });
                                              Navigator.pop(context);
                                              prepareData();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.heightSpace1Px),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: FlexoTextWidget().headingBoldText15(text: "${data.text}",maxLines: 2),
                                                  ),
                                                  Container(
                                                      child: Icon(
                                                        getCategoryResponseModel.catalogProductsModel.orderBy.toString() == data.value ? Icons.radio_button_checked : Icons.radio_button_off,
                                                        color: getCategoryResponseModel.catalogProductsModel.orderBy.toString() == data.value ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                                        size: FlexoValues.iconSize20,
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                    SizedBox(height:FlexoValues.heightSpace2Px,)
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                      child: Container(
                        width: FlexoValues.deviceWidth * 0.47,
                        height: FlexoValues.heightSpace5Px,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:FlexoColorConstants.BORDER_COLOR
                            )
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              child: FlexoTextWidget().headingText16(text: StringConstants.SORT_BUTTON_STRING,),
                            ),

                            SizedBox(width:  FlexoValues.widthSpace2Px,),

                            Container(
                              child: Icon(
                                Ionicons.filter_outline,
                                size: FlexoValues.iconSize20,
                                color: FlexoColorConstants.DARK_TEXT_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: ()async
                      {
                        scaffold.currentState!.openDrawer();
                      },
                      child: Container(
                        width: FlexoValues.deviceWidth * 0.47,
                        height: FlexoValues.heightSpace5Px,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: FlexoColorConstants.BORDER_COLOR
                            )
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Container(
                              child: FlexoTextWidget().headingText16(text: StringConstants.FILTER_BUTTON_STRING,),
                            ),

                            SizedBox(width: FlexoValues.widthSpace2Px),

                            Container(
                              child: Icon(
                                Ionicons.funnel_outline,
                                size:FlexoValues.iconSize20,
                                color: FlexoColorConstants.DARK_TEXT_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height:  FlexoValues.widthSpace4Px),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: FlexoValues.deviceHeight * 0.005,horizontal:  FlexoValues.widthSpace2Px),
            alignment: Alignment.centerLeft,
            child: FlexoTextWidget().headingBoldText16(text: "${getCategoryResponseModel.name.toUpperCase()}",),
          ),

          getCategoryResponseModel.subCategories.isNotEmpty?
          Container(
            child: Column(
              children: [

                Container(
                  width: FlexoValues.deviceWidth,
                  child:  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.only(right:  FlexoValues.widthSpace2Px),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getCategoryResponseModel.subCategories.map((e) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: e.id))).then((value)
                              {
                                getHeaderData();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left:  FlexoValues.widthSpace2Px),
                              child: Column(
                                children: [
                                  Container(
                                    width:FlexoValues.deviceWidth * 0.35,
                                    height: FlexoValues.deviceWidth * 0.25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              e.pictureModel.imageUrl
                                          ),
                                        )
                                    ),
                                    child: Container(
                                      width:FlexoValues.deviceWidth * 0.32,
                                      height:FlexoValues.deviceWidth * 0.23,
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: FlexoValues.deviceWidth * 0.3,
                                        padding: EdgeInsets.all( FlexoValues.widthSpace2Px),
                                        color: Colors.white,
                                        child: Text(
                                          e.name.toUpperCase(),
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: FlexoColorConstants.DARK_TEXT_COLOR,
                                            fontSize: FlexoValues.fontSize14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) : Container(),

          getCategoryResponseModel.catalogProductsModel.products.isEmpty && getCategoryResponseModel.subCategories.isEmpty?
          StatefulBuilder(builder: (context, setState){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace3Px,horizontal: FlexoValues.widthSpace2Px),
                  alignment: Alignment.centerLeft,
                  child: FlexoTextWidget().headingText16(text: context.watch<LocalResourceProvider>().getResourseByKey("catalog.products.noResult"),),
                );
              }):
          Container(
            child: Column(
              children: [

                Container(
                  width: FlexoValues.deviceWidth,
                  padding: EdgeInsets.all( FlexoValues.widthSpace1Px),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: products.map((e){
                      return Container(
                        child: ProductBox().getProductBox(context: context,productBoxModel: e,localResourceProvider: context.watch<LocalResourceProvider>(),updateHeaderData: getHeaderData),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


