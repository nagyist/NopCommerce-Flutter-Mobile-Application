/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Models/CustomerAttributeValueModel.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetails/TopicBlockDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldConfirmPasswordWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Utils/Enum/LoginTypeAttribute.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Customer/Login/Login.dart';
import 'package:nopcommerce/Screens/Customer/Register/RegisterProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FlexoDatePicker.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/FormErrorsWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextRadioButton.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class FlexoRegister extends StatefulWidget {
  const FlexoRegister({Key? key}) : super(key: key);

  @override
  State<FlexoRegister> createState() => _FlexoRegisterState();
}

class _FlexoRegisterState extends State<FlexoRegister> {
  final GlobalKey<FormState> form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var registerProvider = context.watch<RegisterProvider>();


    String alreadyHaveAccount = localResourceProvider.getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.alreadyHaveAccount").toString();
    List<String> alreadyHaveAccountList = alreadyHaveAccount.split('?');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("PageTitle.Register"), backButton: true),
          backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
          body: registerProvider.isPageLoader ? Loaders.pageLoader() :
          StatefulBuilder(builder: (context, setState){
            return Container(
              width: FlexoValues.deviceWidth,
              height:FlexoValues.deviceHeight,
              child: Form(
                key: form,
                child: Column(
                  children: [

                    registerProvider.isAPILoader ? Container(child: LinearProgressIndicator(color: FlexoColorConstants.LINEAR_LOADER_COLOR,),) : Container(),

                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          controller: registerProvider.scrollController,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              Column(
                                children: [
                                  SizedBox(
                                    width: FlexoValues.loginControlsWidth,
                                    child: FormErrorWidget(errors: registerProvider.errors),
                                  ),
                                  SizedBox(height: FlexoValues.widthSpace2Px,),
                                ],
                              ),

                              Container(
                                width: FlexoValues.loginControlsWidth,
                                alignment: Alignment.topLeft,
                                child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.yourPersonalDetails"),),
                              ),

                              SizedBox(height: FlexoValues.heightSpace1Px,),

                              registerProvider.getRegisterResponseModel.genderEnabled?
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width:FlexoValues.deviceWidth,
                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth * 0.075),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          width:FlexoValues.loginControlsWidth,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("account.fields.gender"),maxLines: 2),

                                              SizedBox(width: FlexoValues.widthSpace2Px,),

                                              Container(
                                                alignment: Alignment.centerRight,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: registerProvider.genderData.map((e){
                                                    return  GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          registerProvider.getRegisterResponseModel.gender = e.code;
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(left: FlexoValues.widthSpace3Px),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [

                                                            Container(
                                                                width: FlexoValues.deviceWidth*0.25,
                                                                padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: e.code == registerProvider.getRegisterResponseModel.gender ? FlexoColorConstants.ACCENT_COLOR : Colors.white,
                                                                  borderRadius: BorderRadius.zero,
                                                                  border: Border.all(
                                                                      color: e.code == registerProvider.getRegisterResponseModel.gender ? FlexoColorConstants.ACCENT_COLOR : FlexoColorConstants.THEME_COLOR,
                                                                      width: 1
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  e.name,
                                                                  maxLines: 2,
                                                                  textAlign: TextAlign.center,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: e.code == registerProvider.getRegisterResponseModel.gender ? Colors.white : FlexoColorConstants.ACCENT_COLOR,
                                                                      fontSize: FlexoValues.fontSize15,
                                                                      fontWeight: FontWeight.normal
                                                                  ),
                                                                )
                                                            )

                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.widthSpace4Px,),
                                  ],
                                ),
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.firstNameEnabled?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.loginControlsWidth,
                                    controller: registerProvider.firstNameController,
                                    heading: localResourceProvider.getResourseByKey("account.fields.firstname"),
                                    hintText: localResourceProvider.getResourseByKey("account.fields.firstname"),
                                    keyBoardType: TextInputType.name,
                                    required: registerProvider.getRegisterResponseModel.firstNameRequired,
                                    errorMsg: localResourceProvider.getResourseByKey("account.fields.firstname.required"),
                                    icon: Ionicons.person_outline,
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.lastNameEnabled ?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.loginControlsWidth,
                                    controller: registerProvider.lastNameController,
                                    heading: localResourceProvider.getResourseByKey("account.fields.lastname"),
                                    hintText: localResourceProvider.getResourseByKey("account.fields.lastname"),
                                    keyBoardType: TextInputType.name,
                                    required: registerProvider.getRegisterResponseModel.lastNameRequired,
                                    errorMsg: localResourceProvider.getResourseByKey("account.fields.lastname.required"),
                                    icon: Ionicons.person_outline,
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],
                              ) :
                              Container(),

                              registerProvider.getRegisterResponseModel.dateOfBirthEnabled ?
                              Column(
                                children: [
                                  FlexoDatePickerPlugin(
                                    context: context,
                                    pastDateEnable: true,
                                    futureDateEnable: false,
                                    width: FlexoValues.loginControlsWidth,
                                    controller: registerProvider.dateOfBirthController,
                                    required: registerProvider.getRegisterResponseModel.dateOfBirthRequired,
                                    errorMsg: localResourceProvider.getResourseByKey("account.fields.dateOfBirth.required") ,
                                    hintText: localResourceProvider.getResourseByKey("account.fields.dateOfBirth"),
                                    onClick: (val){},
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],
                              ):
                              Container(),

                              TextFieldWidget(
                                textFieldType: TextFieldType.Email,
                                width: FlexoValues.loginControlsWidth,
                                controller: registerProvider.emailController,
                                heading: localResourceProvider.getResourseByKey("account.fields.email"),
                                hintText: localResourceProvider.getResourseByKey("account.fields.email"),
                                keyBoardType: TextInputType.name,
                                required: registerProvider.getRegisterResponseModel.lastNameRequired,
                                errorMsg: localResourceProvider.getResourseByKey("account.fields.email.required"),
                                icon: Ionicons.mail_outline,
                                errorMsgForEmail: localResourceProvider.getResourseByKey("common.wrongEmail"),
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              registerProvider.getRegisterResponseModel.enteringEmailTwice?
                              Column(
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.loginControlsWidth,
                                    controller: registerProvider.confirmEmailController,
                                    heading: localResourceProvider.getResourseByKey("account.fields.confirmEmail"),
                                    hintText: localResourceProvider.getResourseByKey("account.fields.confirmEmail"),
                                    keyBoardType: TextInputType.emailAddress,
                                    required: true,
                                    errorMsg: localResourceProvider.getResourseByKey("account.fields.confirmEmail.required"),
                                    icon: Ionicons.mail_outline,
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.usernamesEnabled ?
                              Column(
                                children: [

                                  Column(
                                    children: [
                                      TextFieldWidget(
                                        width: FlexoValues.loginControlsWidth,
                                        controller: registerProvider.userNameController,
                                        heading: localResourceProvider.getResourseByKey("account.fields.username"),
                                        hintText: localResourceProvider.getResourseByKey("account.fields.username"),
                                        keyBoardType: TextInputType.name,
                                        required: true,
                                        errorMsg: localResourceProvider.getResourseByKey("account.fields.username.required"),
                                        icon: Ionicons.person_outline,
                                      ),
                                    ],
                                  ),

                                  registerProvider.getRegisterResponseModel.checkUsernameAvailabilityEnabled?
                                  Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            registerProvider.checkAvailability.isEmpty?Container():
                                            Container(
                                              width: FlexoValues.loginControlsWidth,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                registerProvider.checkAvailability,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize:FlexoValues.fontSize16,
                                                    color: registerProvider.avail ? Colors.green :Colors.red,
                                                    fontWeight: FontWeight.normal
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: FlexoValues.heightSpace2Px,),

                                            Container(
                                              width: FlexoValues.deviceWidth*0.80,
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: ()async{
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  registerProvider.checkUserNameAvailability(context: context);
                                                },
                                                child: Text(
                                                  localResourceProvider.getResourseByKey("account.checkUsernameAvailability.button"),
                                                  style: TextStyle(
                                                      fontSize: FlexoValues.fontSize16,
                                                      color: FlexoColorConstants.HIGHLIGHT_COLOR
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: FlexoValues.heightSpace2Px,),
                                    ],
                                  ):Container()
                                ],
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.companyEnabled || registerProvider.getRegisterResponseModel.displayVatNumber ?
                              Container(
                                child: Column(
                                    children: [

                                      Container(
                                        width: FlexoValues.loginControlsWidth,
                                        alignment: Alignment.topLeft,
                                        child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.companyDetails")),
                                      ),
                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      registerProvider.getRegisterResponseModel.companyEnabled?
                                      Column(
                                        children: [
                                          TextFieldWidget(
                                            width: FlexoValues.loginControlsWidth,
                                            controller: registerProvider.companyNameController,
                                            heading: localResourceProvider.getResourseByKey("account.fields.company"),
                                            hintText: localResourceProvider.getResourseByKey("account.fields.company"),
                                            keyBoardType: TextInputType.name,
                                            required: registerProvider.getRegisterResponseModel.companyRequired,
                                            errorMsg: localResourceProvider.getResourseByKey("account.fields.company.required"),
                                            icon: Ionicons.business_outline,
                                          ),
                                          SizedBox(height: FlexoValues.heightSpace2Px,),
                                        ],
                                      ) :
                                      Container(),

                                      registerProvider.getRegisterResponseModel.displayVatNumber?
                                      Container(
                                        child: Column(
                                          children: [
                                            TextFieldWidget(
                                              width: FlexoValues.loginControlsWidth,
                                              controller: registerProvider.vatNumberController,
                                              heading: localResourceProvider.getResourseByKey("account.fields.vatNumber"),
                                              hintText: localResourceProvider.getResourseByKey("account.fields.vatNumber"),
                                              keyBoardType: TextInputType.name,
                                              required: registerProvider.getRegisterResponseModel.displayVatNumber,
                                              errorMsg: localResourceProvider.getResourseByKey("account.fields.vatNumber.required"),
                                              icon: Ionicons.keypad_outline,
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace2Px,),

                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace5Px),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                localResourceProvider.getResourseByKey("account.fields.vatNumber.note"),
                                                style: TextStyle(
                                                    color: FlexoColorConstants.NOTES_TEXT_COLOR,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: FlexoValues.fontSize14
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) : Container(),
                                    ]
                                ),
                              ) : Container(),


                              registerProvider.getRegisterResponseModel.streetAddressEnabled ||
                                  registerProvider.getRegisterResponseModel.streetAddress2Enabled ||
                                  registerProvider.getRegisterResponseModel.zipPostalCodeEnabled ||
                                  registerProvider.getRegisterResponseModel.cityEnabled ||
                                  registerProvider.getRegisterResponseModel.countyEnabled ||
                                  registerProvider.getRegisterResponseModel.countryEnabled ?
                              Container(
                                child: Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.loginControlsWidth,
                                      alignment: Alignment.topLeft,
                                      child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.yourAddress")),
                                    ),
                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                    registerProvider.getRegisterResponseModel.streetAddressEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.streetAddressController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.streetAddress"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.streetAddress"),
                                          keyBoardType: TextInputType.name,
                                          required: registerProvider.getRegisterResponseModel.streetAddressRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress.required"),
                                          icon: Ionicons.location_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.streetAddress2Enabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.streetAddress2Controller,
                                          heading: localResourceProvider.getResourseByKey("account.fields.streetAddress2"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.streetAddress2"),
                                          keyBoardType: TextInputType.name,
                                          required: registerProvider.getRegisterResponseModel.streetAddress2Required,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress2.required"),
                                          icon: Ionicons.location_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.zipPostalCodeEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.zipPostalCodeController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.zipPostalCode"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.zipPostalCode"),
                                          keyBoardType: TextInputType.name,
                                          required: registerProvider.getRegisterResponseModel.zipPostalCodeRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.zipPostalCode.required"),
                                          icon: Ionicons.location_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.countyEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.countyRegionController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.county"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.county"),
                                          keyBoardType: TextInputType.name,
                                          required: registerProvider.getRegisterResponseModel.countyRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.county.required"),
                                          icon: Ionicons.location_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.cityEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.cityController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.city"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.city"),
                                          keyBoardType: TextInputType.name,
                                          required: registerProvider.getRegisterResponseModel.cityRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.city.required"),
                                          icon: Ionicons.location_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.countryEnabled ?
                                    Column(
                                      children: [
                                        FlexoDropDown(
                                          width: FlexoValues.loginControlsWidth,
                                          required: registerProvider.getRegisterResponseModel.countryRequired,
                                          selectedValue: registerProvider.getRegisterResponseModel.countryId.toString(),
                                          items: registerProvider.getRegisterResponseModel.availableCountries.map((e)
                                          {
                                            return DropDownModel(text: e.text, value: e.value);
                                          }).toList(),
                                          onChange: (value){
                                            setState(() {
                                              registerProvider.getRegisterResponseModel.countryId = int.parse(value);
                                              registerProvider.getStateDataByCountryId(context: context,countryId: registerProvider.getRegisterResponseModel.countryId);
                                            });
                                          },
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.countryEnabled && registerProvider.getRegisterResponseModel.stateProvinceEnabled ?
                                    Column(
                                      children: [
                                        FlexoDropDown(
                                          width: FlexoValues.loginControlsWidth,
                                          required: registerProvider.getRegisterResponseModel.stateProvinceRequired,
                                          selectedValue: registerProvider.getRegisterResponseModel.stateProvinceId.toString(),
                                          items: registerProvider.stateDropDown,
                                          onChange: (value){
                                            setState(() {
                                              registerProvider.getRegisterResponseModel.stateProvinceId = int.parse(value);
                                            });
                                          },
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container()
                                  ],
                                ),
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.phoneEnabled || registerProvider.getRegisterResponseModel.faxEnabled ?
                              Container(
                                child: Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.loginControlsWidth,
                                      alignment: Alignment.topLeft,
                                      child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.yourContactInformation")),
                                    ),

                                    registerProvider.getRegisterResponseModel.phoneEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          textFieldType: TextFieldType.Numeric,
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.phoneController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.phone"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.phone"),
                                          keyBoardType: TextInputType.phone,
                                          required: registerProvider.getRegisterResponseModel.phoneRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.phone.required"),
                                          icon: Ionicons.phone_portrait_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),

                                    registerProvider.getRegisterResponseModel.faxEnabled ?
                                    Column(
                                      children: [
                                        TextFieldWidget(
                                          textFieldType: TextFieldType.Numeric,
                                          width: FlexoValues.loginControlsWidth,
                                          controller: registerProvider.faxController,
                                          heading: localResourceProvider.getResourseByKey("account.fields.fax"),
                                          hintText: localResourceProvider.getResourseByKey("account.fields.fax"),
                                          keyBoardType: TextInputType.phone,
                                          required: registerProvider.getRegisterResponseModel.faxRequired,
                                          errorMsg: localResourceProvider.getResourseByKey("account.fields.fax.required"),
                                          icon: Ionicons.keypad_outline,
                                        ),
                                        SizedBox(height: FlexoValues.heightSpace2Px,),
                                      ],
                                    ):
                                    Container(),
                                  ],
                                ),
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.newsletterEnabled || registerProvider.getRegisterResponseModel.customerAttributes.length > 0 ?
                              Container(
                                child: Column(
                                  children: [

                                    Container(
                                      width: FlexoValues.loginControlsWidth,
                                      alignment: Alignment.topLeft,
                                      child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.options")),
                                    ),

                                    registerProvider.getRegisterResponseModel.newsletterEnabled ?
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: FlexoValues.loginControlsWidth,
                                            child: Row(
                                              children: [

                                                FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("account.fields.newsletter"), maxLines: 2),

                                                SizedBox(width: FlexoValues.widthSpace2Px),

                                                Transform.scale(
                                                  scale: FlexoValues.switchScale,
                                                  child: CupertinoSwitch(
                                                    onChanged: (val)
                                                    {
                                                      setState(()
                                                      {
                                                        registerProvider.getRegisterResponseModel.newsletter = !registerProvider.getRegisterResponseModel.newsletter;
                                                      });
                                                    },
                                                    value: registerProvider.getRegisterResponseModel.newsletter,
                                                    activeColor: FlexoColorConstants.ACCENT_COLOR,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          SizedBox(height: FlexoValues.widthSpace2Px,),
                                        ],
                                      ),
                                    ) : Container(),

                                    registerProvider.getRegisterResponseModel.customerAttributes.length > 0 ?
                                    Container(
                                      width: FlexoValues.controlsWidth,
                                      child: Column(
                                        children: registerProvider.getRegisterResponseModel.customerAttributes.map((e)
                                        {
                                          Widget widget = Container();

                                          switch(e.attributeControlType)
                                          {
                                            case AttributeControlType.DropdownList:

                                              if(!e.isRequired)
                                              {
                                                List<CustomerAttributeValueModel> values = e.values.where((element) => element.id == 0).toList();
                                                if(values.isEmpty)
                                                {
                                                  e.values.insert(0,new CustomerAttributeValueModel(name: "---", isPreSelected: true, id: 0, customProperties: CustomProperties()));
                                                }
                                              }

                                              if(e.defaultValue == null) {
                                                for (var it in e.values) {
                                                  if (it.isPreSelected) {
                                                    e.defaultValue = "${it.id}";
                                                  }
                                                }
                                              }

                                              if(e.values.isNotEmpty)
                                              {
                                                if(e.defaultValue == null)
                                                {
                                                  e.defaultValue="${e.values[0].id}";
                                                }
                                              }else{
                                                e.defaultValue="-1";
                                              }

                                              widget = Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [

                                                    customAttributeHeading(heading: e.name, isRequired: e.isRequired),
                                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                                    FlexoDropDown(
                                                        width: FlexoValues.loginControlsWidth,
                                                        selectedValue: e.defaultValue,
                                                        items: e.values.map((value) {
                                                          return DropDownModel(
                                                            value: value.id.toString(),
                                                            text:  value.name,
                                                          );
                                                        }).toList(),
                                                        onChange: (value){
                                                          e.defaultValue = value.toString();
                                                          List<CustomerAttributeValueModel> values = e.values.where((element) => element.name == value).toList();
                                                          if(values.isNotEmpty)
                                                          {
                                                            e.defaultValue = "${values[0].id}";
                                                          }
                                                        }
                                                    ),

                                                    SizedBox(height: FlexoValues.widthSpace3Px,)
                                                  ],
                                                ),
                                              );

                                              break;

                                            case AttributeControlType.RadioList:

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

                                              widget = Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth*0.055),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    customAttributeHeading(heading: e.name, isRequired: e.isRequired),

                                                    SizedBox(height: FlexoValues.heightSpace1Px),

                                                    Container(
                                                      width: FlexoValues.loginControlsWidth,
                                                      child: Wrap(
                                                        children: e.values.map((item) {
                                                          return Container(
                                                            margin: EdgeInsets.only(right: FlexoValues.widthSpace3Px,bottom: FlexoValues.widthSpace3Px),
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
                                                              child: TextRadioButton().textRadioButtonComponent(isCheck: item.isPreSelected, title: item.name),

                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              );

                                              break;

                                            case AttributeControlType.Checkboxes:
                                            case AttributeControlType.ReadonlyCheckboxes:

                                              widget = Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.deviceWidth*0.055),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    customAttributeHeading(heading: e.name, isRequired: e.isRequired),

                                                    SizedBox(height: FlexoValues.heightSpace2Px),

                                                    Container(
                                                      width: FlexoValues.loginControlsWidth,
                                                      child: Wrap(
                                                        children: e.values.map((item) {
                                                          return Container(
                                                            margin: EdgeInsets.only(right: FlexoValues.widthSpace4Px,bottom: FlexoValues.widthSpace3Px),
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
                                                                      activeColor: e.attributeControlType == AttributeControlType.ReadonlyCheckboxes ? FlexoColorConstants.ACCENT_DE_ACTIVE_COLOR : FlexoColorConstants.ACCENT_COLOR,
                                                                    ),
                                                                  ),

                                                                  Flexible(
                                                                    child: Container(
                                                                      child: Text(
                                                                        item.name,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 10,
                                                                        style: TextStyleWidget.controlsTextStyle,
                                                                      ),
                                                                    ),
                                                                  )

                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );

                                              break;

                                            case AttributeControlType.TextBox:

                                              widget = Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  customAttributeHeading(heading: e.name, isRequired: e.isRequired),
                                                  SizedBox(height: FlexoValues.heightSpace1Px,),
                                                  TextFieldWidget(
                                                    width: FlexoValues.loginControlsWidth,
                                                    onChange: (value)
                                                    {
                                                      setState(() {
                                                        e.defaultValue = value;
                                                      });
                                                    },
                                                  ),

                                                  SizedBox(height: FlexoValues.widthSpace4Px,)
                                                ],
                                              );

                                              break;

                                            case AttributeControlType.MultilineTextbox:

                                              widget = Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    customAttributeHeading(heading: e.name, isRequired: e.isRequired),

                                                    SizedBox(height: FlexoValues.heightSpace1Px,),

                                                    TextFieldWidget(
                                                      width: FlexoValues.loginControlsWidth,
                                                      maxLine: 5,
                                                      onChange: (value)
                                                      {
                                                        setState(() {
                                                          e.defaultValue = value;
                                                        });
                                                      },
                                                    ),

                                                    SizedBox(height: FlexoValues.widthSpace4Px,)
                                                  ],
                                                ),
                                              );

                                              break;
                                          }
                                          return Container(
                                            //margin: EdgeInsets.symmetric(vertical: ScreenSize().getWidth()*0.01),
                                            child: widget,
                                          );
                                        }).toList(),
                                      ),
                                    ):Container(),
                                  ],
                                ),
                              ):
                              Container(),

                              registerProvider.getRegisterResponseModel.allowCustomersToSetTimeZone ?
                              Column(
                                children: [

                                  Container(
                                    width: FlexoValues.loginControlsWidth,
                                    alignment: Alignment.topLeft,
                                    child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.preferences")),
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace1Px,),
                                  FlexoDropDown(
                                    width: FlexoValues.loginControlsWidth,
                                    selectedValue: registerProvider.getRegisterResponseModel.timeZoneId,
                                    items: registerProvider.getRegisterResponseModel.availableTimeZones.map((e)
                                    {
                                      return DropDownModel(text: e.text, value: e.value);
                                    }).toList(),
                                    onChange: (value){
                                      setState(() {
                                        registerProvider.getRegisterResponseModel.timeZoneId = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: FlexoValues.heightSpace2Px,),
                                ],
                              ):
                              Container(),

                              Container(
                                width: FlexoValues.loginControlsWidth,
                                alignment: Alignment.topLeft,
                                child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.yourPassword")),
                              ),
                              SizedBox(height: FlexoValues.heightSpace1Px,),
                              TextFieldWidget(
                                textFieldType: TextFieldType.Password,
                                width: FlexoValues.loginControlsWidth,
                                controller: registerProvider.passwordController,
                                heading: localResourceProvider.getResourseByKey("account.fields.password"),
                                hintText: localResourceProvider.getResourseByKey("account.fields.password"),
                                keyBoardType: TextInputType.name,
                                required: true,
                                errorMsg: localResourceProvider.getResourseByKey("account.fields.confirmPassword.required"),
                                icon: Ionicons.lock_open_outline,
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              TextFieldConfirmPasswordWidget(
                                width: FlexoValues.loginControlsWidth,
                                controller: registerProvider.confirmPasswordController,
                                controller2: registerProvider.passwordController,
                                heading: localResourceProvider.getResourseByKey("account.fields.password"),
                                hintText: localResourceProvider.getResourseByKey("account.fields.password"),
                                keyBoardType: TextInputType.name,
                                required: true,
                                isPassword: true,
                                errorMsg: localResourceProvider.getResourseByKey("account.fields.confirmPassword.required"),
                                errorMsgConfirmPassword: localResourceProvider.getResourseByKey("account.fields.password.enteredPasswordsDoNotMatch"),
                                icon: Ionicons.lock_open_outline,
                              ),

                              SizedBox(height: FlexoValues.heightSpace2Px,),

                              registerProvider.getRegisterResponseModel.acceptPrivacyPolicyEnabled || registerProvider.getRegisterResponseModel.gdprConsents.length > 0 ?
                              Container(
                                width: FlexoValues.loginControlsWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Container(
                                      width: FlexoValues.loginControlsWidth,
                                      alignment: Alignment.topLeft,
                                      child: FlexoTextWidget().headingBoldText15(text: localResourceProvider.getResourseByKey("account.userAgreement")),
                                    ),

                                    registerProvider.getRegisterResponseModel.acceptPrivacyPolicyEnabled?
                                    Container(
                                      width: FlexoValues.loginControlsWidth,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Transform.scale(
                                            scale: FlexoValues.switchScale,
                                            child: CupertinoSwitch(
                                              onChanged: (val)
                                              {
                                                setState(()
                                                {
                                                  registerProvider.privacyPolicy = !registerProvider.privacyPolicy;
                                                });
                                              },
                                              value: registerProvider.privacyPolicy,
                                              activeColor: FlexoColorConstants.ACCENT_COLOR,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
                                              child:RichText(
                                                text: TextSpan(
                                                    text:localResourceProvider.getResourseByKey("account.fields.acceptPrivacyPolicy")+" ",
                                                    style: TextStyle(
                                                        color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                        fontSize: FlexoValues.fontSize16
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:localResourceProvider.getResourseByKey("checkout.termsOfService.read"),
                                                          style: TextStyleWidget.redirectTextStyle16,
                                                          recognizer: TapGestureRecognizer()
                                                            ..onTap = () {
                                                              setState(()
                                                              {
                                                                if(registerProvider.getRegisterResponseModel.acceptPrivacyPolicyPopup)
                                                                {
                                                                  DialogBoxWidget().informationDialogBox(
                                                                      context: context,
                                                                      title: registerProvider.getTopicBlockModel.title,
                                                                      body: registerProvider.getTopicBlockModel.body,
                                                                      heading: localResourceProvider.getResourseByKey("account.fields.acceptPrivacyPolicy")
                                                                  );

                                                                }else{
                                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetails(topicTitle: registerProvider.getTopicBlockModel.title,topicBody: registerProvider.getTopicBlockModel.body)));
                                                                }

                                                              });
                                                            }
                                                      )
                                                    ]
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ) : Container(),

                                    registerProvider.getRegisterResponseModel.gdprConsents.length > 0 ?
                                    Container(
                                      child: Column(
                                        children: [

                                          SizedBox(height: FlexoValues.widthSpace2Px,),

                                          Container(
                                            width: FlexoValues.loginControlsWidth,
                                            child: Column(
                                              children: registerProvider.getRegisterResponseModel.gdprConsents.map((e)
                                              {
                                                return Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [

                                                            Transform.scale(
                                                              scale: FlexoValues.switchScale,
                                                              child: CupertinoSwitch(
                                                                onChanged: (val)
                                                                {
                                                                  setState(()
                                                                  {
                                                                    e.accepted = !e.accepted;
                                                                  });
                                                                },
                                                                value: e.accepted,
                                                                activeColor: FlexoColorConstants.ACCENT_COLOR,
                                                              ),
                                                            ),

                                                            Expanded(
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
                                                                  child: Text(
                                                                    e.message,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 20,
                                                                    style: TextStyle(
                                                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                      fontSize: FlexoValues.fontSize16,
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                  )

                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(height: FlexoValues.widthSpace2Px,),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ) :  Container()

                                  ],
                                ),
                              ):
                              Container(),

                              SizedBox(height: FlexoValues.widthSpace4Px,),

                              ButtonWidget().getButton(
                                  text: localResourceProvider.getResourseByKey("account.register.button").toString().toUpperCase(),
                                  width: FlexoValues.loginControlsWidth,
                                  isApiLoad: false,
                                  onClick: () async
                                  {
                                    KeyboardUtil.hideKeyboard(context);
                                    if (registerProvider.isAPILoader) {
                                      FlushBarMessage().warningMessage(context: context, title: StringConstants.API_LOADER_MESSAGE);
                                    } else {
                                      if (registerProvider.getRegisterResponseModel.acceptPrivacyPolicyEnabled && !registerProvider.privacyPolicy) {
                                        FlushBarMessage().warningMessage(context: context, title: localResourceProvider.getResourseByKey("account.fields.acceptPrivacyPolicy.required"));
                                      } else {
                                        if (form.currentState!.validate()) {
                                          registerProvider.registerButtonClickEvent(context, LoginTypeAttribute.Login);
                                        }
                                      }
                                    }
                                  }),

                              SizedBox(height: FlexoValues.widthSpace4Px,),

                              Container(
                                child:RichText(
                                  text: TextSpan(
                                      text: alreadyHaveAccountList[0]+"? ",
                                      style: TextStyleWidget.contentTextStyle15,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: alreadyHaveAccountList[1],
                                            style: TextStyleWidget.redirectTextStyle16,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                setState(()
                                                {
                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: Login(loginType: -1,)));
                                                });
                                              }
                                        )
                                      ]
                                  ),
                                ),
                              ),

                              SizedBox(height: FlexoValues.heightSpace4Px,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            );
          })

      ),
    );
  }

  customAttributeHeading({required String heading, required bool isRequired})
  {
    return Container(
      width: FlexoValues.loginControlsWidth,
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