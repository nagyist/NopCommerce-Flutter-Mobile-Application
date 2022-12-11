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
import 'package:nopcommerce/Models/AddressAttributeModel.dart';
import 'package:nopcommerce/Models/AddressAttributesValuesModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Screens/Customer/Address/CreateOrUpdateAddress/CreateOrUpdateAddressProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextRadioButton.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Utils/Enum/FormType.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';

class FlexoCreateOrUpdateAddress extends StatefulWidget {
  const FlexoCreateOrUpdateAddress({Key? key}) : super(key: key);

  @override
  State<FlexoCreateOrUpdateAddress> createState() => _FlexoCreateOrUpdateAddressState();
}

class _FlexoCreateOrUpdateAddressState extends State<FlexoCreateOrUpdateAddress> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var createOrUpdateAddressProvider = context.watch<CreateOrUpdateAddressProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor:  FlexoColorConstants.BACKGROUND_COLOR,
        appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ? "" : createOrUpdateAddressProvider.formType == FormType.Create ? localResourceProvider.getResourseByKey("account.myAccount")+" - "+ localResourceProvider.getResourseByKey("account.customerAddresses.addNew") : localResourceProvider.getResourseByKey("account.myAccount")+" - "+ localResourceProvider.getResourseByKey("account.customerAddresses.edit")),
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: createOrUpdateAddressProvider.headerModel,headerLoader: createOrUpdateAddressProvider.isPageLoader),
        body: createOrUpdateAddressProvider.isPageLoader || localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :
        Column(
          children: [

            createOrUpdateAddressProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:FlexoValues.heightSpace2Px),

                            TextFieldWidget(
                              width: FlexoValues.controlsWidth,
                              controller: createOrUpdateAddressProvider.firstNameController,
                              hintText: localResourceProvider.getResourseByKey("address.fields.firstname"),
                              keyBoardType: TextInputType.name,
                              required: true,
                              errorMsg: localResourceProvider.getResourseByKey("address.fields.firstname.required"),
                              icon: Ionicons.person_outline,
                            ),

                            SizedBox(height:FlexoValues.heightSpace2Px),

                            TextFieldWidget(
                              width: FlexoValues.controlsWidth,
                              controller: createOrUpdateAddressProvider.lastNameController,
                              hintText: localResourceProvider.getResourseByKey("address.fields.lastname"),
                              keyBoardType: TextInputType.name,
                              required: true,
                              errorMsg: localResourceProvider.getResourseByKey("address.fields.lastname.required"),
                              icon: Ionicons.person_outline,
                            ),

                            SizedBox(height:FlexoValues.heightSpace2Px),

                            TextFieldWidget(
                              textFieldType: TextFieldType.Email,
                              width: FlexoValues.controlsWidth,
                              controller: createOrUpdateAddressProvider.emailController,
                              hintText: localResourceProvider.getResourseByKey("address.fields.email"),
                              keyBoardType: TextInputType.emailAddress,
                              required: true,
                              errorMsg: localResourceProvider.getResourseByKey("address.fields.email.required"),
                              errorMsgForEmail:localResourceProvider.getResourseByKey("common.wrongEmail") ,
                              icon: Ionicons.mail_outline,
                            ),

                            SizedBox(height:FlexoValues.heightSpace2Px),

                            createOrUpdateAddressProvider.addressModel.companyEnabled ?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.companyNameController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.company"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.companyRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("address.fields.company.required"),
                                  icon: Ionicons.business_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(),

                            createOrUpdateAddressProvider.addressModel.countryEnabled?
                            Column(
                              children: [
                                Container(
                                  width: FlexoValues.deviceWidth,
                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      FlexoDropDown(
                                        width: FlexoValues.controlsWidth,
                                        required: true,
                                        selectedValue: createOrUpdateAddressProvider.addressModel.countryId.toString(),
                                        items: createOrUpdateAddressProvider.addressModel.availableCountries.map((e) {
                                          return DropDownModel(text: e.text, value: e.value);
                                        }).toList(),
                                        hintText:localResourceProvider.getResourseByKey("account.fields.country") ,
                                        onChange: (value){
                                          setState((){
                                            createOrUpdateAddressProvider.addressModel.countryId = int.parse(value);
                                            createOrUpdateAddressProvider.getStateDataByCountryId(context: context, countryId: createOrUpdateAddressProvider.addressModel.countryId);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(height: 0,width: 0,),

                            createOrUpdateAddressProvider.addressModel.countryEnabled && createOrUpdateAddressProvider.addressModel.stateProvinceEnabled?
                            Column(
                              children: [
                                Container(
                                  width: FlexoValues.deviceWidth,
                                  padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FlexoDropDown(
                                          required: false,
                                          width: FlexoValues.controlsWidth,
                                          selectedValue: createOrUpdateAddressProvider.addressModel.stateProvinceId.toString(),
                                          items: createOrUpdateAddressProvider.stateDropDown,
                                          onChange: (value){
                                            createOrUpdateAddressProvider.addressModel.stateProvinceId = int.parse(value);
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(height: 0,width: 0,),

                            createOrUpdateAddressProvider.addressModel.countyEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.countyController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.county"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.countyRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("account.fields.county.required"),
                                  icon: Ionicons.location_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            )  :
                            Container(height: 0,width: 0,),

                            createOrUpdateAddressProvider.addressModel.cityEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.cityController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.city"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.cityRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("address.fields.city.required"),
                                  icon: Ionicons.location_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(height: 0,width: 0,),

                            createOrUpdateAddressProvider.addressModel.streetAddressEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.address1Controller,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.address1"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.streetAddressRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress.required"),
                                  icon: Ionicons.location_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(width: 0,),

                            createOrUpdateAddressProvider.addressModel.streetAddress2Enabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.address2Controller,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.address2"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.streetAddress2Required,
                                  errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress2.required"),
                                  icon: Ionicons.location_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(width: 0,),

                            createOrUpdateAddressProvider.addressModel.zipPostalCodeEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.zipCodeController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                                  keyBoardType: TextInputType.name,
                                  required: createOrUpdateAddressProvider.addressModel.zipPostalCodeRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("address.fields.zipPostalCode.required"),
                                  icon: Ionicons.location_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(width: 0,),

                            createOrUpdateAddressProvider.addressModel.phoneEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  textFieldType: TextFieldType.Numeric,
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.phoneNumberController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                                  keyBoardType: TextInputType.phone,
                                  required: createOrUpdateAddressProvider.addressModel.phoneRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("account.fields.phone.required"),
                                  icon: Ionicons.call_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(width: 0,),

                            createOrUpdateAddressProvider.addressModel.faxEnabled?
                            Column(
                              children: [
                                TextFieldWidget(
                                  textFieldType: TextFieldType.Numeric,
                                  width: FlexoValues.controlsWidth,
                                  controller: createOrUpdateAddressProvider.faxNumberController,
                                  hintText: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                                  keyBoardType: TextInputType.phone,
                                  required: createOrUpdateAddressProvider.addressModel.faxRequired,
                                  errorMsg: localResourceProvider.getResourseByKey("address.fields.faxNumber.required"),
                                  icon: Ionicons.keypad_outline,
                                ),
                                SizedBox(height:FlexoValues.heightSpace2Px),
                              ],
                            ):
                            Container(width: 0,),

                            SizedBox(height: FlexoValues.widthSpace2Px,),

                            customerAttributesSwitch(context: context, setState: setState, customerAttributes: createOrUpdateAddressProvider.addressModel.customAddressAttributes),

                            SizedBox(height: FlexoValues.widthSpace2Px,),

                            ButtonWidget().getButton(
                                text:localResourceProvider.getResourseByKey("common.save").toString().toUpperCase(),
                                width: FlexoValues.controlsWidth,
                                onClick: ()async{
                                  KeyboardUtil.hideKeyboard(context);
                                  if(await CheckConnectivity().checkInternet(context)){
                                    if(formKey.currentState!.validate()  ){
                                      createOrUpdateAddressProvider.buttonClickEvent(context: context);
                                    }
                                  }
                                },
                                isApiLoad: false
                            ),

                            SizedBox(height: FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  attributeHeading({required String heading, required bool isRequired})
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

  checkBoxContainer({required AddressAttribute e,required StateSetter setState,required BuildContext context})
  {
    return Container(
      width: FlexoValues.controlsWidth,
      child: Wrap(
        children: e.values.map((item) {
          return Container(
            margin: EdgeInsets.only(right:FlexoValues.widthSpace4Px ,bottom: FlexoValues.widthSpace3Px),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Transform.scale(
                    scale: FlexoValues.switchScale,
                    alignment: Alignment.centerLeft,
                    child: CupertinoSwitch(
                      onChanged: (val)
                      {
                        setState(()
                        {
                          if(e.attributeControlType != AttributeControlType.ReadonlyCheckboxes)
                          {
                            if(item.isPreSelected)
                            {
                              item.isPreSelected = false;
                            }else{
                              item.isPreSelected = true;
                            }
                          }
                        });
                      },
                      value: item.isPreSelected,
                      activeColor: e.attributeControlType == AttributeControlType.ReadonlyCheckboxes ? FlexoColorConstants.ACCENT_DE_ACTIVE_COLOR :FlexoColorConstants.ACCENT_COLOR,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child:FlexoTextWidget().headingText15(
                        text: item.name,
                        maxLines: 10,
                      )
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  radioListContainer({required AddressAttribute e,required StateSetter setState})
  {
    if(e.defaultValue==null){
      for(var i in e.values){
        if (i.isPreSelected) {
          e.defaultValue = i.id;
        }
      }
    }
    if(e.defaultValue!=null){
      for(var i in e.values){
        if(e.defaultValue==i.id){
          i.isPreSelected = true;
        }else{
          i.isPreSelected = false;
        }
      }
    }
    return Container(
      width: FlexoValues.controlsWidth,
      child: Wrap(
        children: e.values.map((item) {
          return Container(
            margin: EdgeInsets.only(right: FlexoValues.widthSpace3Px,bottom:FlexoValues.widthSpace3Px),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  e.defaultValue = item.id;
                  for(var it in e.values)
                  {
                    if(it.id == item.id)
                    {
                      it.isPreSelected = true;
                    }else{
                      it.isPreSelected = false;
                    }
                  }
                });
              },
              child:TextRadioButton().textRadioButtonComponent(isCheck: item.isPreSelected, title: item.name),
            ),
          );
        }).toList(),
      ),
    );
  }

  customerAttributesSwitch({required BuildContext context,required StateSetter setState,required List<AddressAttribute> customerAttributes})
  {
    return Container(
      width:FlexoValues.controlsWidth,
      child: Column(
        children: customerAttributes.map((e)
        {
          Widget widget = Container();
          switch(e.attributeControlType)
          {
            case AttributeControlType.DropdownList:
              if(!e.isRequired)
              {
                List<AddressAttributesValues> values = e.values.where((element) => element.id == 0).toList();
                if(values.isEmpty)
                {
                  e.values.insert(0,new AddressAttributesValues(name: "---", isPreSelected: true, id: 0, customProperties: CustomProperties()));
                }
              }
              if(e.defaultValue == null) {
                for (var it in e.values) {
                  if (it.isPreSelected) {
                    e.defaultValue = it.id;

                  }
                }
                if(e.defaultValue==null){
                  e.defaultValue= e.values[0].id;
                }
              }

              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px,),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlexoDropDown(
                                  width: FlexoValues.controlsWidth,
                                  selectedValue: e.defaultValue.toString(),
                                  items: e.values.map((value) {
                                    return DropDownModel(
                                      value: value.id.toString(),
                                      text:  value.name,
                                    );
                                  }).toList(),
                                  onChange: (value){
                                    e.defaultValue = value;
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace4Px,)
                  ],
                ),
              );

              break;

            case AttributeControlType.RadioList:
              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),

                    SizedBox(height:FlexoValues.widthSpace2Px),

                    radioListContainer(e: e, setState: setState),
                  ],
                ),
              );
              break;

            case AttributeControlType.Checkboxes:
            case AttributeControlType.ReadonlyCheckboxes:

              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace2Px,),

                    checkBoxContainer(e: e, setState: setState, context: context),
                  ],
                ),
              );
              break;

            case AttributeControlType.TextBox:

              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),

                    SizedBox(height:FlexoValues.widthSpace1Px,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        TextFieldAttributeWidgets(
                          initialValue: e.defaultValue,
                          width: FlexoValues.controlsWidth,
                          onChange: (value)
                          {
                            setState(() {
                              e.defaultValue = value;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px,)
                  ],
                ),
              );

              break;

            case AttributeControlType.MultilineTextbox:

              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px,),

                    TextFieldAttributeWidgets(
                      initialValue: e.defaultValue,
                      width: FlexoValues.controlsWidth,
                      maxLine: 5,
                      onChange: (value)
                      {
                        setState(() {
                          e.defaultValue = value;
                        });
                      },
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px,),
                  ],
                ),
              );
              break;
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace1Px),
            child: widget,
          );
        }).toList(),
      ),
    );
  }
}
