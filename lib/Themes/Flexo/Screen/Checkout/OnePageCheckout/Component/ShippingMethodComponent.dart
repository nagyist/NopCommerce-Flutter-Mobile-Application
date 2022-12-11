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
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';

class ShippingMethodComponent extends StatelessWidget {
  final ScrollController scrollController;
  const ShippingMethodComponent({required this.scrollController});

  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return StatefulBuilder(
      builder: (context, setState)
      {
        return Container(
          margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
          child: IgnorePointer(
            ignoring: checkoutProvider.isAPILoader,
            child: new ExpansionTile(
              textColor: Colors.white,
              collapsedTextColor: FlexoColorConstants.DARK_TEXT_COLOR,
              key: GlobalKey(),
              backgroundColor: FlexoColorConstants.COLLAPSE_SELECTED_COLOR,
              collapsedBackgroundColor: checkoutProvider.isShippingMethodTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              initiallyExpanded:  checkoutProvider.isShippingMethod,
              trailing: Container(width: 0,),
              onExpansionChanged: (val)
              {
                checkoutProvider.shippingMethodTabExpand(context: context);
              },
              leading: Container(
                decoration: BoxDecoration(
                  border: Border(
                      right:BorderSide(
                        color:Colors.white,
                      )
                  ),
                  color: checkoutProvider.isShippingMethod || checkoutProvider.isShippingMethodTabCompleted ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
                ),
                width: FlexoValues.deviceWidth * 0.12,
                alignment: Alignment.center,
                child: Text(
                  checkoutProvider.shippingMethodTabIndex,
                  style: TextStyle(
                    color: checkoutProvider.isShippingMethod || checkoutProvider.isShippingMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                    fontSize: FlexoValues.fontSize17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              title: Container(
                  child: new Text(
                    localResourceProvider.getResourseByKey("checkout.shippingMethod"),
                    style: new TextStyle(
                      fontSize: FlexoValues.fontSize16,
                      fontWeight: FontWeight.normal,
                      color: checkoutProvider.isShippingMethod || checkoutProvider.isShippingMethodTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                    ),
                  )
              ),
              children: <Widget>[

                !checkoutProvider.isShippingMethodsLoad ? Container() :
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [

                      !checkoutProvider.isPickupPointsLoad ? Container() :
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
                                  child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("checkout.pickupPoints"),),
                                )
                              ],
                            ),
                          ),

                          Container(
                            child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("checkout.pickupPoints.description"),),
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
                                        child: FlexoTextWidget().headingText16(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].name,),
                                    ),

                                    Container(
                                        child: FlexoTextWidget().headingText16(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].pickupFee,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ) : Container()
                        ],
                      ):Container(),

                      SizedBox(height: FlexoValues.heightSpace2Px),

                      checkoutProvider.getShippingMethodsModel.shippingMethods.isNotEmpty?
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
                                              child: FlexoTextWidget().contentText16(text: e.description,),
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
                          child: checkoutProvider.getShippingMethodsModel.warnings.isNotEmpty ?
                          Text(
                              checkoutProvider.getShippingMethodsModel.warnings.map((e){
                                return e;
                              }).toString(),
                              style:TextStyle(
                                fontSize: FlexoValues.fontSize15,
                                color:Colors.red,
                              )
                          ) :Container()
                      ),

                      SizedBox(height: FlexoValues.widthSpace3Px),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            ButtonWidget().getBackButton(
                                text: localResourceProvider.getResourseByKey("common.back").toString().toUpperCase(),
                                width: FlexoValues.deviceWidth * 0.47,
                                onClick: ()
                                {
                                  checkoutProvider.shippingMethodBackButton(context: context,scrollController:  scrollController);
                                },
                                isApiLoad: false
                            ),

                            ButtonWidget().getButton(
                                text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                                width: FlexoValues.deviceWidth * 0.47,
                                onClick: ()
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

                                  checkoutProvider.updateShippingMethod(context: context, shippingMethodName: checkoutProvider.selectedShippingMethodName, isPickup: checkoutProvider.getPickupPointsModel.pickupInStore, pickupPointName: pickupPointName,scrollController:  scrollController,isMultiCheckout: false);
                                },
                                isApiLoad: false
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: FlexoValues.widthSpace2Px,
                      )

                    ],

                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}
