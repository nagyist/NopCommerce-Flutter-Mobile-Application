/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPickupPointsModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProductsAndOrderTotal.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';

class FlexoMultiPageCheckoutShippingMethod extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.checkout"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: checkoutProvider.isPageLoader ? Loaders.pageLoader() :
        StatefulBuilder(builder: (context, setState){
          return Column(
            children: [

              checkoutProvider.isAPILoader ? Loaders.apiLoader() : Container(),

              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [

                        CheckoutProgressComponent(isShoppingCart: true, isAddress: true, isShipping: true, isPayment: false, isConfirm: false, isComplete: false, isShippable: checkoutProvider.isShippableProduct),

                        //Heading
                        Container(
                          width: FlexoValues.controlsWidth,
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.shippingMethod").toString().toUpperCase(),maxLines: 2),
                        ),

                        Divider(
                          thickness: 1,
                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                        ),

                        localResourceProvider.getSettingByName("orderSettings.displayPickupInStoreOnShippingMethodPage")=='True' && checkoutProvider.getPickupPointsModel.allowPickupInStore ?
                        Column(
                          children: [

                            Container(
                              margin:EdgeInsets.all(FlexoValues.widthSpace2Px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.scale(
                                    scale: FlexoValues.switchScale,
                                    child: CupertinoSwitch(
                                      onChanged: (val)
                                      {
                                        setState(()
                                        {
                                          checkoutProvider.getPickupPointsModel.pickupInStore = !checkoutProvider.getPickupPointsModel.pickupInStore;
                                        });
                                      },
                                      value: checkoutProvider.getPickupPointsModel.pickupInStore,
                                      activeColor: FlexoColorConstants.ACCENT_COLOR,
                                    ),
                                  ),

                                  SizedBox(width: FlexoValues.widthSpace1Px),

                                  Container(
                                    child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("checkout.pickupPoints"),maxLines: 2),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              child: Text(
                                localResourceProvider.getResourseByKey("checkout.pickupPoints.description"),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: FlexoValues.fontSize15,
                                  color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                ),
                              ),
                            ),

                            SizedBox(height: FlexoValues.widthSpace5Px),

                            checkoutProvider.getPickupPointsModel.pickupInStore ?
                            Container(
                              width: FlexoValues.deviceWidth,
                              child: Column(
                                children: [

                                  checkoutProvider.getPickupPointsModel.pickupPoints.length > 1 ?
                                  FlexoDropDown(
                                      width: FlexoValues.controlsWidth,
                                      selectedValue: checkoutProvider.selectedPickupPoints,
                                      items: checkoutProvider.getPickupPointsModel.pickupPoints.map((e)
                                      {
                                        String addressLine ="";

                                        if(e.name != null && e.name != "")
                                        {
                                          addressLine += e.name+", ";
                                        }
                                        if(e.address != null && e.address != "")
                                        {
                                          addressLine += e.address+", ";
                                        }
                                        if(e.city != null && e.city != "")
                                        {
                                          addressLine += e.city+", ";
                                        }
                                        if(e.county != null && e.county != "")
                                        {
                                          addressLine += e.county+", ";
                                        }
                                        if(e.stateName != null && e.stateName != "")
                                        {
                                          addressLine += e.stateName+", ";
                                        }
                                        if(e.countryName != null && e.countryName != "")
                                        {
                                          addressLine += e.countryName+", ";
                                        }
                                        if(e.pickupFee != null && e.pickupFee != "")
                                        {
                                          addressLine += e.pickupFee;
                                        }
                                        return DropDownModel(text: addressLine, value: e.id);
                                      }).toList(),
                                      onChange: (val)
                                      {
                                        checkoutProvider.pickupPointDropdownOnChange(context: context, value: val);
                                      }
                                  ) :
                                  Column(
                                    children: [
                                      Container(
                                          child: Text(
                                            checkoutProvider.getPickupPointsModel.pickupPoints[0].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FlexoValues.fontSize16,
                                                fontWeight: FontWeight.normal),
                                          )
                                      ),
                                      Container(
                                          child: Text(
                                            checkoutProvider.getPickupPointsModel.pickupPoints[0].pickupFee,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FlexoValues.fontSize16,
                                                fontWeight: FontWeight.normal),
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ) : Container()
                          ],
                        ):Container(),

                        !checkoutProvider.getPickupPointsModel.pickupInStore && checkoutProvider.getShippingMethodsModel.shippingMethods.isNotEmpty?
                        Column(
                          children: checkoutProvider.getShippingMethodsModel.shippingMethods.map((e){
                            return GestureDetector(
                              onTap: ()
                              {
                                setState(() {
                                  for(var it in checkoutProvider.getShippingMethodsModel.shippingMethods)
                                  {
                                    it.selected = false;
                                  }
                                  e.selected = true;
                                  checkoutProvider.selectedShippingMethodName = '${e.name}___${e.shippingRateComputationMethodSystemName}';
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: FlexoValues.deviceWidth * 0.1,
                                          height: FlexoValues.deviceWidth * 0.15,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                          child: Container(
                                            child: Icon(
                                              e.selected ? Icons.radio_button_checked : Icons.radio_button_off_outlined,
                                              color: e.selected ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                              size: FlexoValues.iconSize20,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: FlexoValues.deviceWidth * 0.8,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: FlexoValues.deviceWidth * 0.8,
                                                child: FlexoTextWidget().headingBoldText16(text: '${e.name} (${e.fee})',maxLines: 2),
                                              ),

                                              SizedBox(height: FlexoValues.widthSpace1Px),
                                              Container(
                                                width: FlexoValues.deviceWidth * 0.8,
                                                child: FlexoTextWidget().contentText15(text: e.description,maxLines: 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList() ,
                        ) :
                        Container(
                            width: FlexoValues.deviceWidth,
                            alignment:Alignment.center,
                            child: checkoutProvider.getShippingMethodsModel.warnings.isNotEmpty ? Text(
                                checkoutProvider.getShippingMethodsModel.warnings.map((e){
                                  return e;
                                }).toString(),
                                style:TextStyle(
                                  fontSize: FlexoValues.fontSize15,
                                  color:Colors.red,
                                )
                            ) :Container()
                        ),

                        ButtonWidget().getButton(
                            text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                            width: FlexoValues.controlsWidth,
                            onClick: () async
                            {
                              String pickupPointName = "";
                              if(checkoutProvider.getPickupPointsModel.pickupInStore)
                              {
                                setState((){
                                  List<PickupPoint> pickupPoints = checkoutProvider.getPickupPointsModel.pickupPoints.where((element) => element.id == checkoutProvider.selectedPickupPoints).toList();
                                  if(pickupPoints.isNotEmpty)
                                  {
                                    pickupPointName = '${pickupPoints[0].id}___${pickupPoints[0].providerSystemName}';
                                  }else{
                                    pickupPointName = '${checkoutProvider.getPickupPointsModel.pickupPoints[0].id}___${checkoutProvider.getPickupPointsModel.pickupPoints[0].providerSystemName}';
                                  }
                                });
                              }
                              checkoutProvider.updateShippingMethod(context: context, shippingMethodName: checkoutProvider.selectedShippingMethodName, isPickup: checkoutProvider.getPickupPointsModel.pickupInStore, pickupPointName: pickupPointName,scrollController:  scrollController,isMultiCheckout: true);
                            },
                            isApiLoad: false
                        ),

                        SizedBox(height: FlexoValues.heightSpace2Px,),

                        CheckoutProductsAndOrderTotal(),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

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
