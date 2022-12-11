/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/GiftCardBalance/GiftCardBalanceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class FlexoGiftCardBalance extends StatelessWidget {
  const FlexoGiftCardBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> form = new GlobalKey<FormState>();

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var giftCardBalanceProvider = context.watch<GiftCardBalanceProvider>();
    return  GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ? "":localResourceProvider.getResourseByKey("account.myAccount")+" - "+localResourceProvider.getResourseByKey("pageTitle.checkGiftCardBalance")  ),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: giftCardBalanceProvider.headerModel,headerLoader:giftCardBalanceProvider.isAPILoader),
        body: giftCardBalanceProvider.isPageLoader ? Loaders.pageLoader() :  Column(
          children: [
            giftCardBalanceProvider.isAPILoader   ? Loaders.apiLoader() : Container(),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      children: [

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(height:FlexoValues.heightSpace2Px),

                              giftCardBalanceProvider.getGiftCardBalanceResponseModel.message != null && giftCardBalanceProvider.getGiftCardBalanceResponseModel.message != "" ?
                              Column(
                                children: [
                                  Container(
                                    width: FlexoValues.controlsWidth,
                                    padding: EdgeInsets.only(bottom: FlexoValues.heightSpace1Px),
                                    child: Text(
                                      giftCardBalanceProvider.getGiftCardBalanceResponseModel.message,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          color:FlexoColorConstants.ERROR_TEXT_COLOR ,
                                          fontSize:FlexoValues.fontSize15,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ) : Container(),

                              giftCardBalanceProvider.getGiftCardBalanceResponseModel.result != null && giftCardBalanceProvider.getGiftCardBalanceResponseModel.result != "" ?
                              Container(
                                width: FlexoValues.controlsWidth,
                                padding: EdgeInsets.only(bottom: FlexoValues.heightSpace1Px),
                                child: Text(
                                  localResourceProvider.getResourseByKey("shoppingCart.totals.giftCardInfo.remaining").toString().replaceAll("{0}", giftCardBalanceProvider.getGiftCardBalanceResponseModel.result),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FlexoValues.fontSize16,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              )  : Container(),

                              TextFieldWidget(
                                width: FlexoValues.controlsWidth,
                                controller: giftCardBalanceProvider.giftCodeController,
                                errorMsg:localResourceProvider.getResourseByKey("checkGiftCardBalance.giftCardCouponCode.empty"),
                                required: true,
                                hintText: localResourceProvider.getResourseByKey("shoppingCart.giftCardCouponCode.tooltip"),
                                icon: Ionicons.gift_outline,
                              ),

                              SizedBox(height:FlexoValues.heightSpace2Px),

                              ButtonWidget().getButton(text:localResourceProvider.getResourseByKey("checkGiftCard.giftCardCouponCode.button").toString().toUpperCase(), width: FlexoValues.controlsWidth,
                                  onClick: ()async{
                                    KeyboardUtil.hideKeyboard(context);
                                    if(await CheckConnectivity().checkInternet(context)){
                                      if (form.currentState!.validate()) {

                                      }
                                      giftCardBalanceProvider.buttonClickEvent(context: context, );
                                    }
                                  }, isApiLoad:giftCardBalanceProvider.isAPILoader
                              ),
                            ],
                          ),
                        )

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
