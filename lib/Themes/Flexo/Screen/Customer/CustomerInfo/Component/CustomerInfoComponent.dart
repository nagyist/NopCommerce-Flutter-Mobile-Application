/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:nopcommerce/Models/CustomProperties.dart';
// import 'package:nopcommerce/Models/CustomerAttributeModel.dart';
// import 'package:nopcommerce/Models/CustomerAttributeValueModel.dart';
// import 'package:nopcommerce/Screens/Customer/CustomerInfo/CustomerInfoProvider.dart';
// import 'package:nopcommerce/Screens/Customer/Register/RegisterProvider.dart';
// import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
// import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
// import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/FlexoDatePicker.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/HeadingWidget.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/TextRadioButton.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
// import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
// import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
// import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
// import 'package:nopcommerce/Utils/hide_keyboard.dart';
// import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
// import 'package:provider/provider.dart';
//
// class CustomerInfoComponent{
//
//   attributeHeading({required String heading, required bool isRequired})
//   {
//     return Container(
//       width: FlexoValues.controlsWidth,
//       child: RichText(
//         textAlign: TextAlign.start,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         text: new TextSpan(
//             text: heading,
//             style: TextStyleWidget.controlsHeadingTextStyle,
//             children: [
//               isRequired ?
//               TextSpan(
//                 text:" *",
//                 style: TextStyleWidget.controlsRequiredTextStyle,
//               ) : TextSpan(),
//             ]
//         ),
//       ),
//     );
//   }
//
//   checkBoxContainer({required CustomerAttributeModel e,required StateSetter setState,required BuildContext context})
//   {
//      var customerInfoProvider = context.watch<CustomerInfoProvider>();
//       return Container(
//         width: FlexoValues.controlsWidth,
//         child: Wrap(
//           children: e.values.map((item) {
//             return Container(
//               margin: EdgeInsets.only(right:FlexoValues.widthSpace4Px ,bottom: FlexoValues.widthSpace3Px),
//               child: Container(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     Transform.scale(
//                       scale: FlexoValues.switchScale,
//                       alignment: Alignment.centerLeft,
//                       child: CupertinoSwitch(
//                         onChanged: (val)
//                         {
//                           setState(()
//                           {
//                             if(e.attributeControlType != AttributeControlType.ReadonlyCheckboxes)
//                             {
//                               if(item.isPreSelected)
//                               {
//                                 item.isPreSelected = false;
//                               }else{
//                                 item.isPreSelected = true;
//                               }
//
//                               customerInfoProvider.checkList=[];
//                               customerInfoProvider.checkList = e.values;
//                               customerInfoProvider.checkBoxMap[e.name] = e.values;
//                             }
//                           });
//                         },
//                         value: item.isPreSelected,
//                         activeColor: e.attributeControlType == AttributeControlType.ReadonlyCheckboxes ? FlexoColorConstants.ACCENT_DE_ACTIVE_COLOR : FlexoColorConstants.ACCENT_COLOR,
//                       ),
//                     ),
//                     Flexible(
//                       child: Container(
//                         child: Text(
//                           item.name,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 10,
//                           style: TextStyle(
//                               fontSize: 15,
//                               color: FlexoColorConstants.DARK_TEXT_COLOR,
//                               fontWeight: FontWeight.normal
//                           ),
//                         ),
//                       ),
//                     )
//
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     }
//
//   radioListContainer({required CustomerAttributeModel e,required StateSetter setState})
//   {
//     if(e.defaultValue==null){
//       for(var i in e.values){
//         if (i.isPreSelected) {
//           e.defaultValue = i.id;
//         }
//       }
//     }
//     if(e.defaultValue!=null){
//       for(var i in e.values){
//         if(e.defaultValue==i.id){
//           i.isPreSelected = true;
//         }else{
//           i.isPreSelected = false;
//         }
//       }
//     }
//
//     return Container(
//       width: FlexoValues.controlsWidth,
//       child: Wrap(
//         children: e.values.map((item) {
//           return Container(
//             margin: EdgeInsets.only(right: FlexoValues.widthSpace3Px,bottom:FlexoValues.widthSpace3Px),
//             child: GestureDetector(
//               onTap: (){
//                 setState(() {
//                   e.defaultValue = item.id;
//                   for(var it in e.values)
//                   {
//                     if(it.id == item.id)
//                     {
//                       it.isPreSelected = true;
//                     }else{
//                       it.isPreSelected = false;
//                     }
//                   }
//                 });
//               },
//               child: TextRadioButton().textRadioButtonComponent(isCheck: item.isPreSelected, title: item.name),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   customerAttributesSwitch({required BuildContext context,required StateSetter setState,required List<CustomerAttributeModel> customerAttributes})
//   {
//      return Container(
//        width: FlexoValues.controlsWidth,
//        child: Column(
//          children: customerAttributes.map((e)
//          {
//            Widget widget = Container();
//            switch(e.attributeControlType)
//            {
//              case AttributeControlType.DropdownList:
//                if(!e.isRequired)
//                {
//                  List<CustomerAttributeValueModel> values = e.values.where((element) => element.id == 0).toList();
//                  if(values.isEmpty)
//                  {
//                    e.values.insert(0,new CustomerAttributeValueModel(name: "---", isPreSelected: true, id: 0, customProperties: CustomProperties()));
//                  }
//                }
//                if(e.defaultValue == null) {
//                  for (var it in e.values) {
//                    if (it.isPreSelected) {
//                      e.defaultValue = "${it.id}";
//                    }
//                  }
//                }
//                if(e.values.isNotEmpty)
//                {
//                  if(e.defaultValue == null)
//                  {
//                    e.defaultValue="${e.values[0].id}";
//                  }
//                }else{
//                  e.defaultValue="-1";
//                }
//
//
//                widget = Container(
//
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),
//
//                      SizedBox(height: FlexoValues.widthSpace1Px,),
//
//                      Container(
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: [
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                FlexoDropDown(
//                                    width: FlexoValues.controlsWidth,
//                                    selectedValue: e.defaultValue,
//                                    items: e.values.map((value) {
//                                      return DropDownModel(
//                                        value: value.id.toString(),
//                                        text:  value.name,
//                                      );
//                                    }).toList(),
//                                    onChange: (value){
//                                      e.defaultValue = value.toString();
//                                      List<CustomerAttributeValueModel> values = e.values.where((element) => element.name == value).toList();
//                                      if(values.isNotEmpty)
//                                      {
//                                        e.defaultValue = "${values[0].id}";
//                                      }
//                                    }
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//
//                      SizedBox(height: FlexoValues.widthSpace4Px,)
//                    ],
//                  ),
//                );
//                break;
//
//              case AttributeControlType.RadioList:
//
//                widget = Container(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),
//
//                      SizedBox(height:FlexoValues.widthSpace2Px),
//
//                      radioListContainer(e: e, setState: setState),
//                    ],
//                  ),
//                );
//                break;
//
//              case AttributeControlType.Checkboxes:
//              case AttributeControlType.ReadonlyCheckboxes:
//
//                widget = Container(
//
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),
//
//                      SizedBox(height: FlexoValues.widthSpace2Px,),
//
//                      checkBoxContainer(e: e, setState: setState, context: context),
//
//                    ],
//                  ),
//                );
//                break;
//
//              case AttributeControlType.TextBox:
//
//                widget = Container(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),
//                      SizedBox(height:FlexoValues.widthSpace1Px,),
//
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//
//                          TextFieldAttributeWidgets(
//                            initialValue: e.defaultValue,
//                            width: FlexoValues.controlsWidth,
//                            onChange: (value)
//                            {
//                              e.defaultValue = value;
//                            },
//                          ),
//                        ],
//                      ),
//
//                      SizedBox(height: FlexoValues.widthSpace2Px,)
//                    ],
//                  ),
//                );
//                break;
//
//              case AttributeControlType.MultilineTextbox:
//
//                widget = Container(
//
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      attributeHeading(heading: e.name == null ? e.name : e.name, isRequired: e.isRequired),
//
//                      SizedBox(height: FlexoValues.widthSpace1Px,),
//
//                      TextFieldAttributeWidgets(
//                        initialValue: e.defaultValue,
//                        width: FlexoValues.controlsWidth,
//                        maxLine: 5,
//                        onChange: (value)
//                        {
//                          e.defaultValue = value;
//                        },
//                      ),
//
//                      SizedBox(height: FlexoValues.widthSpace2Px,),
//                    ],
//                  ),
//                );
//                break;
//            }
//            return Container(
//              margin: EdgeInsets.symmetric(vertical:FlexoValues.widthSpace1Px),
//              child: widget,
//            );
//          }).toList(),
//        ),
//      );
//    }
//
//   getCustomerInfoComponent({required BuildContext context})
//   {
//     var localResourceProvider = context.watch<LocalResourceProvider>();
//     var customerInfoProvider = context.watch<CustomerInfoProvider>();
//     var registerProvider = context.watch<RegisterProvider>();
//
//     return StatefulBuilder(
//       builder: (context, setState)
//       {
//         return Column(
//           children: [
//             Form(
//               key: form,
//               child: Container(
//                 width: FlexoValues.deviceWidth,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     dynamicHeadingText(localResourceProvider.getResourseByKey("account.yourPersonalDetails")),
//
//                     customerInfoProvider.userInformationResponseModel.genderEnabled?
//                     Container(
//                       child: Column(
//                         children: [
//                           Container(
//                             width: FlexoValues.deviceWidth,
//                             margin: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Container(
//                                 width:FlexoValues.controlsWidth,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//
//                                     Container(
//                                         child: FlexoTextWidget().headingText17(
//                                           text: localResourceProvider.getResourseByKey("account.fields.gender"),
//                                         )
//                                     ),
//
//                                     SizedBox(width: FlexoValues.widthSpace2Px,),
//
//                                     Container(
//                                       alignment: Alignment.centerRight,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: customerInfoProvider.genderData.map((e){
//                                           return  GestureDetector(
//                                             onTap: (){
//                                               setState((){
//                                                 customerInfoProvider.userInformationResponseModel.gender=e.code;
//                                               });
//                                             },
//                                             child: Container(
//                                               margin: EdgeInsets.only(right:FlexoValues.widthSpace3Px),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//
//                                                   Container(
//                                                       width: FlexoValues.deviceWidth*0.25,
//                                                       padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
//                                                       alignment: Alignment.center,
//                                                       decoration: BoxDecoration(
//                                                         color: e.code == customerInfoProvider.userInformationResponseModel.gender ? FlexoColorConstants.ACCENT_COLOR : Colors.white,
//                                                         borderRadius: BorderRadius.zero,
//                                                         border: Border.all(
//                                                             color: e.code == customerInfoProvider.userInformationResponseModel.gender ?FlexoColorConstants.ACCENT_COLOR :FlexoColorConstants.THEME_COLOR,
//                                                             width: 1
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         e.name,
//                                                         maxLines: 2,
//                                                         textAlign: TextAlign.center,
//                                                         overflow: TextOverflow.ellipsis,
//                                                         style: TextStyle(
//                                                             color: e.code == customerInfoProvider.userInformationResponseModel.gender ? Colors.white : FlexoColorConstants.ACCENT_COLOR,
//                                                             fontSize: FlexoValues.fontSize16,
//                                                             fontWeight: FontWeight.normal
//                                                         ),
//                                                       )
//                                                   )
//
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           SizedBox(height: FlexoValues.widthSpace4Px,),
//                         ],
//                       ),
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.firstNameEnabled ?
//                     TextFieldWidget(
//                       width: FlexoValues.controlsWidth,
//                       controller: customerInfoProvider.fNameController,
//                       hintText: localResourceProvider.getResourseByKey("account.fields.firstname"),
//                       keyBoardType: TextInputType.name,
//                       required: customerInfoProvider.userInformationResponseModel.firstNameRequired,
//                       errorMsg: localResourceProvider.getResourseByKey("account.fields.firstname.required"),
//                       icon: Ionicons.person_outline,
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.lastNameEnabled ?
//                     TextFieldWidget(
//                         width: FlexoValues.controlsWidth,
//                         controller: customerInfoProvider.lNameController,
//                         hintText: localResourceProvider.getResourseByKey("account.fields.lastname"),
//                         keyBoardType: TextInputType.name,
//                         required: customerInfoProvider.userInformationResponseModel.lastNameRequired,
//                         errorMsg: localResourceProvider.getResourseByKey("account.fields.lastname.required"),
//                         icon: Ionicons.person_outline
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.dateOfBirthEnabled ?
//                     FlexoDatePickerPlugin(
//                       context: context,
//                       width: FlexoValues.controlsWidth,
//                       controller: customerInfoProvider.dobController,
//                       required: false,
//                       hintText: localResourceProvider.getResourseByKey("account.fields.dateOfBirth"),
//                       pastDateEnable: true,
//                       futureDateEnable: false,
//                     ):Container(),
//
//                     TextFieldWidget(
//                       textFieldType: TextFieldType.Email,
//                       width: FlexoValues.controlsWidth,
//                       controller: customerInfoProvider.emailController,
//                       hintText: localResourceProvider.getResourseByKey("account.fields.email"),
//                       keyBoardType: TextInputType.emailAddress,
//                       required: true,
//                       errorMsg: localResourceProvider.getResourseByKey("account.fields.email.required"),
//                       errorMsgForEmail:localResourceProvider.getResourseByKey("common.wrongEmail") ,
//                       icon: Ionicons.mail_outline,
//                     ),
//
//                     customerInfoProvider.userInformationResponseModel.emailToRevalidate != null ?
//                     TextFieldWidget(
//                       textFieldType: TextFieldType.Email,
//                       width: FlexoValues.controlsWidth,
//                       controller: customerInfoProvider.confirmEmailController,
//                       hintText: localResourceProvider.getResourseByKey("account.fields.confirmEmail"),
//                       keyBoardType: TextInputType.emailAddress,
//                       required: true,
//                       errorMsg: localResourceProvider.getResourseByKey("account.fields.confirmEmail.required"),
//                       errorMsgForEmail:localResourceProvider.getResourseByKey("common.wrongEmail") ,
//                       icon: Ionicons.mail_outline,
//                     )
//                         :
//                     customerInfoProvider.userInformationResponseModel.usernamesEnabled ?
//                     customerInfoProvider.userInformationResponseModel.allowUsersToChangeUsernames ?
//                     Column(
//                       children: [
//
//                         TextFieldWidget(
//                             width: FlexoValues.controlsWidth,
//                             controller: customerInfoProvider.userNameController,
//                             hintText: localResourceProvider.getResourseByKey("account.fields.username"),
//                             keyBoardType: TextInputType.name,
//                             required: true,
//                             errorMsg: localResourceProvider.getResourseByKey("account.fields.username.required"),
//                             icon: Ionicons.person_outline
//                         ),
//
//                         customerInfoProvider.userInformationResponseModel.checkUsernameAvailabilityEnabled?
//                         Container(
//                           child: Column(
//                             children: [
//                               customerInfoProvider.checkAvailability.isEmpty?Container():
//                               Container(
//                                 width: FlexoValues.controlsWidth,
//                                 margin: EdgeInsets.only(left: FlexoValues.widthSpace2Px),
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   customerInfoProvider.checkAvailability,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       fontSize: FlexoValues.fontSize16,
//                                       color: customerInfoProvider.avail ? Colors.green :Colors.red,
//                                       fontWeight: FontWeight.normal
//                                   ),
//                                 ),
//                               ),
//
//                               Container(
//                                 width: FlexoValues.deviceWidth*0.9,
//                                 alignment: Alignment.centerRight,
//                                 child: GestureDetector(
//                                   onTap: ()async{
//                                     FocusManager.instance.primaryFocus?.unfocus();
//                                     registerProvider.checkUserNameAvailability(context: context);
//                                   },
//                                   child: Text(
//                                     localResourceProvider.getResourseByKey("account.checkUserNameAvailability.button"),
//                                     textAlign: TextAlign.end,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyleWidget.REDIRECT_TEXT_STYLE,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ):Container()
//                       ],
//                     ) :
//                     Container(
//                         child: FlexoTextWidget().contentText17(
//                             text:customerInfoProvider.userInformationResponseModel.username,
//                             maxLines: 2
//                         )
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.companyEnabled  ?
//                     Container(
//                       child: Column(
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.companyDetails")),
//
//                           customerInfoProvider.userInformationResponseModel.companyEnabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.companyNameController,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.company"),
//                               keyBoardType: TextInputType.name,
//                               required: customerInfoProvider.userInformationResponseModel.companyRequired,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.company.required"),
//                               icon:Ionicons.business_outline
//                           ) : Container(),
//
//                           customerInfoProvider.userInformationResponseModel.displayVatNumber ?
//                           Container(
//                             child: Column(
//                               children: [
//                                 TextFieldWidget(
//                                     width: FlexoValues.controlsWidth,
//                                     controller: customerInfoProvider.vatNumberController,
//                                     hintText: localResourceProvider.getResourseByKey("account.fields.vatNumber"),
//                                     keyBoardType: TextInputType.name,
//                                     required: false,
//                                     errorMsg: localResourceProvider.getResourseByKey("account.fields.vatNumber.required"),
//                                     icon:Ionicons.keypad_outline
//                                 ) ,
//
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace5Px),
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     localResourceProvider.getResourseByKey("account.fields.vatNumber.note"),
//                                     style: TextStyle(
//                                         color:FlexoColorConstants.NOTES_TEXT_COLOR,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize:FlexoValues.fontSize14
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ) : Container(),
//                         ],
//                       ),
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.streetAddressEnabled ||
//                         customerInfoProvider.userInformationResponseModel.streetAddress2Enabled ||
//                         customerInfoProvider.userInformationResponseModel.zipPostalCodeEnabled ||
//                         customerInfoProvider.userInformationResponseModel.cityEnabled ||
//                         customerInfoProvider.userInformationResponseModel.countyEnabled ||
//                         customerInfoProvider.userInformationResponseModel.countryEnabled ?
//                     Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.yourAddress")),
//
//                           customerInfoProvider.userInformationResponseModel.streetAddressEnabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.streetAddressController,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.streetAddress"),
//                               keyBoardType: TextInputType.name,
//                               required: customerInfoProvider.userInformationResponseModel.streetAddressRequired,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress.required"),
//                               icon:Ionicons.location_outline
//                           ) : Container(),
//
//                           customerInfoProvider.userInformationResponseModel.streetAddress2Enabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.streetAddress2Controller,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.streetAddress2"),
//                               keyBoardType: TextInputType.name,
//                               required: customerInfoProvider.userInformationResponseModel.streetAddress2Required,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.streetAddress2.required"),
//                               icon:Ionicons.location_outline
//                           ) : Container(),
//
//                           customerInfoProvider.userInformationResponseModel.zipPostalCodeEnabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.zipPostalCodeController,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.zipPostalCode"),
//                               keyBoardType: TextInputType.name,
//                               required:customerInfoProvider.userInformationResponseModel.zipPostalCodeRequired,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.zipPostalCode.required"),
//                               icon:Ionicons.location_outline
//                           ) : Container(),
//
//                           customerInfoProvider.userInformationResponseModel.countyEnabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.countyRegionController,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.county"),
//                               keyBoardType: TextInputType.name,
//                               required: customerInfoProvider.userInformationResponseModel.countyRequired,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.county.required"),
//                               icon:Ionicons.location_outline
//                           ) :
//                           Container(),
//
//                           customerInfoProvider.userInformationResponseModel.cityEnabled ?
//                           TextFieldWidget(
//                               width: FlexoValues.controlsWidth,
//                               controller: customerInfoProvider.cityController,
//                               hintText: localResourceProvider.getResourseByKey("account.fields.city"),
//                               keyBoardType: TextInputType.name,
//                               required: customerInfoProvider.userInformationResponseModel.cityRequired,
//                               errorMsg: localResourceProvider.getResourseByKey("account.fields.city.required"),
//                               icon:Ionicons.location_outline
//                           ) :
//                           Container(),
//
//                           customerInfoProvider.userInformationResponseModel.countryEnabled ?
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//
//                                     FlexoDropDown(
//                                       width: FlexoValues.controlsWidth,
//                                       required: customerInfoProvider.userInformationResponseModel.countryRequired,
//                                       heading: localResourceProvider.getResourseByKey("account.fields.country") ,
//                                       selectedValue: customerInfoProvider.userInformationResponseModel.countryId.toString(),
//                                       items: customerInfoProvider.userInformationResponseModel.availableCountries.map((e) {
//                                         return DropDownModel(text: e.text, value: e.value);
//                                       }).toList(),
//                                       hintText:localResourceProvider.getResourseByKey("account.fields.country") ,
//                                       onChange: (value){
//                                         setState(() {
//                                           customerInfoProvider.userInformationResponseModel.countryId =int.parse(value) ;
//                                           customerInfoProvider.getStateDataByCountryId(context: context, countryId: customerInfoProvider.userInformationResponseModel.countryId);
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ): Container(),
//
//                           customerInfoProvider.userInformationResponseModel.stateProvinceEnabled ?
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     FlexoDropDown(
//                                       required: customerInfoProvider.userInformationResponseModel.stateProvinceRequired,
//                                       heading: localResourceProvider.getResourseByKey("account.fields.stateProvince") ,
//                                       width: FlexoValues.controlsWidth,
//                                       selectedValue: customerInfoProvider.userInformationResponseModel.stateProvinceId.toString(),
//                                       items: customerInfoProvider.stateDropDown,
//                                       hintText:localResourceProvider.getResourseByKey("account.fields.stateProvince") ,
//                                       onChange: (value){
//                                         setState(() {
//                                           customerInfoProvider.userInformationResponseModel.stateProvinceId =int.parse(value) ;
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: FlexoValues.widthSpace2Px,)
//                               ],
//                             ),
//                           ): Container(),
//                         ],
//                       ),
//                     ): Container(),
//
//                     customerInfoProvider.userInformationResponseModel.phoneEnabled || customerInfoProvider.userInformationResponseModel.faxEnabled ?
//                     Container(
//                       child: Column(
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.yourContactInformation")),
//
//                           customerInfoProvider.userInformationResponseModel.phoneEnabled ?
//                           TextFieldWidget(
//                             textFieldType: TextFieldType.Numeric,
//                             width: FlexoValues.controlsWidth,
//                             controller: customerInfoProvider.phoneController,
//                             hintText: localResourceProvider.getResourseByKey("account.fields.phone"),
//                             keyBoardType: TextInputType.phone,
//                             required: customerInfoProvider.userInformationResponseModel.phoneRequired,
//                             errorMsg: localResourceProvider.getResourseByKey("account.fields.phone.required"),
//                             icon: Ionicons.phone_portrait_outline,
//                           ) :
//                           Container(),
//
//                           customerInfoProvider.userInformationResponseModel.faxEnabled ?
//                           TextFieldWidget(
//                             textFieldType: TextFieldType.Numeric,
//                             width: FlexoValues.controlsWidth,
//                             controller: customerInfoProvider.faxController,
//                             hintText: localResourceProvider.getResourseByKey("account.fields.fax"),
//                             keyBoardType: TextInputType.phone,
//                             required: customerInfoProvider.userInformationResponseModel.faxRequired,
//                             errorMsg: localResourceProvider.getResourseByKey("account.fields.fax.required"),
//                             icon: Ionicons.keypad_outline,
//                           ):
//                           Container(),
//                         ],
//                       ),
//                     ): Container(),
//
//                     customerInfoProvider.userInformationResponseModel.newsletterEnabled || customerInfoProvider.customerAttributes.length > 0 ?
//                     Container(
//
//                       child: Column(
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.options")),
//
//                           customerInfoProvider.userInformationResponseModel.newsletterEnabled ?
//                           Container(
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: FlexoValues.controlsWidth,
//                                   child: Row(
//                                     children: [
//
//                                       Container(
//                                         child: FlexoTextWidget().contentText17(
//                                             text: localResourceProvider.getResourseByKey("account.fields.newsletter"),
//                                             maxLines: 1
//                                         ),
//                                       ),
//                                       SizedBox(width: FlexoValues.widthSpace1Px,),
//
//                                       Transform.scale(
//                                         scale: FlexoValues.switchScale,
//                                         alignment: Alignment.centerLeft,
//                                         child: CupertinoSwitch(
//                                           onChanged: (val)
//                                           {
//                                             setState(()
//                                             {
//                                               customerInfoProvider.isNewsLatter = !customerInfoProvider.isNewsLatter;
//                                             });
//                                           },
//                                           value: customerInfoProvider.isNewsLatter,
//                                           activeColor: FlexoColorConstants.ACCENT_COLOR,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: FlexoValues.widthSpace3Px,),
//                               ],
//                             ),
//                           ) : Container(),
//
//                           customerAttributesSwitch(context: context, setState: setState, customerAttributes: customerInfoProvider.customerAttributes),
//
//                         ],
//                       ),
//                     ): Container(),
//
//                     customerInfoProvider.userInformationResponseModel.allowCustomersToSetTimeZone || customerInfoProvider.userInformationResponseModel.signatureEnabled ?
//                     Container(
//                       width: FlexoValues.controlsWidth,
//                       child: Column(
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.preferences")),
//
//                           customerInfoProvider.userInformationResponseModel.allowCustomersToSetTimeZone ?
//                           Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 FlexoDropDown(
//                                   width: FlexoValues.controlsWidth,
//                                   selectedValue: customerInfoProvider. userInformationResponseModel.timeZoneId,
//                                   items: customerInfoProvider.userInformationResponseModel.availableTimeZones.map((e){
//                                     return DropDownModel(text: e.text, value: e.value,);
//                                   }).toList(),
//                                   hintText:localResourceProvider.getResourseByKey("account.fields.timezone") ,
//                                   onChange: (value){
//                                     setState(() {
//                                       customerInfoProvider.userInformationResponseModel.timeZoneId = value;
//                                     });
//                                   },
//                                 ),
//
//                               ],
//                             ),
//                           ) : Container(),
//
//                           customerInfoProvider.userInformationResponseModel.signatureEnabled ?
//                           TextFieldWidget(
//                             width: FlexoValues.controlsWidth,
//                             controller: customerInfoProvider.signatureController,
//                             hintText: localResourceProvider.getResourseByKey("account.fields.signature"),
//                             keyBoardType: TextInputType.name,
//                             required: false,
//                             maxLine: 5,
//                           ) : Container(),
//                         ],
//                       ),
//                     ) : Container(),
//
//                     customerInfoProvider.userInformationResponseModel.gdprConsents.length > 0 ?
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
//                       child: Column(
//                         children: [
//
//                           dynamicHeadingText(localResourceProvider.getResourseByKey("account.userAgreement")),
//
//                           Container(
//                             width: FlexoValues.deviceWidth,
//                             padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
//                             child: Column(
//                               children: customerInfoProvider.userInformationResponseModel.gdprConsents.map((e)
//                               {
//                                 return Container(
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//
//
//                                             Container(
//                                               child: Transform.scale(
//                                                 scale: FlexoValues.switchScale,
//                                                 alignment: Alignment.centerLeft,
//                                                 child: CupertinoSwitch(
//                                                   onChanged: (val)
//                                                   {
//                                                     setState(()
//                                                     {
//                                                       e.accepted = !e.accepted;
//                                                     });
//                                                   },
//                                                   value: e.accepted,
//                                                   activeColor: FlexoColorConstants.ACCENT_COLOR,
//                                                 ),
//                                               ),
//                                             ),
//
//                                             SizedBox(width: FlexoValues.widthSpace1Px,),
//
//                                             Expanded(
//                                               child: Container(
//                                                   padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
//                                                   child: FlexoTextWidget().contentText15(
//                                                       text:e.message,
//                                                       maxLines: 20
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//
//                                       SizedBox(height: FlexoValues.widthSpace2Px,),
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//
//                           SizedBox(height: FlexoValues.widthSpace2Px,),
//                         ],
//                       ),
//                     ) :  Container(),
//
//                     ButtonWidget().getButton(
//                         text: localResourceProvider.getResourseByKey("common.save").toString().toUpperCase(),
//                         width: FlexoValues.controlsWidth,
//                         isApiLoad: false,
//                         onClick: () async
//                         {
//                           if(form.currentState!.validate()){
//                             KeyboardUtil.hideKeyboard(context);
//                             customerInfoProvider.updateButtonClickEvent(context: context);
//                           }else{
//                             print("Inner not validate");
//                           }
//                         }),
//
//                     SizedBox(height: FlexoValues.heightSpace2Px),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
