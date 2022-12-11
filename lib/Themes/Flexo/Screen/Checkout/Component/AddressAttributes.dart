/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/AddressAttributeModel.dart';
import 'package:nopcommerce/Models/AddressAttributesValuesModel.dart';
import 'package:nopcommerce/Models/CustomProperties.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextRadioButton.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Enum/CustomerAttributes.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';


class CheckoutAddressAttributes extends StatefulWidget {
  final List<AddressAttribute> customAddressAttributes;
  CheckoutAddressAttributes({required this.customAddressAttributes});

  @override
  State<CheckoutAddressAttributes> createState() => _CheckoutAddressAttributesState();
}

class _CheckoutAddressAttributesState extends State<CheckoutAddressAttributes> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: FlexoValues.controlsWidth,
      child: Column(
        children: widget.customAddressAttributes.map((e)
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    addressAttributeHeading(heading: e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px),

                    FlexoDropDown(
                        width: FlexoValues.controlsWidth,
                        selectedValue: e.defaultValue,
                        items: e.values.map((e)
                        {
                          return DropDownModel(text: e.name, value: e.id.toString());
                        }).toList(),
                        onChange: (val)
                        {
                          setState((){
                            e.defaultValue = val;
                          });
                        }
                    ),

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
                  if(e.defaultValue.toString()==i.id.toString()){
                    i.isPreSelected = true;
                  }else{
                    i.isPreSelected = false;
                  }
                }
              }

              widget = Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    addressAttributeHeading(heading: e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px),

                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Wrap(
                        children: e.values.map((item) {
                          return GestureDetector(
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
                            child: Container(
                              margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,bottom: FlexoValues.widthSpace2Px),
                              padding: EdgeInsets.only(right: FlexoValues.widthSpace1Px),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  TextRadioButton().textRadioButtonComponent(isCheck: item.isPreSelected, title: '${item.name}'),

                                  SizedBox(width: FlexoValues.widthSpace1Px),

                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: FlexoValues.heightSpace2Px,),
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

                    addressAttributeHeading(heading: e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px),

                    Container(
                      width: FlexoValues.controlsWidth,
                      child: Wrap(
                        children: e.values.map((item) {
                          return Container(
                            margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px,top: FlexoValues.widthSpace2Px),
                            child: Container(
                              padding: EdgeInsets.only(right: FlexoValues.widthSpace3Px),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Transform.scale(
                                    scale: FlexoValues.switchScale,
                                    child: CupertinoSwitch(
                                      onChanged: (val)
                                      {
                                        if(AttributeControlType.Checkboxes == e.attributeControlType)
                                        {
                                          setState(()
                                          {
                                            item.isPreSelected = !item.isPreSelected;
                                          });
                                        }
                                      },
                                      value: item.isPreSelected,
                                      activeColor: FlexoColorConstants.ACCENT_COLOR,
                                    ),
                                  ),

                                  SizedBox(width: FlexoValues.widthSpace1Px),

                                  Flexible(
                                    child: Text(
                                      '${item.name}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: FlexoValues.fontSize16,
                                          color: FlexoColorConstants.DARK_TEXT_COLOR,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: FlexoValues.heightSpace2Px,),
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

                    addressAttributeHeading(heading: e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px),

                    TextFieldWidget(
                      width: FlexoValues.controlsWidth,
                      hintText: e.name,
                      required: e.isRequired,
                      onChange: (val)
                      {
                        setState(() {
                          e.defaultValue = val;
                        });
                      },
                    ),
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

                    addressAttributeHeading(heading: e.name, isRequired: e.isRequired),

                    SizedBox(height: FlexoValues.widthSpace1Px),

                    TextFieldWidget(
                      width: FlexoValues.controlsWidth,
                      hintText: e.name,
                      required: e.isRequired,
                      maxLine: 5,
                      onChange: (val)
                      {
                        setState(() {
                          e.defaultValue = val;
                        });
                      },
                    ),
                  ],
                ),
              );
              break;
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px),
            child: widget,
          );
        }).toList(),
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
