/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Catalog/SearchProducts/SearchProductsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Catalog/SearchProducts/Component/SearchProductDrawerComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';

class FlexoSearchProducts extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var searchProductsProvider = context.watch<SearchProductsProvider>();

    if(searchController.text.isEmpty){
      searchController.text = searchProductsProvider.searchTerms;
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.search"), backButton: true),
        drawer: SearchProductDrawerComponent(scaffoldKey: scaffoldKey),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: searchProductsProvider.headerModel,headerLoader: searchProductsProvider.isPageLoader),
        body: searchProductsProvider.isPageLoader ? Loaders.pageLoader() :
        StatefulBuilder(builder: (context, setState)
        {
          return Column(
            children: [

              searchProductsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        Container(
                          width: FlexoValues.deviceWidth,
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              searchProductsProvider.searchProductModel.catalogProductsModel.products.isEmpty ? Container() :
                              GestureDetector(
                                onTap: ()
                                {
                                  KeyboardUtil.hideKeyboard(context);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => StatefulBuilder(builder: (ctx, setState)
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
                                                            color: FlexoColorConstants.LIST_BORDER_COLOR
                                                        )
                                                    )
                                                ),
                                                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("catalog.orderBy").toString().toUpperCase(),),
                                                    ),

                                                    GestureDetector(
                                                      onTap: ()
                                                      {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Ionicons.close_outline,
                                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                          size: FlexoValues.iconSize20,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                child: Column(
                                                  children: searchProductsProvider.searchProductModel.catalogProductsModel.availableSortOptions.map((data) {

                                                    return GestureDetector(
                                                      onTap: ()
                                                      {
                                                        setState(()
                                                        {
                                                          KeyboardUtil.hideKeyboard(context);
                                                          searchProductsProvider.searchProductModel.catalogProductsModel.orderBy = int.parse(data.value);
                                                          Navigator.pop(context);
                                                          searchProductsProvider.searchButtonClick(context: context,searchTerms: searchProductsProvider.searchProductModel.q);
                                                        });
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
                                                                  searchProductsProvider.searchProductModel.catalogProductsModel.orderBy.toString() == data.value ? Icons.radio_button_checked : Icons.radio_button_off,
                                                                  color: searchProductsProvider.searchProductModel.catalogProductsModel.orderBy.toString() == data.value ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
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

                                              SizedBox(height: FlexoValues.widthSpace2Px)
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                                child: Container(
                                  width: FlexoValues.deviceWidth * 0.47,
                                  height: FlexoValues.deviceHeight * 0.05,
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
                                        child: FlexoTextWidget().headingText15(text: StringConstants.SORT_BUTTON_STRING,),
                                      ),

                                      SizedBox(width: FlexoValues.widthSpace2Px),

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
                                onTap: ()
                                {
                                  KeyboardUtil.hideKeyboard(context);
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Container(
                                  width: FlexoValues.deviceWidth * 0.47,
                                  height: FlexoValues.deviceHeight * 0.05,
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
                                        child: FlexoTextWidget().headingText15(text: StringConstants.FILTER_BUTTON_STRING,maxLines: 1),
                                      ),

                                      SizedBox(width: FlexoValues.widthSpace2Px),

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

                        Container(
                          child: Column(
                            children: [

                              SizedBox(height: FlexoValues.widthSpace2Px),

                              Container(
                                width: FlexoValues.controlsWidth,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: searchController,
                                  style: TextStyle(
                                      fontSize: FlexoValues.fontSize16,
                                      color: FlexoColorConstants.DARK_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),
                                  decoration: InputDecoration(
                                    hintText: localResourceProvider.getResourseByKey("forum.search.searchKeyword"),
                                    prefixIcon: Icon(
                                      Ionicons.search_outline,
                                      color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                                      size: FlexoValues.fontSize17,
                                    ),
                                    hintStyle: TextStyleWidget.hintTextStyle,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                            color: FlexoColorConstants.BORDER_COLOR
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                            color: FlexoColorConstants.BORDER_COLOR
                                        )
                                    ),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: FlexoColorConstants.BORDER_COLOR),
                                        borderRadius: BorderRadius.zero
                                    ),

                                    filled: true,
                                    fillColor: FlexoColorConstants.CONTROL_BACKGROUND_COLOR,
                                  ),
                                  keyboardType: TextInputType.text,
                                  cursorColor: FlexoColorConstants.CURSOR_COLOR,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace3Px),

                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Transform.scale(
                                      scale: FlexoValues.switchScale,
                                      child: CupertinoSwitch(
                                        onChanged: (val)
                                        {
                                          setState(()
                                          {
                                            searchProductsProvider.searchProductModel.advs = !searchProductsProvider.searchProductModel.advs;
                                          });
                                        },
                                        value: searchProductsProvider.searchProductModel.advs,
                                        activeColor: FlexoColorConstants.ACCENT_COLOR,
                                      ),
                                    ),

                                    SizedBox(width: FlexoValues.widthSpace2Px),

                                    Container(
                                      child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey('search.advancedSearch'),),
                                    ),

                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.widthSpace3Px),

                              searchProductsProvider.searchProductModel.advs==true?
                              Container(
                                child: Column(
                                  children: [

                                    FlexoDropDown(
                                        width: FlexoValues.controlsWidth,
                                        selectedValue: searchProductsProvider.searchProductModel.cid.toString(),
                                        items: searchProductsProvider.searchProductModel.availableCategories.map((e)
                                        {
                                          return DropDownModel(text: e.text, value: e.value);
                                        }).toList(),
                                        onChange: (val)
                                        {
                                          setState(()
                                          {
                                            searchProductsProvider.searchProductModel.cid = int.parse(val);
                                          });
                                        }
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace3Px),

                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Transform.scale(
                                            scale: FlexoValues.switchScale,
                                            child: CupertinoSwitch(
                                              onChanged: (val)
                                              {
                                                setState(()
                                                {
                                                  searchProductsProvider.searchProductModel.isc = !searchProductsProvider.searchProductModel.isc;
                                                });
                                              },
                                              value: searchProductsProvider.searchProductModel.isc,
                                              activeColor: FlexoColorConstants.ACCENT_COLOR,
                                            ),
                                          ),

                                          SizedBox(width: FlexoValues.widthSpace2Px),

                                          Flexible(
                                            child: Container(
                                              child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("search.includeSubcategories"),),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace3Px),

                                    FlexoDropDown(
                                        width: FlexoValues.controlsWidth,
                                        selectedValue: searchProductsProvider.searchProductModel.mid.toString(),
                                        items: searchProductsProvider.searchProductModel.availableManufacturers.map((e)
                                        {
                                          return DropDownModel(text: e.text, value: e.value);
                                        }).toList(),
                                        onChange: (val)
                                        {
                                          setState(()
                                          {
                                            searchProductsProvider.searchProductModel.mid = int.parse(val);
                                          });
                                        }
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace3Px),

                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Transform.scale(
                                            scale: FlexoValues.switchScale,
                                            child: CupertinoSwitch(
                                              onChanged: (val)
                                              {
                                                setState(()
                                                {
                                                  searchProductsProvider.searchProductModel.sid = !searchProductsProvider.searchProductModel.sid;
                                                });
                                              },
                                              value: searchProductsProvider.searchProductModel.sid,
                                              activeColor: FlexoColorConstants.ACCENT_COLOR,
                                            ),
                                          ),

                                          SizedBox(width: FlexoValues.widthSpace2Px),

                                          Flexible(
                                            child: Container(
                                              child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("search.searchInDescriptions"),),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace3Px),

                                  ],
                                ),
                              ) :
                              Container(),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("search.button").toString().toUpperCase(),
                                  width: FlexoValues.deviceWidth * 0.4,
                                  onClick: () async
                                  {
                                    KeyboardUtil.hideKeyboard(context);
                                    if(await CheckConnectivity().checkInternet(context))
                                    {
                                      searchProductsProvider.searchButtonClick(context: context,searchTerms: searchController.text.toString());
                                    }

                                  },
                                  isApiLoad: false
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px),

                        searchProductsProvider.searchProductModel.catalogProductsModel.warningMessage != null?
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: FlexoValues.widthSpace2Px),

                              Container(
                                child: FlexoTextWidget().warningMessageText(text: searchProductsProvider.searchProductModel.catalogProductsModel.warningMessage,),
                              )
                            ],
                          ),
                        ):Container(),

                        Container(
                          child: Column(
                            children: [

                              searchProductsProvider.searchProductModel.catalogProductsModel.products.isEmpty ? searchController.text.isNotEmpty ? searchProductsProvider.isAPILoader ?
                              Container() :
                              searchProductsProvider.searchProductModel.catalogProductsModel.noResultMessage == null ? Container( ) :
                              Container(
                                padding: EdgeInsets.all(FlexoValues.widthSpace5Px),
                                child: FlexoTextWidget().contentText15(text: searchProductsProvider.searchProductModel.catalogProductsModel.noResultMessage,),
                              ):Container():
                              Container(
                                child: Column(
                                  children: [

                                    SizedBox(height: FlexoValues.widthSpace2Px),

                                    searchProductsProvider.searchProductModel.catalogProductsModel.products.isEmpty?
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace3Px,horizontal: FlexoValues.widthSpace2Px),
                                      alignment: Alignment.centerLeft,
                                      child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("catalog.products.noResult"),maxLines: 3),
                                    ):
                                    Container(
                                      child: Container(
                                        width: FlexoValues.deviceWidth,
                                        padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          children: searchProductsProvider.searchProductModel.catalogProductsModel.products.map((e){

                                            return Container(
                                              child: ProductBox().getProductBox(context: context, productBoxModel: e, localResourceProvider: localResourceProvider, updateHeaderData: searchProductsProvider.getHeaderData),
                                            );

                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
