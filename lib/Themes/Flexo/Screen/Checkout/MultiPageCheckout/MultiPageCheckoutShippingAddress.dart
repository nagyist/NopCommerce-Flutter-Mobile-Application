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
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetPickupPointsModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/AddressAttributes.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProductsAndOrderTotal.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/CheckoutProgressComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextRadioButton.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class FlexoMultiPageCheckoutShippingAddress extends StatelessWidget {

  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> billingAddressFormKey = new GlobalKey<FormState>();
  final TextEditingController firstNameBillingController = new TextEditingController();
  final TextEditingController lastNameBillingController = new TextEditingController();
  final TextEditingController emailBillingController = new TextEditingController();
  final TextEditingController companyNameBillingController = new TextEditingController();
  final TextEditingController cityBillingController = new TextEditingController();
  final TextEditingController countyBillingController = new TextEditingController();
  final TextEditingController address1BillingController = new TextEditingController();
  final TextEditingController address2BillingController = new TextEditingController();
  final TextEditingController zipCodeBillingController = new TextEditingController();
  final TextEditingController phoneNumberBillingController = new TextEditingController();
  final TextEditingController faxNumberBillingController = new TextEditingController();
  final Map<String, List<AddressAttributesValues>> billingCheckBoxMap = {};
  late AddAddressRequestModel addAddressRequestModel;

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var checkoutProvider = context.watch<CheckoutProvider>();

    if(!checkoutProvider.isPageLoader && (checkoutProvider.getShippingAddressesModel.newAddress.countryId == "" || checkoutProvider.getShippingAddressesModel.newAddress.countryId == null))
    {
      checkoutProvider.getShippingAddressesModel.newAddress.countryId = int.parse(checkoutProvider.getShippingAddressesModel.newAddress.availableCountries[0].value);
      checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId = int.parse(checkoutProvider.getShippingAddressesModel.newAddress.availableStates[0].value);

      firstNameBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.firstName;
      lastNameBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.lastName;
      emailBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.email;
      companyNameBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.company;
      cityBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.city;
      countyBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.county;
      address1BillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.address1;
      address2BillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.address2;
      zipCodeBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.zipPostalCode;
      phoneNumberBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.phoneNumber;
      faxNumberBillingController.text = checkoutProvider.getShippingAddressesModel.newAddress.faxNumber;

    }

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

                        CheckoutProgressComponent(isShoppingCart: true, isAddress: true, isShipping: false, isPayment: false, isConfirm: false, isComplete: false, isShippable: checkoutProvider.isShippableProduct),

                        //Heading
                        Container(
                          width: FlexoValues.controlsWidth,
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.shippingAddress").toString().toUpperCase(),maxLines: 2),
                        ),

                        Divider(
                          thickness: 1,
                          color: FlexoColorConstants.LIST_BORDER_COLOR,
                        ),

                        localResourceProvider.getSettingByName("orderSettings.displayPickupInStoreOnShippingMethodPage")=='False' && checkoutProvider.getPickupPointsModel.allowPickupInStore?
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
                                          checkoutProvider.isPickupPointEnable = !checkoutProvider.isPickupPointEnable;
                                        });
                                      },
                                      value: checkoutProvider.isPickupPointEnable,
                                      activeColor: FlexoColorConstants.ACCENT_COLOR,
                                    ),
                                  ),

                                  SizedBox(width: FlexoValues.widthSpace1Px),

                                  Container(
                                    child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.pickupPoints"),maxLines: 2),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("checkout.pickupPoints.description")),
                            ),

                            SizedBox(height: FlexoValues.widthSpace5Px),

                          ],
                        ):Container(),

                        !checkoutProvider.isPickupPointEnable ?
                        Container(
                          child: Form(
                            key: billingAddressFormKey,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  //List Of address
                                  checkoutProvider.getShippingAddressesModel.addresses.length>0?
                                  Container(
                                    child: Column(
                                      children: [

                                        Container(
                                          width: FlexoValues.deviceWidth,
                                          padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                          child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("checkout.selectShippingAddress"),),
                                        ),

                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: checkoutProvider.getShippingAddressesModel.addresses.map((e){
                                              String addressList = "";
                                              if ( (e.cityEnabled && e.city != null) ||
                                                  (e.countyEnabled && e.county != null) ||
                                                  (e.stateProvinceEnabled && e.stateProvinceName != null) ||
                                                  (e.zipPostalCodeEnabled && e.zipPostalCode != null))
                                              {
                                                if(e.cityEnabled && (e.city != null || e.city != ""))
                                                {
                                                  addressList += e.city;
                                                  if((e.countyEnabled && e.county != null) || (e.stateProvinceEnabled && e.stateProvinceName != null) ||
                                                      (e.zipPostalCodeEnabled && e.zipPostalCode != null)) {
                                                    addressList += ",";
                                                  }
                                                }

                                                if(e.countyEnabled)
                                                {
                                                  if(e.county == null || e.county == "")
                                                  {}else{
                                                    addressList += e.county;
                                                    if(!e.stateProvinceEnabled && e.stateProvinceName == null || !e.zipPostalCodeEnabled && e.zipPostalCode == null)
                                                    {}else{
                                                      addressList += ", ";
                                                    }
                                                  }
                                                }

                                                if(e.stateProvinceEnabled && e.zipPostalCodeEnabled)
                                                {
                                                  if(e.stateProvinceName == null || e.stateProvinceName == "")
                                                  {}else{
                                                    addressList += e.stateProvinceName;
                                                    if(e.zipPostalCodeEnabled && e.zipPostalCode != null)
                                                    {
                                                      addressList += ", ";
                                                    }
                                                  }
                                                }

                                                if(e.zipPostalCodeEnabled)
                                                {
                                                  if(e.zipPostalCode == null || e.zipPostalCode == "")
                                                  {}else{
                                                    addressList += e.zipPostalCode;
                                                  }
                                                }
                                              }

                                              return Container(
                                                width: FlexoValues.deviceWidth,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    SizedBox(height: FlexoValues.widthSpace2Px),

                                                    Container(
                                                      width: FlexoValues.deviceWidth,
                                                      height: 1,
                                                      color: FlexoColorConstants.LIST_BORDER_COLOR,
                                                    ),

                                                    SizedBox(height: FlexoValues.widthSpace2Px),

                                                    Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [

                                                          Container(
                                                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                              child: FlexoTextWidget().headingBoldText16(text: '${e.firstName} ${e.lastName}',maxLines: 2),
                                                          ),

                                                          SizedBox(height: FlexoValues.widthSpace2Px),

                                                          e.email==null || e.email== "" ? Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("address.fields.email")+": " +"${e.email}",),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ),

                                                          e.phoneEnabled ? e.phoneNumber == null ? Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("address.fields.phoneNumber")+": " +"${e.phoneNumber}",),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ) : Container(),

                                                          e.faxEnabled ? e.faxNumber == null ? Container():
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                    child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("address.fields.faxNumber")+": " +"${e.faxNumber}",),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ): Container(),

                                                          e.companyEnabled ? e.company == null||e.company=='' ? Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  child: FlexoTextWidget().contentText16(text: e.company,),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ): Container(),

                                                          e.streetAddressEnabled ? e.address1 == null || e.address1=='' ?Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  child: FlexoTextWidget().contentText16(text: "${e.address1}",),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ): Container(),

                                                          e.streetAddress2Enabled ? e.address2 == null || e.address2=='' ?Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  child: FlexoTextWidget().contentText16(text: ' ${e.address2}',),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ): Container(),

                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: FlexoTextWidget().contentText16(text: addressList,),
                                                          ),

                                                          SizedBox(height: FlexoValues.heightSpace1Px),

                                                          e.countryEnabled ? e.countryName == null ? Container() :
                                                          Container(
                                                            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  child: FlexoTextWidget().contentText16(text: e.countryName,),
                                                                ),

                                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                                              ],
                                                            ),
                                                          ): Container(),

                                                          e.formattedCustomAddressAttributes == null || e.formattedCustomAddressAttributes == "" ? Container() :
                                                          Container(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                                  child: RichText(
                                                                    text: HTML.toTextSpan(
                                                                      context,
                                                                      e.formattedCustomAddressAttributes,
                                                                      defaultTextStyle: TextStyle(
                                                                        color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                        fontSize: FlexoValues.fontSize16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),

                                                          SizedBox(height: FlexoValues.heightSpace1Px),

                                                          Container(
                                                            width: FlexoValues.deviceWidth,
                                                            alignment: Alignment.center,
                                                            child: ButtonWidget().getButton(
                                                                text: localResourceProvider.getResourseByKey("checkout.billToThisAddress").toString().toUpperCase(),
                                                                width: FlexoValues.controlsWidth,
                                                                onClick: ()
                                                                {
                                                                  checkoutProvider.updateShippingAddress(context: context,addressId: e.id,scrollController:  scrollController,isMultiCheckout: true);
                                                                },
                                                                isApiLoad: false
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );

                                            }).toList(),
                                          ),
                                        ),

                                        SizedBox(height: FlexoValues.widthSpace2Px,),

                                      ],
                                    ),
                                  ):Container(),

                                  //Add new Address
                                  Container(
                                    width: FlexoValues.deviceWidth,
                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                    child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("checkout.orEnterNewAddress"),maxLines: 2),
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace1Px),

                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.person_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.firstname"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.firstname"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.firstname.required"),
                                    required: true,
                                    controller: firstNameBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),

                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.person_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.lastname"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.lastname"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.lastname.required"),
                                    required: true,
                                    controller: lastNameBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),

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
                                    controller: emailBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),

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
                                        controller: companyNameBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
                                    ],
                                  ):Container(width: 0,height: 0,),

                                  checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled ?
                                  Column(
                                    children: [
                                      FlexoDropDown(
                                          width: FlexoValues.controlsWidth,
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

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                              checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceName = checkoutProvider.billingStateDropdownList.where((element) => element.value == val).first.text;
                                            });
                                          }
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: countyBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: cityBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: address1BillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: address2BillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: zipCodeBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
                                    ],
                                  ) : Container(width: 0,),


                                  checkoutProvider.getShippingAddressesModel.newAddress.phoneEnabled ?
                                  Column(
                                    children: [
                                      TextFieldWidget(
                                        width: FlexoValues.controlsWidth,
                                        icon: Ionicons.phone_portrait_outline,
                                        keyBoardType: TextInputType.number,
                                        heading: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                                        hintText: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                                        errorMsg: localResourceProvider.getResourseByKey("address.fields.phoneNumber.required"),
                                        required: checkoutProvider.getShippingAddressesModel.newAddress.phoneRequired,
                                        controller: phoneNumberBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
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
                                        controller: faxNumberBillingController,
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace2Px,),
                                    ],
                                  ) : Container(width: 0,),

                                  SizedBox(height: FlexoValues.widthSpace2Px),

                                  CheckoutAddressAttributes(customAddressAttributes: checkoutProvider.getShippingAddressesModel.newAddress.customAddressAttributes),

                                  ButtonWidget().getButton(
                                      text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                                      width: FlexoValues.controlsWidth,
                                      onClick: () async
                                      {
                                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                        if(await CheckConnectivity().checkInternet(context)){

                                          if(billingAddressFormKey.currentState!.validate())
                                          {
                                            if(checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled && checkoutProvider.getShippingAddressesModel.newAddress.countryId == 0 )
                                            {
                                              FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.country.required"));
                                            }
                                            else if(checkoutProvider.getShippingAddressesModel.newAddress.countryEnabled && checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceEnabled && checkoutProvider.billingStateDropdownList.length > 1 && checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId == 0)
                                            {
                                              FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.stateProvince.required"));
                                            }else{

                                              addAddressRequestModel = AddAddressRequestModel(
                                                  firstName: firstNameBillingController.text,
                                                  lastName: lastNameBillingController.text,
                                                  email: emailBillingController.text,
                                                  company: companyNameBillingController.text,
                                                  countryId: checkoutProvider.getShippingAddressesModel.newAddress.countryId,
                                                  stateProvinceId: checkoutProvider.getShippingAddressesModel.newAddress.stateProvinceId,
                                                  county: countyBillingController.text,
                                                  city: cityBillingController.text,
                                                  address1: address1BillingController.text,
                                                  address2: address2BillingController.text,
                                                  zipPostalCode: zipCodeBillingController.text,
                                                  phoneNumber: phoneNumberBillingController.text,
                                                  faxNumber: faxNumberBillingController.text,
                                                  customerAttributes: {}
                                              );

                                              checkoutProvider.addNewShippingAddress(context: context, addAddressRequestModel: addAddressRequestModel,billingCheckBoxMap: billingCheckBoxMap,scrollController:  scrollController,isMultiCheckout: true);

                                            }
                                          }

                                        }
                                      },
                                      isApiLoad: false
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],

                              ),
                            ),
                          ),
                        ) :
                        Container(
                          child: Column(
                            children: [

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
                                    Column(
                                      children: [
                                        Container(
                                            child: FlexoTextWidget().contentText15(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].name,),
                                        ),
                                        Container(
                                            child: FlexoTextWidget().contentText15(text: checkoutProvider.getPickupPointsModel.pickupPoints[0].pickupFee,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("checkout.nextButton").toString().toUpperCase(),
                                  width: FlexoValues.controlsWidth,
                                  onClick: () async
                                  {
                                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                    if(await CheckConnectivity().checkInternet(context)){

                                      String pickupPointName = "";
                                      List<PickupPoint> pickupPoints = checkoutProvider.getPickupPointsModel.pickupPoints.where((element) => element.id == checkoutProvider.selectedPickupPoints).toList();
                                      if(pickupPoints.isNotEmpty)
                                      {
                                        pickupPointName = '${pickupPoints[0].id}___${pickupPoints[0].providerSystemName}';
                                      }else{
                                        pickupPointName = '${checkoutProvider.getPickupPointsModel.pickupPoints[0].id}___${checkoutProvider.getPickupPointsModel.pickupPoints[0].providerSystemName}';
                                      }

                                      checkoutProvider.updatePickupPointShippingMethod(context: context, shippingMethodName: "", isPickup: checkoutProvider.isPickupPointEnable, pickupPointName: pickupPointName,scrollController:  scrollController,isMultiCheckout: true);

                                    }
                                  },
                                  isApiLoad: false
                              ),

                            ],
                          ),
                        ),

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
