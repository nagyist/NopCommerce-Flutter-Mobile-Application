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

class CheckoutBillingAddressComponent extends StatefulWidget {

  final ScrollController scrollController;
  const CheckoutBillingAddressComponent({required this.scrollController});

  @override
  State<CheckoutBillingAddressComponent> createState() => _CheckoutBillingAddressComponentState();
}

class _CheckoutBillingAddressComponentState extends State<CheckoutBillingAddressComponent> {

  GlobalKey<FormState> billingAddressFormKey = new GlobalKey<FormState>();

  Map<String, List<AddressAttributesValues>> billingCheckBoxMap = {};
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
            collapsedBackgroundColor: checkoutProvider.isBillingAddressTabCompleted  ? FlexoColorConstants.COLLAPSE_SELECTED_COLOR : FlexoColorConstants.COLLAPSE_UNSELECTED_COLOR,
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            trailing: Container(width: 0,),
            initiallyExpanded: checkoutProvider.isBillingAddress,
            onExpansionChanged: (val)
            {
              checkoutProvider.billingAddressTabExpand(context: context);
            },
            leading: Container(
              decoration: BoxDecoration(
                border: Border(
                    right:BorderSide(
                      color:Colors.white,
                    )
                ),
                color: checkoutProvider.isBillingAddress || checkoutProvider.isBillingAddressTabCompleted  ? FlexoColorConstants.LEADING_SELECTED_COLOR : FlexoColorConstants.LEADING_UNSELECTED_COLOR,
              ),
              width: FlexoValues.deviceWidth * 0.12,
              alignment: Alignment.center,
              child: Text(
                checkoutProvider.billingAddressTabIndex,
                style: TextStyle(
                  color: checkoutProvider.isBillingAddress || checkoutProvider.isBillingAddressTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  fontSize: FlexoValues.fontSize17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            title: Container(
                child: new Text(
                  localResourceProvider.getResourseByKey("enums.nop.core.domain.tax.taxBasedOn.billingAddress"),
                  style: new TextStyle(
                    fontSize: FlexoValues.fontSize16,
                    fontWeight: FontWeight.normal,
                    color: checkoutProvider.isBillingAddress || checkoutProvider.isBillingAddressTabCompleted ? Colors.white : FlexoColorConstants.DARK_TEXT_COLOR,
                  ),
                )
            ),
            children: <Widget>[

              !checkoutProvider.isBillingAddressLoad ? Container() :
              Container(
                color: Colors.white,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    checkoutProvider.isShippableProduct ?
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
                                  checkoutProvider.shipToSameAddressEnable = !checkoutProvider.shipToSameAddressEnable;
                                });
                              },
                              value: checkoutProvider.shipToSameAddressEnable,
                              activeColor: FlexoColorConstants.ACCENT_COLOR,
                            ),
                          ),

                          SizedBox(width: FlexoValues.widthSpace2Px),

                          Container(
                            child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("checkout.shipToSameAddress"),),
                          )
                        ],
                      ),
                    ):Container(height: FlexoValues.widthSpace2Px),

                    checkoutProvider.getBillingAddressesModel.addresses.isNotEmpty?
                    Container(
                      width: FlexoValues.controlsWidth,
                      child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("checkout.selectBillingAddressOrEnterNewOne"),),
                    ):Container(),

                    checkoutProvider.getBillingAddressesModel.invalidAddresses.length > 0 ?
                    Container(
                      margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                      child: FlexoTextWidget().warningMessageText(text: localResourceProvider.getResourseByKey("checkout.addresses.invalid").toString().replaceAll("{0}", (checkoutProvider.getBillingAddressesModel.invalidAddresses.length).toString()),),
                    ) : Container(height: FlexoValues.widthSpace3Px,),

                    checkoutProvider.getBillingAddressesModel.addresses.isNotEmpty?
                    FlexoDropDown(
                        width: FlexoValues.controlsWidth,
                        showRequiredIcon: false,
                        selectedValue: checkoutProvider.selectedBillingAddress,
                        items: checkoutProvider.billingAddressDropdownList,
                        onChange: (val)
                        {
                          setState(()
                          {
                            checkoutProvider.firstNameBillingController.clear();
                            checkoutProvider.lastNameBillingController.clear();
                            checkoutProvider.emailBillingController.clear();
                            checkoutProvider.companyNameBillingController.clear();
                            checkoutProvider.cityBillingController.clear();
                            checkoutProvider.countyBillingController.clear();
                            checkoutProvider.address1BillingController.clear();
                            checkoutProvider.address2BillingController.clear();
                            checkoutProvider.zipCodeBillingController.clear();
                            checkoutProvider.phoneNumberBillingController.clear();
                            checkoutProvider.faxNumberBillingController.clear();
                            billingCheckBoxMap = {};
                          });
                          checkoutProvider.billingDropdownOnChange(context: context, value: val);
                        }
                    ):
                    Container(),

                    checkoutProvider.selectedBillingAddress == "0"?
                    SingleChildScrollView(
                      child: Form(
                        key: billingAddressFormKey,
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
                                controller: checkoutProvider.firstNameBillingController,
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
                                controller: checkoutProvider.lastNameBillingController,
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
                                controller: checkoutProvider.emailBillingController,
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px),

                              checkoutProvider.getBillingAddressesModel.newAddress.companyEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.business_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.company"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.company"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.company.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.companyRequired,
                                    controller: checkoutProvider.companyNameBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ):Container(width: 0,height: 0,),

                              checkoutProvider.getBillingAddressesModel.newAddress.countryEnabled ?
                              Column(
                                children: [
                                  FlexoDropDown(
                                      width: FlexoValues.controlsWidth,
                                      required: true,
                                      selectedValue: checkoutProvider.getBillingAddressesModel.newAddress.countryId.toString(),
                                      items: checkoutProvider.getBillingAddressesModel.newAddress.availableCountries.map((e)
                                      {
                                        return DropDownModel(text: e.text, value: e.value);
                                      }).toList(),
                                      onChange: (val)
                                      {
                                        checkoutProvider.getBillingAddressesModel.newAddress.countryId = int.parse(val);
                                        checkoutProvider.getBillingAddressesModel.newAddress.countryName = checkoutProvider.getBillingAddressesModel.newAddress.availableCountries.where((element) => element.value == val).first.text;
                                        checkoutProvider.billingStatesByCountryId(context: context, countryId: checkoutProvider.getBillingAddressesModel.newAddress.countryId);
                                      }
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ):
                              Container(height: 0,width: 0,),

                              checkoutProvider.getBillingAddressesModel.newAddress.countryEnabled && checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceEnabled?
                              Column(
                                children: [
                                  FlexoDropDown(
                                      width: FlexoValues.controlsWidth,
                                      selectedValue: checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceId.toString(),
                                      items: checkoutProvider.billingStateDropdownList,
                                      onChange: (val)
                                      {
                                        setState(()
                                        {
                                          checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceId = int.parse(val);
                                          checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceName = checkoutProvider.billingStateDropdownList.where((element) => element.value == val).first.text;
                                        });
                                      }
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ):
                              Container(height: 0,width: 0,),

                              checkoutProvider.getBillingAddressesModel.newAddress.countyEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.location_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.county"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.county"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.county.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.countyRequired,
                                    controller: checkoutProvider.countyBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(height: 0,width: 0,),

                              checkoutProvider.getBillingAddressesModel.newAddress.cityEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.location_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.city"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.city"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.city.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.cityRequired,
                                    controller: checkoutProvider.cityBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(height: 0,width: 0,),


                              checkoutProvider.getBillingAddressesModel.newAddress.streetAddressEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.location_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.address1"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.address1"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.address1.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.streetAddressRequired,
                                    controller: checkoutProvider.address1BillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(width: 0,),

                              checkoutProvider.getBillingAddressesModel.newAddress.streetAddress2Enabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.location_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.address2"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.address2"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.address2.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.streetAddress2Required,
                                    controller: checkoutProvider.address2BillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(width: 0,),


                              checkoutProvider.getBillingAddressesModel.newAddress.zipPostalCodeEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.location_outline,
                                    keyBoardType: TextInputType.name,
                                    heading: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.zipPostalCode.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.zipPostalCodeRequired,
                                    controller: checkoutProvider.zipCodeBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(width: 0,),


                              checkoutProvider.getBillingAddressesModel.newAddress.phoneEnabled ?
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
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.phoneRequired,
                                    controller: checkoutProvider.phoneNumberBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(width: 0,),


                              checkoutProvider.getBillingAddressesModel.newAddress.faxEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.controlsWidth,
                                    icon: Ionicons.keypad_outline,
                                    keyBoardType: TextInputType.number,
                                    heading: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                                    hintText: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                                    errorMsg: localResourceProvider.getResourseByKey("address.fields.faxNumber.required"),
                                    required: checkoutProvider.getBillingAddressesModel.newAddress.faxRequired,
                                    controller: checkoutProvider.faxNumberBillingController,
                                  ),

                                  SizedBox(height: FlexoValues.heightSpace2Px),
                                ],
                              ) : Container(width: 0,),

                              SizedBox(height: FlexoValues.widthSpace2Px),

                              CheckoutAddressAttributes(customAddressAttributes: checkoutProvider.getBillingAddressesModel.newAddress.customAddressAttributes),
                            ],

                          ),
                        ),
                      ),
                    ) :
                    Container(),

                    SizedBox(height: FlexoValues.widthSpace3Px),

                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonWidget().getButton(
                              text: localResourceProvider.getResourseByKey("common.continue").toString().toUpperCase(),
                              width: FlexoValues.controlsWidth * 0.45,
                              onClick: () async
                              {
                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                if(await CheckConnectivity().checkInternet(context)){

                                  if(checkoutProvider.selectedBillingAddress == "0")
                                  {
                                    if(billingAddressFormKey.currentState!.validate())
                                    {
                                      if(checkoutProvider.getBillingAddressesModel.newAddress.countryEnabled && checkoutProvider.getBillingAddressesModel.newAddress.countryId == 0 )
                                      {
                                        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.country.required"));
                                      }
                                      else if(checkoutProvider.getBillingAddressesModel.newAddress.countryEnabled && checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceEnabled && checkoutProvider.billingStateDropdownList.length > 1 && checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceId == 0)
                                      {
                                        FlushBarMessage().failedMessage(context: context, title: LocalResourceProvider().getResourseByKey("address.fields.stateProvince.required"));
                                      }else{

                                        addAddressRequestModel = AddAddressRequestModel(
                                            firstName: checkoutProvider.firstNameBillingController.text,
                                            lastName: checkoutProvider.lastNameBillingController.text,
                                            email: checkoutProvider.emailBillingController.text,
                                            company: checkoutProvider.companyNameBillingController.text,
                                            countryId: checkoutProvider.getBillingAddressesModel.newAddress.countryId,
                                            stateProvinceId: checkoutProvider.getBillingAddressesModel.newAddress.stateProvinceId,
                                            county: checkoutProvider.countyBillingController.text,
                                            city: checkoutProvider.cityBillingController.text,
                                            address1: checkoutProvider.address1BillingController.text,
                                            address2: checkoutProvider.address2BillingController.text,
                                            zipPostalCode: checkoutProvider.zipCodeBillingController.text,
                                            phoneNumber: checkoutProvider.phoneNumberBillingController.text,
                                            faxNumber: checkoutProvider.faxNumberBillingController.text,
                                            customerAttributes: {}
                                        );

                                        checkoutProvider.addNewBillingAddress(context: context, addAddressRequestModel: addAddressRequestModel,billingCheckBoxMap: billingCheckBoxMap,scrollController: widget.scrollController,isMultiCheckout: false);

                                      }
                                    }
                                  }else{
                                    checkoutProvider.updateBillingAddress(context: context,addressId: int.parse(checkoutProvider.selectedBillingAddress),shipToSameAddress: checkoutProvider.shipToSameAddressEnable,scrollController:  widget.scrollController,isMultiCheckout: false);
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
