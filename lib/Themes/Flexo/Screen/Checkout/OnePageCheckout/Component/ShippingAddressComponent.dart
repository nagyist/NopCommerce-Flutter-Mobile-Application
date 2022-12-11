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
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/AddAddressRequestModel.dart';
import 'package:nopcommerce/Models/AddressAttributesValuesModel.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPickupPointsModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/AddressAttributes.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';

class ShippingAddressComponent extends StatefulWidget {
  final ScrollController scrollController;
  const ShippingAddressComponent({required this.scrollController});

  @override
  State<ShippingAddressComponent> createState() => _ShippingAddressComponentState();
}

class _ShippingAddressComponentState extends State<ShippingAddressComponent> {
  GlobalKey<FormState> newAddressFormKey = new GlobalKey<FormState>();
  Map<String, List<AddressAttributesValues>> checkBoxMap = {};
  late AddAddressRequestModel addAddressRequestModel;

  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Container(
        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
        child: IgnorePointer(
          ignoring: checkoutProvider.isAPILoader,
          child: new ExpansionTile(
            textColor: Colors.white,
            key: GlobalKey(),
            collapsedTextColor: FlexoColorConstants.DARK_TEXT_COLOR,
            backgroundColor:  FlexoColorConstants.COLLAPSE_SELECTED_COLOR,
            collapsedBackgroundColor: checkoutProvider.isShippingAddressTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            trailing: Container(width: 0,),
            initiallyExpanded: checkoutProvider.isShippingAddress,
            onExpansionChanged: (val)
            {
              checkoutProvider.shippingAddressTabExpand(context: context);
            },
            leading: Container(
              decoration: BoxDecoration(
                border: Border(
                    right:BorderSide(
                      color:Colors.white,
                    )
                ),
                color: checkoutProvider.isShippingAddress || checkoutProvider.isShippingAddressTabCompleted  ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
              ),
              width: FlexoValues.deviceWidth * 0.12,
              alignment: Alignment.center,
              child: Text(
                checkoutProvider.shippingAddressTabIndex,
                style: TextStyle(
                  color: checkoutProvider.isShippingAddress || checkoutProvider.isShippingAddressTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            title: Container(
                child: new Text(
                  localResourceProvider.getResourseByKey("enums.nop.core.domain.tax.taxBasedOn.shippingAddress"),
                  style: new TextStyle(
                    fontSize: FlexoValues.fontSize16,
                    fontWeight: FontWeight.normal,
                    color: checkoutProvider.isShippingAddress || checkoutProvider.isShippingAddressTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  ),
                )
            ),
            children: <Widget>[

              !checkoutProvider.isShippingAddressLoad ? Container() :
              Container(
                color: Colors.white,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    !checkoutProvider.isPickupPointsLoad ? Container() :
                    localResourceProvider.getSettingByName("orderSettings.displayPickupInStoreOnShippingMethodPage")=='False' && checkoutProvider.getPickupPointsModel.allowPickupInStore?
                    Container(
                      child: Column(
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
                                        checkoutProvider.isPickupPointEnable = !checkoutProvider.isPickupPointEnable;
                                      });
                                    },
                                    value: checkoutProvider.isPickupPointEnable,
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

                          SizedBox(height: FlexoValues.widthSpace2Px),

                          checkoutProvider.isPickupPointEnable?
                          Container(
                            width: FlexoValues.deviceWidth,
                            child: Column(
                              children: [

                                checkoutProvider.getPickupPointsModel.pickupPoints.length > 1 ?
                                FlexoDropDown(
                                    width: FlexoValues.controlsWidth,
                                    showRequiredIcon: false,
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
                                Container(
                                  width: FlexoValues.controlsWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: FlexoTextWidget().headingCenterText16(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].name),
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      StatefulBuilder(builder: (context, setState)
                                      {
                                        String addressList = "";

                                        if(checkoutProvider.getPickupPointsModel.pickupPoints[0].address != null)
                                        {
                                          addressList += checkoutProvider.getPickupPointsModel.pickupPoints[0].address;
                                        }

                                        if(checkoutProvider.getPickupPointsModel.pickupPoints[0].city != null)
                                        {
                                          addressList += " "+  checkoutProvider.getPickupPointsModel.pickupPoints[0].city;
                                        }

                                        if(checkoutProvider.getPickupPointsModel.pickupPoints[0].county != null)
                                        {
                                          addressList += " "+  checkoutProvider.getPickupPointsModel.pickupPoints[0].county;
                                        }

                                        if(checkoutProvider.getPickupPointsModel.pickupPoints[0].stateName != null)
                                        {
                                          addressList += " "+ checkoutProvider.getPickupPointsModel.pickupPoints[0].stateName;
                                        }

                                        if(checkoutProvider.getPickupPointsModel.pickupPoints[0].countryName != null)
                                        {
                                          addressList += " "+checkoutProvider.getPickupPointsModel.pickupPoints[0].countryName;
                                        }

                                        return Container(
                                          alignment: Alignment.center,
                                          child: FlexoTextWidget().headingCenterText16(text: addressList),
                                        );
                                      }),


                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      Container(
                                          alignment: Alignment.center,
                                          child: FlexoTextWidget().headingCenterText16(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].pickupFee,),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ): Container()
                        ],
                      ),
                    ):Container(),

                    SizedBox(height: FlexoValues.heightSpace2Px,),

                    !checkoutProvider.isPickupPointEnable?
                    Column(
                      children: [

                        Container(
                          width: FlexoValues.controlsWidth,
                          child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("checkout.selectShippingAddressOrEnterNewOne"),),
                        ),

                        checkoutProvider.getShippingAddressesModel.invalidAddresses.length > 0 ?
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                              child: FlexoTextWidget().warningMessageText(text: localResourceProvider.getResourseByKey("checkout.addresses.invalid").toString().replaceAll("{0}", (checkoutProvider.getShippingAddressesModel.invalidAddresses.length).toString()),),
                            ),
                          ],
                        ) : Container(height: FlexoValues.widthSpace3Px),

                        Container(
                          child: Column(
                            children: [
                              checkoutProvider.getShippingAddressesModel.addresses.isNotEmpty?
                              FlexoDropDown(
                                  width: FlexoValues.controlsWidth,
                                  showRequiredIcon: false,
                                  selectedValue: checkoutProvider.selectedShippingAddress,
                                  items: checkoutProvider.shippingAddressDropdownList,
                                  onChange: (val)
                                  {
                                    setState(()
                                    {
                                      checkoutProvider.firstNameShippingController.clear();
                                      checkoutProvider.lastNameShippingController.clear();
                                      checkoutProvider.emailShippingController.clear();
                                      checkoutProvider.companyNameShippingController.clear();
                                      checkoutProvider.cityShippingController.clear();
                                      checkoutProvider.countyShippingController.clear();
                                      checkoutProvider.address1ShippingController.clear();
                                      checkoutProvider.address2ShippingController.clear();
                                      checkoutProvider.zipCodeShippingController.clear();
                                      checkoutProvider.phoneNumberShippingController.clear();
                                      checkoutProvider.faxNumberShippingController.clear();
                                      checkBoxMap = {};
                                    });
                                    checkoutProvider.shippingDropdownOnChange(context: context, value: val);
                                  }
                              ):
                              Container(),

                              checkoutProvider.selectedShippingAddress == "0"?
                              SingleChildScrollView(
                                child: Form(
                                  key: newAddressFormKey,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        SizedBox(height: FlexoValues.heightSpace1Px),

                                        Divider(thickness: 1,height: 1,),

                                        SizedBox(height: FlexoValues.heightSpace1Px),

                                        TextFieldWidget(
                                          width: FlexoValues.controlsWidth,
                                          icon: Ionicons.person_outline,
                                          keyBoardType: TextInputType.name,
                                          heading: localResourceProvider.getResourseByKey("address.fields.firstname"),
                                          hintText: localResourceProvider.getResourseByKey("address.fields.firstname"),
                                          errorMsg: localResourceProvider.getResourseByKey("address.fields.firstname.required"),
                                          required: true,
                                          controller: checkoutProvider.firstNameShippingController,
                                        ),

                                        SizedBox(height: FlexoValues.heightSpace2Px),

                                        TextFieldWidget(
                                          width: FlexoValues.controlsWidth,
                                          icon: Ionicons.person_outline,
                                          keyBoardType: TextInputType.name,
                                          heading: localResourceProvider.getResourseByKey("address.fields.lastname"),
                                          hintText: localResourceProvider.getResourseByKey("address.fields.lastname"),
                                          errorMsg: localResourceProvider.getResourseByKey("address.fields.lastname.required"),
                                          required: true,
                                          controller: checkoutProvider.lastNameShippingController,
                                        ),

                                        SizedBox(height: FlexoValues.heightSpace2Px),

                                        TextFieldWidget(
                                          textFieldType: TextFieldType.Email,
                                          width: FlexoValues.controlsWidth,
                                          icon: Ionicons.mail_outline,
                                          keyBoardType: TextInputType.name,
                                          heading: localResourceProvider.getResourseByKey("address.fields.email"),
                                          hintText: localResourceProvider.getResourseByKey("address.fields.email"),
                                          errorMsg: localResourceProvider.getResourseByKey("address.fields.email.required"),
                                          errorMsgForEmail: localResourceProvider.getResourseByKey("common.wrongEmail"),
                                          required: true,
                                          controller: checkoutProvider.emailShippingController,
                                        ),

                                        SizedBox(height: FlexoValues.heightSpace2Px),

                                        checkoutProvider.getShippingAddressesModel.newAddress.companyEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.business_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.company"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.company"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.company.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.companyRequired,
                                              controller: checkoutProvider.companyNameShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ):Container(width: 0,height: 0,),

                                        checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled ?
                                        Column(
                                          children: [
                                            FlexoDropDown(
                                                width: FlexoValues.controlsWidth,
                                                required: true,
                                                selectedValue: checkoutProvider.getShippingAddressesModel.newAddress.countryId.toString(),
                                                items: checkoutProvider.getShippingAddressesModel.newAddress.availableCountries.map((e)
                                                {
                                                  return DropDownModel(text: e.text, value: e.value);
                                                }).toList(),
                                                onChange: (val)
                                                {
                                                  checkoutProvider.getShippingAddressesModel.newAddress.countryId = int.parse(val);
                                                  checkoutProvider.getShippingAddressesModel.newAddress.countryName = checkoutProvider.getShippingAddressesModel.newAddress.availableCountries.where((element) => element.value == val).first.text;
                                                  checkoutProvider.shippingStatesByCountryId(context: context, countryId: checkoutProvider.getShippingAddressesModel.newAddress.countryId);
                                                }
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ):
                                        Container(height: 0,width: 0,),

                                        checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled && checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceEnabled?
                                        Column(
                                          children: [
                                            FlexoDropDown(
                                                width: FlexoValues.controlsWidth,
                                                selectedValue: checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId.toString(),
                                                items: checkoutProvider.shippingStateDropdownList,
                                                onChange: (val)
                                                {
                                                  setState(()
                                                  {
                                                    checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId = int.parse(val);
                                                    checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceName = checkoutProvider.shippingStateDropdownList.where((element) => element.value == val).first.text;
                                                  });
                                                }
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ):
                                        Container(height: 0,width: 0,),

                                        checkoutProvider.getShippingAddressesModel.newAddress.countyEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.location_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.county"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.county"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.county.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.countyRequired,
                                              controller: checkoutProvider.countyShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(height: 0,width: 0,),

                                        checkoutProvider.getShippingAddressesModel.newAddress.cityEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.location_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.city"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.city"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.city.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.cityRequired,
                                              controller: checkoutProvider.cityShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(height: 0,width: 0,),


                                        checkoutProvider.getShippingAddressesModel.newAddress.streetAddressEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.location_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.address1"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.address1"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.address1.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.streetAddressRequired,
                                              controller: checkoutProvider.address1ShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(width: 0,),

                                        checkoutProvider.getShippingAddressesModel.newAddress.streetAddress2Enabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.location_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.address2"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.address2"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.address2.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.streetAddress2Required,
                                              controller: checkoutProvider.address2ShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(width: 0,),


                                        checkoutProvider.getShippingAddressesModel.newAddress.zipPostalCodeEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.location_outline,
                                              keyBoardType: TextInputType.name,
                                              heading: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.zipPostalCode.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.zipPostalCodeRequired,
                                              controller: checkoutProvider.zipCodeShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(width: 0,),


                                        checkoutProvider.getShippingAddressesModel.newAddress.phoneEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.phone_portrait_outline,
                                              keyBoardType: TextInputType.number,
                                              textFieldType: TextFieldType.Numeric,
                                              heading: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.phoneNumber.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.phoneRequired,
                                              controller: checkoutProvider.phoneNumberShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(width: 0,),


                                        checkoutProvider.getShippingAddressesModel.newAddress.faxEnabled ?
                                        Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.controlsWidth,
                                              icon: Ionicons.keypad_outline,
                                              keyBoardType: TextInputType.number,
                                              heading: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                                              hintText: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                                              errorMsg: localResourceProvider.getResourseByKey("address.fields.faxNumber.required"),
                                              required: checkoutProvider.getShippingAddressesModel.newAddress.faxRequired,
                                              controller: checkoutProvider.faxNumberShippingController,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px),
                                          ],
                                        ) : Container(width: 0,),

                                        SizedBox(height: FlexoValues.widthSpace2Px),

                                        CheckoutAddressAttributes(customAddressAttributes: checkoutProvider.getShippingAddressesModel.newAddress.customAddressAttributes),
                                      ],

                                    ),
                                  ),
                                ),
                              ) :
                              Container(),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace3Px),
                      ],
                    ):Container(),

                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          localResourceProvider.getSettingByName("orderSettings.disableBillingAddressCheckoutStep") == 'False' ?
                          ButtonWidget().getBackButton(
                              text: localResourceProvider.getResourseByKey("common.back").toString().toUpperCase(),
                              width: FlexoValues.deviceWidth * 0.47,
                              onClick: () async
                              {
                                checkoutProvider.shippingAddressBackButton(context: context);
                              },
                              isApiLoad: false
                          ) : Container(),


                          ButtonWidget().getButton(
                              text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                              width: FlexoValues.deviceWidth * 0.47,
                              onClick: () async
                              {
                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                if(await CheckConnectivity().checkInternet(context)){

                                  if(checkoutProvider.selectedShippingAddress == "0")
                                  {
                                    if(newAddressFormKey.currentState!.validate())
                                    {
                                      if(checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled && checkoutProvider.getShippingAddressesModel.newAddress.countryId == 0 )
                                      {
                                        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.country.required"));
                                      }
                                      else if(checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled && checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceEnabled && checkoutProvider.shippingStateDropdownList.length > 1 && checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId == 0)
                                      {
                                        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.stateProvince.required"));
                                      }else{

                                        addAddressRequestModel = AddAddressRequestModel(
                                            firstName: checkoutProvider.firstNameShippingController.text,
                                            lastName: checkoutProvider.lastNameShippingController.text,
                                            email: checkoutProvider.emailShippingController.text,
                                            company: checkoutProvider.companyNameShippingController.text,
                                            countryId: checkoutProvider.getShippingAddressesModel.newAddress.countryId,
                                            stateProvinceId: checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId,
                                            county: checkoutProvider.countyShippingController.text,
                                            city: checkoutProvider.cityShippingController.text,
                                            address1: checkoutProvider.address1ShippingController.text,
                                            address2: checkoutProvider.address2ShippingController.text,
                                            zipPostalCode: checkoutProvider.zipCodeShippingController.text,
                                            phoneNumber: checkoutProvider.phoneNumberShippingController.text,
                                            faxNumber: checkoutProvider.faxNumberShippingController.text,
                                            customerAttributes: {}
                                        );

                                        checkoutProvider.addNewShippingAddress(context: context, addAddressRequestModel: addAddressRequestModel,billingCheckBoxMap: checkBoxMap,scrollController:  widget.scrollController,isMultiCheckout: false);

                                      }
                                    }
                                  }else{

                                    if(checkoutProvider.isPickupPointEnable)
                                    {
                                      String pickupPointName = "";
                                      List<PickupPoint> pickupPoints = checkoutProvider.getPickupPointsModel.pickupPoints.where((element) => element.id == checkoutProvider.selectedPickupPoints).toList();
                                      if(pickupPoints.isNotEmpty)
                                      {
                                        pickupPointName = '${pickupPoints[0].id}___${pickupPoints[0].providerSystemName}';
                                      }else{
                                        pickupPointName = '${checkoutProvider.getPickupPointsModel.pickupPoints[0].id}___${checkoutProvider.getPickupPointsModel.pickupPoints[0].providerSystemName}';
                                      }

                                      checkoutProvider.updatePickupPointShippingMethod(context: context, shippingMethodName: "", isPickup: checkoutProvider.isPickupPointEnable, pickupPointName: pickupPointName,scrollController:  widget.scrollController,isMultiCheckout: false);
                                    }else{
                                      checkoutProvider.updateShippingAddress(context: context,addressId: int.parse(checkoutProvider.selectedShippingAddress,),scrollController:  widget.scrollController,isMultiCheckout: false);
                                    }
                                  }


                                }
                              },
                              isApiLoad: false
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.heightSpace1Px,)

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  addressAttributeHeading({required String heading, required bool isRequired})
  {
    return Container(
      width: FlexoValues.controlsWidth,
      child: RichText(
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: new TextSpan(
            text: heading,
            style: TextStyleWidget.controlsHeadingTextStyle,
            children: [
              isRequired ?
              TextSpan(
                text:" *",
                style: TextStyleWidget.controlsRequiredTextStyle,
              ) : TextSpan(),
            ]
        ),
      ),
    );
  }
}
