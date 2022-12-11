/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Screens/Customer/CustomerProductReview/CustomerProductReview.dart';
import 'package:nopcommerce/Screens/Customer/Address/AddressList/AddressList.dart';
import 'package:nopcommerce/Screens/Customer/Avatar/Avatar.dart';
import 'package:nopcommerce/Screens/Customer/BackInStockSubscriptions/BackInStockSubscriptions.dart';
import 'package:nopcommerce/Screens/Customer/ChangePassword/ChangePassword.dart';
import 'package:nopcommerce/Screens/Customer/CustomerInfo/CustomerInfo.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/DownloadableProduct.dart';
import 'package:nopcommerce/Screens/Customer/GdprTools/GdprTools.dart';
import 'package:nopcommerce/Screens/Customer/GiftCardBalance/GiftCardBalance.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderList/OrderList.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestList/ReturnRequest.dart';
import 'package:nopcommerce/Screens/Customer/RewardPoint/RewardPoint.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerNavigationType.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'Components/NotLoginComponent.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("account.myAccount"), backButton: false),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      body: localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :
      homeProvider.isProfileLoad ? Loaders.pageLoader() :
      Column(
        children: [

          Expanded(
            child: Container(
              child: SingleChildScrollView(
                controller: homeProvider.profileScrollController,
                child: Container(
                  child: Column(
                    children: [

                      homeProvider.headerModel.isAuthenticated ?
                      Container(
                        child: Column(
                          children: [

                            homeProvider.getLanguagesModel.availableLanguages.length > 1 ?
                            Column(
                              children: [

                                SizedBox(height: FlexoValues.heightSpace2Px,),

                                Container(
                                  width: FlexoValues.deviceWidth,
                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  alignment: Alignment.centerLeft,
                                  child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("languages.selector.label"),),
                                ),

                                SizedBox(height: FlexoValues.heightSpace1Px,),

                                homeProvider.getLanguagesModel.useImages ?
                                Container(
                                  child: Column(
                                    children: [

                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      Container(
                                        child: Row(
                                          children: homeProvider.getLanguagesModel.availableLanguages.map((e){
                                            return GestureDetector(
                                              onTap: () async{
                                                homeProvider.updateLanguage(context: context,selectedValue: e.name);
                                                localResourceProvider.loadLocalResources();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                height: FlexoValues.deviceWidth * 0.07,
                                                width: FlexoValues.deviceWidth * 0.1,
                                                child: CachedNetworkImage(imageUrl: e.flagImageFileName,),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ):
                                FlexoDropDown(
                                    width: FlexoValues.controlsWidth,
                                    showRequiredIcon: false,
                                    selectedValue: homeProvider.getLanguagesModel.currentLanguageId.toString(),
                                    items: homeProvider.getLanguagesModel.availableLanguages.map((e)
                                    {
                                      return DropDownModel(text: e.name, value: e.id.toString());
                                    }).toList(),
                                    onChange: (val)
                                    {
                                      homeProvider.updateLanguage(context: context, selectedValue: val);
                                      localResourceProvider.loadLocalResources();
                                    }
                                ),

                                SizedBox(height: FlexoValues.heightSpace2Px,),
                              ],
                            ) : SizedBox(),

                            homeProvider.currencyResponseModel.availableCurrencies.length > 1 ?
                            Column(
                              children: [

                                Container(
                                  width: FlexoValues.deviceWidth,
                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  alignment: Alignment.centerLeft,
                                  child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("currency.selector.label"),),
                                ),

                                SizedBox(height: FlexoValues.heightSpace1Px,),

                                FlexoDropDown(
                                    width: FlexoValues.controlsWidth,
                                    showRequiredIcon: false,
                                    selectedValue: homeProvider.currencyResponseModel.currentCurrencyId.toString(),
                                    items: homeProvider.currencyResponseModel.availableCurrencies.map((e)
                                    {
                                      return DropDownModel(text: e.name, value: e.id.toString());
                                    }).toList(),
                                    onChange: (val)
                                    {
                                      homeProvider.updateCurrency(context: context, selectedValue: val);
                                    }
                                ),

                                SizedBox(height: FlexoValues.heightSpace2Px,),
                              ],
                            ) : SizedBox(),

                            localResourceProvider.getSettingByName("taxSettings.allowCustomersToSelectTaxDisplayType") == "True" ?
                            Column(
                              children: [
                                Container(
                                  width: FlexoValues.deviceWidth,
                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  alignment: Alignment.centerLeft,
                                  child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("tax.selector.label"),),
                                ),

                                SizedBox(height: FlexoValues.heightSpace1Px,),

                                FlexoDropDown(
                                    width: FlexoValues.controlsWidth,
                                    showRequiredIcon: false,
                                    selectedValue: homeProvider.taxTypeModel.currentTaxType,
                                    items: homeProvider.taxTypeModel.availableTaxTypes.map((e)
                                    {
                                      return DropDownModel(text: e.displayText, value: e.name);
                                    }).toList(),
                                    onChange: (val)
                                    {
                                      homeProvider.updateTax(context: context, taxType: val);
                                    }
                                ),

                                SizedBox(height: FlexoValues.heightSpace3Px,),

                                Divider(thickness: 1,height: FlexoValues.heightSpace1Px,color: FlexoColorConstants.LIST_BORDER_COLOR,),
                              ],
                            ) : SizedBox(height: FlexoValues.heightSpace1Px,),

                            Container(
                              child: Column(

                                children: homeProvider.customerNavigationItems.map((e){
                                  return Column(
                                    children: [
                                      e.tab == CustomerNavigationType.Info ?
                                      profileNavigationTab(
                                          title: e.title,
                                          icon: Ionicons.person_outline,
                                          onTap: ()
                                          {
                                            Navigator.push(context, PageTransition(type: selectedTransition, child: CustomerInfo()));
                                          },
                                      ) :Container(),

                                      e.tab == CustomerNavigationType.Addresses ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.location_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: AddressList()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.Orders ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.cart_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: OrderList()));
                                        },
                                      ) :Container(),

                                      e.tab == CustomerNavigationType.ReturnRequests ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.return_down_back_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: ReturnRequest()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.DownloadableProducts ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.cloud_download_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: DownloadableProduct()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.BackInStockSubscriptions ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.ribbon_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: BackInStockSubscriptions()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.RewardPoints ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.gift_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: RewardPoints()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.ChangePassword ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.lock_closed_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: ChangePassword()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.Avatar ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.person_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: Avatar()));
                                        },
                                      ): Container(),


                                      e.tab == CustomerNavigationType.ProductReviews ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.create_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: CustomerProductReview()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.GdprTools ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.construct_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: GdprTools()));
                                        },
                                      ): Container(),

                                      e.tab == CustomerNavigationType.CheckGiftCardBalance ?
                                      profileNavigationTab(
                                        title: e.title,
                                        icon: Ionicons.gift_outline,
                                        onTap: ()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: GiftCardBalance()));
                                        },
                                      ): Container(),


                                    ],
                                  );
                                }).toList(),
                              ),
                            ),

                            homeProvider.networkHomeLoader && homeProvider.networkCategoryLoader && homeProvider.networkCartLoader && homeProvider.networkProfileLoader ? Container() :
                            profileNavigationTab(
                              title: localResourceProvider.getResourseByKey('account.logout'),
                              icon: Ionicons.exit_outline,
                              onTap: ()
                              {
                                homeProvider.logoutUser(context: context);
                              },
                            ),

                            SizedBox(height: FlexoValues.heightSpace3Px,),

                            Container(
                              width: FlexoValues.controlsWidth,
                              margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace3Px),
                              alignment: Alignment.center,
                              child: Text(
                                StringConstants.VERSION_NAME,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: FlexoColorConstants.VERSION_TEXT_COLOR,
                                    fontWeight: FontWeight.normal,
                                    fontSize: FlexoValues.fontSize16
                                ),
                              ),
                            )
                          ],
                        ),
                      ):
                      NotLoginComponent().getNotLoginComponent(context: context),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  profileNavigationTab({required String title, required IconData icon,required Function() onTap})
  {
    return Column(
      children: [
        ListTile(
          trailing: Icon(
            Icons.arrow_right_outlined,
            color: FlexoColorConstants.DARK_TEXT_COLOR,
            size: FlexoValues.fontSize22,
          ),
          leading: Container(
            child: Icon(
              icon,
              color: FlexoColorConstants.DRAWER_ICON_COLOR,
              size: FlexoValues.fontSize18,
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

        Divider(thickness: 1,height: FlexoValues.heightSpace1Px,color: FlexoColorConstants.LIST_BORDER_COLOR,),
      ],
    );
  }

}
