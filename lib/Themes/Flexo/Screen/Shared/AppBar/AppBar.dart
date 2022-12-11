/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Models/GetSearchTermModel.dart';
import 'package:nopcommerce/Screens/Catalog/SearchProducts/SearchProducts.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import '../../../../../Screens/Shared/AppBarProvider.dart';

class FlexoAppBarWidget {

  appbar({required context,required title,List<Widget>? actions,required bool backButton})
  {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: FlexoValues.deviceHeight * 0.07,
      flexibleSpace: SafeArea(
        child: Container(
          width: FlexoValues.deviceWidth,
          height: FlexoValues.deviceHeight * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton?
              GestureDetector(
                onTap: ()
                {
                  Navigator.pop(context);
                },
                child: Container(
                  height: FlexoValues.deviceHeight * 0.07,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace3Px),
                  alignment: Alignment.center,
                  child: Container(
                    child: Icon(
                      CheckDeviceType().isIOS() ? CupertinoIcons.back : Ionicons.arrow_back,
                      size: CheckDeviceType().isTab() ? FlexoValues.iconSize20 : FlexoValues.iconSize22,
                        color: FlexoColorConstants.APPBAR_ICON_COLOR
                    ),
                  ),
                ),
              ) : Container(width: FlexoValues.widthSpace3Px,),

              Expanded(
                child: Container(
                  height: FlexoValues.deviceHeight * 0.07,
                  alignment: Alignment.centerLeft,
                  child: FlexoTextWidget().appbarText(text: title,maxLines: 1)
                ),
              )
            ],
          ),
        ),
      ),
      brightness: Brightness.light,
      backgroundColor: FlexoColorConstants.APPBAR_BACKGROUND_COLOR,
      actions: actions,
      elevation: 2,
    );
  }

  appbarPopup({required context,required title,})
  {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth:0,
      centerTitle: false,
      toolbarHeight: FlexoValues.deviceHeight * 0.07,
      brightness: Brightness.light,
      title: FlexoTextWidget().appbarText(text: title,maxLines: 1),
      backgroundColor: FlexoColorConstants.APPBAR_BACKGROUND_COLOR,
      actions: [
        GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },
          child: Container(
              width: FlexoValues.deviceWidth * 0.15,
              child: Icon(
                  Ionicons.close,
                  color: FlexoColorConstants.APPBAR_ICON_COLOR
              )
          ),
        )
      ],
      elevation: 2,
    );
  }

  searchableAppbar({required BuildContext context,required bool backButton})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var appBarProvider = context.watch<AppBarProvider>();

    return AppBar(
      elevation: 1.0,
      toolbarHeight: FlexoValues.deviceHeight * 0.08,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          color: FlexoColorConstants.APPBAR_BACKGROUND_COLOR,
          width: FlexoValues.deviceWidth,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              backButton ?
              GestureDetector(
                onTap: ()
                {
                  Navigator.pop(context);
                },
                child: Container(
                  height: FlexoValues.deviceHeight * 0.08,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace3Px),
                  alignment: Alignment.center,
                  child: Container(
                    child: Icon(
                      CheckDeviceType().isIOS() ? CupertinoIcons.back : Icons.arrow_back,
                      size: CheckDeviceType().isTab() ? FlexoValues.iconSize20 : FlexoValues.iconSize22,
                      color: FlexoColorConstants.APPBAR_ICON_COLOR,
                    ),
                  ),
                ),
              ) : Container(width: FlexoValues.widthSpace2Px,),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      localResourceProvider.getSettingByName("catalogSettings.productSearchAutoCompleteEnabled") == "True"?
                      Container(
                        width: FlexoValues.deviceWidth * 0.96,
                        height: FlexoValues.deviceHeight * 0.06,
                        margin: EdgeInsets.only(top: FlexoValues.heightSpace1Px,bottom: FlexoValues.heightSpace1Px,right: FlexoValues.widthSpace2Px),
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: FlexoColorConstants.LIST_BORDER_COLOR,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(FlexoValues.widthSpace2Px)
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TypeAheadField(
                              hideOnEmpty: true,
                              noItemsFoundBuilder: (context) => Container(
                                height: appBarProvider.matches.length == 0 ? 0 : FlexoValues.deviceHeight * 0.1,
                                child: Center(
                                    child: CircularProgressIndicator()
                                ),
                              ),
                              hideOnLoading: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                autofocus:false,
                                cursorColor: FlexoColorConstants.CURSOR_COLOR,
                                style: TextStyleWidget.controlsTextStyle,
                                controller: appBarProvider.searchText,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.go,
                                onSubmitted: (val)
                                {
                                  if(val.isNotEmpty){
                                    Navigator.push(context, PageTransition(type: selectedTransition, child: SearchProducts(searchTerms: val,isAppBarSearch: true,))).then((value){
                                      appBarProvider.searchText.clear();
                                    });
                                  }else{
                                    FlushBarMessage().failedMessage(context: context, title: localResourceProvider.getResourseByKey("search.enterSearchTerms"));
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("search.searchBox.tooltip"),
                                  hintStyle: TextStyleWidget.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                              suggestionsCallback: (pattern) async {
                                List<GetSearchTermModel> matchesData = [];
                                int searchLength = localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength") == "catalogSettings.productSearchTermMinimumLength" ? 0 : int.parse(localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength"));
                                if (pattern.length >= searchLength) {
                                  await appBarProvider.searchTermsOnChange(context: context, pattern: pattern);
                                  return appBarProvider.getSearchTermModel;
                                }
                                return matchesData;
                              },
                              itemBuilder: (context, GetSearchTermModel suggestion) {
                                return Row(
                                  children: [
                                    suggestion.productPictureUrl!=null?
                                    Container(
                                      width: FlexoValues.deviceHeight * 0.07,
                                      height: FlexoValues.deviceHeight * 0.07,
                                      child: CachedNetworkImage(imageUrl: suggestion.productPictureUrl),
                                    ):Container(),

                                    Expanded(
                                      child: Container(
                                        height: FlexoValues.deviceHeight * 0.07,
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          suggestion.label,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: FlexoValues.fontSize15,
                                              color: FlexoColorConstants.DARK_TEXT_COLOR,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                              transitionBuilder: (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (GetSearchTermModel suggestion) {
                                appBarProvider.searchText.text = suggestion.label;
                                FocusScope.of(context).requestFocus(new FocusNode());
                                Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: suggestion.productId,updateId: 0,isCart: false,))).then((value){
                                  appBarProvider.searchText.clear();
                                });
                                },
                            ),

                            GestureDetector(
                              onTap: (){
                                KeyboardUtil.hideKeyboard(context);
                                if(appBarProvider.searchText.text.isNotEmpty){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: SearchProducts(searchTerms: appBarProvider.searchText.text.trim().toString(),isAppBarSearch: true,))).then((value){
                                    appBarProvider.searchText.clear();
                                  });
                                }else{
                                  FlushBarMessage().failedMessage(context: context, title: localResourceProvider.getResourseByKey("search.enterSearchTerms"));
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: FlexoValues.iconSize22,
                              ),
                            )
                          ],
                        ),
                      ):
                      Container(
                        width: FlexoValues.deviceWidth * 0.96,
                        height: FlexoValues.deviceHeight * 0.06,
                        margin: EdgeInsets.only(top: FlexoValues.heightSpace1Px,bottom: FlexoValues.heightSpace1Px,right: FlexoValues.widthSpace2Px),
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: FlexoColorConstants.LIST_BORDER_COLOR,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(FlexoValues.widthSpace2Px)
                            )
                        ),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextFormField(
                              autofocus:false,
                              controller: appBarProvider.searchText,
                              keyboardType: TextInputType.url,
                              style: TextStyleWidget.controlsTextStyle,
                              textInputAction: TextInputAction.go,
                              onFieldSubmitted: (val)
                              {
                                KeyboardUtil.hideKeyboard(context);
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                int searchLength = localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength") == "catalogSettings.productSearchTermMinimumLength" ? 0 : int.parse(localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength"));
                                if(val.length >= searchLength){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: SearchProducts(searchTerms: val,isAppBarSearch: true,))).then((value){
                                    appBarProvider.searchText.clear();
                                  });
                                }else{
                                  FlushBarMessage().failedMessage(context: context, title: localResourceProvider.getResourseByKey("search.enterSearchTerms"));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("search.searchBox.tooltip"),
                                hintStyle: TextStyleWidget.hintTextStyle,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                KeyboardUtil.hideKeyboard(context);
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                int searchLength = localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength") == "catalogSettings.productSearchTermMinimumLength" ? 0 : int.parse(localResourceProvider.getSettingByName("catalogSettings.productSearchTermMinimumLength"));
                                if(appBarProvider.searchText.text.length >= searchLength){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: SearchProducts(searchTerms: appBarProvider.searchText.text.trim().toString(),isAppBarSearch: true,))).then((value){
                                    appBarProvider.searchText.clear();
                                  });
                                }else{
                                  FlushBarMessage().failedMessage(context: context, title: localResourceProvider.getResourseByKey("search.enterSearchTerms"));
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: FlexoValues.iconSize22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: FlexoColorConstants.APPBAR_BACKGROUND_COLOR,
      brightness: Brightness.light,
    );
  }
}