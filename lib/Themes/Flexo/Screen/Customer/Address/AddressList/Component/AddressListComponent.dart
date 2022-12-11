/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Customer/Address/AddressList/AddressListProvider.dart';
import 'package:nopcommerce/Screens/Customer/Address/CreateOrUpdateAddress/CreateOrUpdateAddress.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/FormType.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/DialogBoxWidget.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:provider/provider.dart';

class AddressListComponent{

  getAddressListComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var addressListProvider = context.watch<AddressListProvider>();
    return StatefulBuilder(builder: (ctx, setState)
    {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            addressListProvider.getAddressesModel.addresses.length > 0 ?
            Container(
              child: Column(
                children: addressListProvider.getAddressesModel.addresses.map((e){

                  String addressLine="";

                  if((e.cityEnabled && e.city != null) ||  (e.countyEnabled && e.county != null ) || (e.stateProvinceEnabled && e.stateProvinceName != null) ||
                      (e.zipPostalCodeEnabled && e.zipPostalCode != null))
                  {

                    if(e.cityEnabled && (e.city != null || e.city != ""))
                    {
                      addressLine += e.city;
                      if((e.countyEnabled && e.county != null) || (e.stateProvinceEnabled && e.stateProvinceName != null) ||
                          (e.zipPostalCodeEnabled && e.zipPostalCode != null)) {
                        addressLine += ", ";
                      }
                      else{
                      }
                    }
                    if(e.countyEnabled)
                    {
                      if(e.county == null || e.county == "")
                      {}else{
                        addressLine += e.county;
                        if(!e.stateProvinceEnabled && e.stateProvinceName == null || !e.zipPostalCodeEnabled && e.zipPostalCode == null)
                        {}else{
                          addressLine += ", ";
                        }
                      }
                    }

                    if(e.stateProvinceEnabled && e.zipPostalCodeEnabled)
                    {
                      if(e.stateProvinceName == null || e.stateProvinceName == "")
                      {}else{
                        addressLine += e.stateProvinceName;
                        if(e.zipPostalCodeEnabled && e.zipPostalCode != null)
                        {
                          addressLine += ", ";
                        }
                      }
                    }

                    if(e.zipPostalCodeEnabled)
                    {
                      if(e.zipPostalCode == null || e.zipPostalCode == "")
                      {}else{
                        addressLine += e.zipPostalCode;
                      }
                    }

                  }

                  return Container(
                    width: FlexoValues.deviceWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                              ),
                              top: BorderSide(
                                  color: FlexoColorConstants.LIST_BORDER_COLOR
                              ),
                            ),
                            color: FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                          ),
                          width: FlexoValues.deviceWidth,
                          padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: FlexoValues.deviceWidth * 0.7,
                                  child:FlexoTextWidget().headingBoldText16(
                                    text: '${e.firstName} ${e.lastName}',
                                    maxLines: 1,
                                  )
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    GestureDetector(
                                      onTap:() async{
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: CreateOrUpdateAddress(formType: FormType.Edit,addressId: e.id))).then((value){
                                            setState(() {
                                              addressListProvider.getAddressesData(context: context);
                                            });
                                          });
                                      },
                                      child: Container(
                                          child: Icon(
                                            Ionicons.create_outline,
                                            size: FlexoValues.iconSize20,
                                            color:FlexoColorConstants.THEME_COLOR,
                                          )
                                      ),
                                    ),

                                    SizedBox(width:  FlexoValues.widthSpace2Px,),

                                    GestureDetector(
                                      onTap: ()async{

                                        DialogBoxWidget().deleteItemDialogBox(
                                            context: context,
                                            title: localResourceProvider.getResourseByKey("common.deleteConfirmation"),
                                            cancelText: localResourceProvider.getResourseByKey("common.cancel"),
                                            submitText: localResourceProvider.getResourseByKey("common.delete"),
                                            isCancelable: true,
                                            onSubmit: () async
                                            {
                                              if(await CheckConnectivity().checkInternet(context)){
                                                addressListProvider.deleteButtonClickEvent(context: context, addressId: e.id);
                                              }
                                            }
                                        );

                                      },
                                      child: Container(
                                        child: Icon(
                                          Ionicons.trash_outline,
                                          size:FlexoValues.iconSize20,
                                          color: FlexoColorConstants.THEME_COLOR,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: FlexoValues.widthSpace2Px,),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                  padding: EdgeInsets.symmetric(horizontal:  FlexoValues.widthSpace2Px),
                                  child: FlexoTextWidget().headingBoldText16(
                                    text: '${e.firstName} ${e.lastName}',
                                    maxLines: 1
                                  )
                              ),

                              SizedBox(height:  FlexoValues.widthSpace2Px,),

                              e.email==null || e.email== "" ? Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                        child: Text(
                                          localResourceProvider.getResourseByKey("address.fields.email")+": " +"${e.email}",
                                          style: TextStyleWidget.headingTextStyle16,
                                        )
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ),

                              e.phoneEnabled ? e.phoneNumber == null || e.phoneNumber == "" ? Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                        child: Text(
                                          localResourceProvider.getResourseByKey("address.fields.phoneNumber")+": " +"${e.phoneNumber}",
                                          style: TextStyleWidget.headingTextStyle16,
                                        )
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ) : Container(),

                              e.faxEnabled ? e.faxNumber == null || e.faxNumber == "" ? Container():
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                child: Column(
                                  children: [
                                    Container(
                                        child: Text(
                                          localResourceProvider.getResourseByKey("address.fields.faxNumber")+": " +"${e.faxNumber}",
                                          style: TextStyleWidget.headingTextStyle16,
                                        )
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ): Container(),

                              e.companyEnabled ? e.company == null || e.company == "" ? Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        e.company,
                                        style: TextStyleWidget.headingTextStyle16,
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ): Container(),

                              e.streetAddressEnabled ? e.address1 == null || e.address1 == "" ?Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        e.address1,
                                        style: TextStyleWidget.headingTextStyle16,
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ): Container(),

                              e.streetAddress2Enabled ? e.address2 == null || e.address2 == "" ?Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        e.address2,
                                        style: TextStyleWidget.headingTextStyle16,
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ): Container(),

                              addressLine != "" ?
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        addressLine,
                                        style: TextStyleWidget.headingTextStyle16,
                                      ),
                                    ),

                                    SizedBox(height:FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ) :Container(),

                              e.countryEnabled ? e.countryName == null || e.countryName == "" ? Container() :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        e.countryName,
                                        style:TextStyleWidget.headingTextStyle16,
                                      ),
                                    ),

                                    SizedBox(height: FlexoValues.heightSpace1Px,),
                                  ],
                                ),
                              ): Container(),

                              e.formattedCustomAddressAttributes == null || e.formattedCustomAddressAttributes == "" ? Container() :
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,),
                                      child: RichText(
                                        text: HTML.toTextSpan(
                                          ctx,
                                          e.formattedCustomAddressAttributes,
                                          defaultTextStyle: TextStyleWidget.headingTextStyle16,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              SizedBox(height: FlexoValues.heightSpace1Px,),

                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                }).toList(),
              ),
            ) :
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
              child:FlexoTextWidget().contentText17(
                   text: localResourceProvider.getResourseByKey("account.customerAddresses.noAddresses"),
              ),
            ),

            Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,height: 1,),

            SizedBox(height: FlexoValues.heightSpace1Px),

            ButtonWidget().getButton(
                text:localResourceProvider.getResourseByKey("common.addNew").toString().toUpperCase(),
                width: FlexoValues.controlsWidth,
                onClick: ()async{
                 Navigator.push(context, PageTransition(type: selectedTransition, child: CreateOrUpdateAddress(formType: FormType.Create,addressId: 0,))).then((value){
                    addressListProvider.getAddressesData(context: context);
                  });
                },
                isApiLoad: false
            ),

            SizedBox(height:FlexoValues.widthSpace2Px,),
          ],
        ),
      );
    });
  }
}