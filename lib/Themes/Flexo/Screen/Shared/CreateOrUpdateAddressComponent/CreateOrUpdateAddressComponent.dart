/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Models/AddressModel.dart';
import 'package:nopcommerce/Models/StateModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CommonService.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Checkout/Component/AddressAttributes.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';

class FlexoCreateOrUpdateAddressComponent extends StatefulWidget {
  final AddressModel addressModel;
  final Function apiLoaderFunction;
  FlexoCreateOrUpdateAddressComponent({required this.addressModel,required this.apiLoaderFunction});

  @override
  State<FlexoCreateOrUpdateAddressComponent> createState() => _FlexoCreateOrUpdateAddressComponentState();
}

class _FlexoCreateOrUpdateAddressComponentState extends State<FlexoCreateOrUpdateAddressComponent> {
  List<DropDownModel> stateDropdownList = [];
  bool isAddressLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageLoadData();
  }


  pageLoadData()
  {
    setState(() {
      isAddressLoad = false;
      stateDropdownList.clear();
      for(var address in widget.addressModel.availableStates)
      {
        stateDropdownList.add(new DropDownModel(text: address.text, value: address.value));
      }
      widget.addressModel.stateProvinceId = int.parse(stateDropdownList[0].value);
      widget.addressModel.stateProvinceName = stateDropdownList[0].text;

      isAddressLoad = true;
      print("Address ${widget.addressModel.firstName}, ${widget.addressModel.lastName}");

    });
  }

  statesByCountryId({required BuildContext context, required int countryId})async
  {
    widget.apiLoaderFunction();

    Response response = await CommonService().getStateData(context: context,countryId: countryId);
    if(response.statusCode == 200)
    {
      stateDropdownList.clear();
      List<StateModel> stateModelList = stateModelFromJson(response.body);
      for(var item in stateModelList)
      {
        stateDropdownList.add(new DropDownModel(text: item.name, value: item.id.toString()));
      }

      widget.addressModel.stateProvinceId = stateModelList[0].id;
      widget.addressModel.stateProvinceName = stateModelList[0].name;

    }

    widget.apiLoaderFunction();
  }


  @override
  Widget build(BuildContext context) {

    var localResourceProvider = context.watch<LocalResourceProvider>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: FlexoValues.heightSpace1Px),

          Divider(thickness: 1,height: 1,),

          SizedBox(height: FlexoValues.heightSpace1Px),

          TextFieldAttributeWidgets(
            width: FlexoValues.controlsWidth,
            icon: Ionicons.person_outline,
            keyBoardType: TextInputType.name,
            heading: localResourceProvider.getResourseByKey("address.fields.firstname"),
            hintText: localResourceProvider.getResourseByKey("address.fields.firstname"),
            errorMsg: localResourceProvider.getResourseByKey("address.fields.firstname.required"),
            required: true,
            initialValue: widget.addressModel.firstName,
            onChange: (str)
            {
              widget.addressModel.firstName = str;
            },
          ),

          SizedBox(height: FlexoValues.heightSpace2Px),

          TextFieldAttributeWidgets(
            width: FlexoValues.controlsWidth,
            icon: Ionicons.person_outline,
            keyBoardType: TextInputType.name,
            heading: localResourceProvider.getResourseByKey("address.fields.lastname"),
            hintText: localResourceProvider.getResourseByKey("address.fields.lastname"),
            errorMsg: localResourceProvider.getResourseByKey("address.fields.lastname.required"),
            required: true,
            initialValue: widget.addressModel.lastName,
            onChange: (str)
            {
              widget.addressModel.lastName = str;
            },
          ),

          SizedBox(height: FlexoValues.heightSpace2Px),

          TextFieldAttributeWidgets(
            textFieldType: TextFieldType.Email,
            width: FlexoValues.controlsWidth,
            icon: Ionicons.mail_outline,
            keyBoardType: TextInputType.name,
            heading: localResourceProvider.getResourseByKey("address.fields.email"),
            hintText: localResourceProvider.getResourseByKey("address.fields.email"),
            errorMsg: localResourceProvider.getResourseByKey("address.fields.email.required"),
            errorMsgForEmail: localResourceProvider.getResourseByKey("common.wrongEmail"),
            required: true,
            initialValue: widget.addressModel.email,
            onChange: (str)
            {
              widget.addressModel.email = str;
            },
          ),

          SizedBox(height: FlexoValues.heightSpace2Px),

          widget.addressModel.companyEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.business_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.company"),
                hintText: localResourceProvider.getResourseByKey("address.fields.company"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.company.required"),
                required: widget.addressModel.companyRequired,
                initialValue: widget.addressModel.company,
                onChange: (str)
                {
                  widget.addressModel.company = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ):Container(width: 0,height: 0,),

          widget.addressModel.countryEnabled ?
          Column(
            children: [
              FlexoDropDown(
                  width: FlexoValues.controlsWidth,
                  required: true,
                  selectedValue: widget.addressModel.countryId.toString(),
                  items: widget.addressModel.availableCountries.map((e)
                  {
                    return DropDownModel(text: e.text, value: e.value);
                  }).toList(),
                  onChange: (val)
                  {
                    widget.addressModel.countryId = int.parse(val);
                    widget.addressModel.countryName = widget.addressModel.availableCountries.where((element) => element.value == val).first.text;
                    statesByCountryId(context: context, countryId: widget.addressModel.countryId);
                  }
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ): Container(height: 0,width: 0,),

          widget.addressModel.countryEnabled && widget.addressModel.stateProvinceEnabled?
          Column(
            children: [

              FlexoDropDown(
                  width: FlexoValues.controlsWidth,
                  selectedValue: widget.addressModel.stateProvinceId.toString(),
                  items: stateDropdownList,
                  onChange: (val)
                  {
                    widget.addressModel.stateProvinceId = int.parse(val);
                    widget.addressModel.stateProvinceName = stateDropdownList.where((element) => element.value == val).first.text;
                  }
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ):
          Container(height: 0,width: 0,),

          widget.addressModel.countyEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.location_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.county"),
                hintText: localResourceProvider.getResourseByKey("address.fields.county"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.county.required"),
                required: widget.addressModel.countyRequired,
                initialValue: widget.addressModel.county,
                onChange: (str)
                {
                  widget.addressModel.county = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(height: 0,width: 0,),

          widget.addressModel.cityEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.location_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.city"),
                hintText: localResourceProvider.getResourseByKey("address.fields.city"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.city.required"),
                required: widget.addressModel.cityRequired,
                initialValue: widget.addressModel.city,
                onChange: (str)
                {
                  widget.addressModel.city = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(height: 0,width: 0,),


          widget.addressModel.streetAddressEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.location_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.address1"),
                hintText: localResourceProvider.getResourseByKey("address.fields.address1"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.address1.required"),
                required: widget.addressModel.streetAddressRequired,
                initialValue: widget.addressModel.address1,
                onChange: (str)
                {
                  widget.addressModel.address1 = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(width: 0,),

          widget.addressModel.streetAddress2Enabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.location_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.address2"),
                hintText: localResourceProvider.getResourseByKey("address.fields.address2"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.address2.required"),
                required: widget.addressModel.streetAddress2Required,
                initialValue: widget.addressModel.address2,
                onChange: (str)
                {
                  widget.addressModel.address2 = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(width: 0,),


          widget.addressModel.zipPostalCodeEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.location_outline,
                keyBoardType: TextInputType.name,
                heading: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                hintText: localResourceProvider.getResourseByKey("address.fields.zipPostalCode"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.zipPostalCode.required"),
                required: widget.addressModel.zipPostalCodeRequired,
                initialValue: widget.addressModel.zipPostalCode,
                onChange: (str)
                {
                  widget.addressModel.zipPostalCode = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(width: 0,),


          widget.addressModel.phoneEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.phone_portrait_outline,
                keyBoardType: TextInputType.number,
                textFieldType: TextFieldType.Numeric,
                heading: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                hintText: localResourceProvider.getResourseByKey("address.fields.phoneNumber"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.phoneNumber.required"),
                required: widget.addressModel.phoneRequired,
                initialValue: widget.addressModel.phoneNumber,
                onChange: (str)
                {
                  widget.addressModel.phoneNumber = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(width: 0,),


          widget.addressModel.faxEnabled ?
          Column(
            children: [
              TextFieldAttributeWidgets(
                width: FlexoValues.controlsWidth,
                icon: Ionicons.keypad_outline,
                keyBoardType: TextInputType.number,
                heading: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                hintText: localResourceProvider.getResourseByKey("address.fields.faxNumber"),
                errorMsg: localResourceProvider.getResourseByKey("address.fields.faxNumber.required"),
                required: widget.addressModel.faxRequired,
                initialValue: widget.addressModel.faxNumber,
                onChange: (str)
                {
                  widget.addressModel.faxNumber = str;
                },
              ),

              SizedBox(height: FlexoValues.heightSpace2Px),
            ],
          ) : Container(width: 0,),

          SizedBox(height: FlexoValues.widthSpace2Px),

          CheckoutAddressAttributes(customAddressAttributes: widget.addressModel.customAddressAttributes),
        ],

      ),
    );
  }
}
