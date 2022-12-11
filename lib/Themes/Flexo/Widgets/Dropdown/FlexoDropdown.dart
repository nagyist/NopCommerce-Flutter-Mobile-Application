/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownButton2.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Utils/Colors.dart';
import '../RequiredIconWidget.dart';
import '../TextWidget.dart';


class FlexoDropDown extends StatefulWidget {
  final double width;
  final String hintText;
  final String heading;
  final bool required;
  final bool showRequiredIcon;
  String selectedValue;
  final List<DropDownModel> items;
  final Function(String val) onChange;

  FlexoDropDown({
    required this.width,
    required this.selectedValue,
    required this.items,
    required this.onChange,
    this.hintText="",
    this.heading="",
    this.required=false,
    this.showRequiredIcon = true,
  });

  @override
  State<FlexoDropDown> createState() => _FlexoDropDownState();
}

class _FlexoDropDownState extends State<FlexoDropDown> {

  int selectedIndex = 0;
  String iosDisplayValue = "Select Item";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(CheckDeviceType().isIOS())
    // {
    //   selectedIndex = widget.items.indexWhere((element) => element.value == widget.selectedValue);
    //   iosDisplayValue = widget.items.where((element) => element.value == widget.selectedValue).first.text;
    //
    //   print("Selected ${widget.selectedValue}");
    //   print("DV $selectedIndex & $iosDisplayValue");
    // }
  }

  @override
  Widget build(BuildContext context) {
    if(CheckDeviceType().isIOS())
    {
      selectedIndex = widget.items.indexWhere((element) => element.value == widget.selectedValue);
      iosDisplayValue = widget.items.where((element) => element.value == widget.selectedValue).first.text;
    }

    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            children: [
              CheckDeviceType().isIOS() ?
              GestureDetector(
                onTap: () {

                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                          height: FlexoValues.deviceHeight * 0.25,
                          color: Colors.white,
                          child: CupertinoTheme(
                            data: CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                  //dateTimePickerTextStyle: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
                                  textStyle: TextStyleWidget.controlsTextStyle
                              ),
                              scaffoldBackgroundColor: Colors.grey,
                              barBackgroundColor: Colors.blue,
                            ),
                            child: CupertinoPicker(
                              children: widget.items.map((e)
                              {
                                return Container(child: FlexoTextWidget().dropdownControlsText(text: e.text, maxLines: 1),padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),alignment: Alignment.center,);
                                //return Text(e.text,style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,maxLines: 1,);
                              }).toList(),
                              onSelectedItemChanged: (value){
                                //setState(() {
                                  selectedIndex = value;
                                  widget.selectedValue = widget.items[selectedIndex].value.toString();
                                  widget.onChange(widget.items[selectedIndex].value.toString());
                                  iosDisplayValue = widget.items[selectedIndex].text;
                                //});
                              },
                              scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                              itemExtent: 32.0,
                              diameterRatio: 1,
                              useMagnifier: true,
                              backgroundColor: Colors.grey.shade100,
                              magnification: 1,
                              selectionOverlay: Container(
                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                                decoration: BoxDecoration(
                                    // border: Border.symmetric(
                                    //     horizontal: BorderSide(
                                    //         color: FlexoColorConstants.CONTROL_HEIGHT_LITE_BORDER_COLOR
                                    //     ),
                                    // ),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  );

                },
                child: Container(
                  width: widget.showRequiredIcon ? widget.width - FlexoValues.widthSpace3Px : widget.width,
                  height: FlexoValues.deviceHeight*0.07,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: FlexoColorConstants.BORDER_COLOR
                      )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          child: FlexoTextWidget().controlsText(text: iosDisplayValue, maxLines: 1),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        width: FlexoValues.widthSpace4Px,
                        child: Icon(
                          Ionicons.caret_down_outline,
                          size: FlexoValues.iconSize15,
                          color: FlexoColorConstants.BORDER_COLOR,
                        ),
                      )
                    ],
                  ),
                ),
              ) :
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  icon: Icon(
                    Ionicons.caret_down_outline,
                    size: FlexoValues.iconSize15,
                    color: FlexoColorConstants.BORDER_COLOR,
                  ),
                  iconSize: 15,
                  iconEnabledColor: FlexoColorConstants.LIST_BORDER_COLOR,
                  buttonHeight: FlexoValues.deviceHeight*0.07,
                  buttonWidth: widget.showRequiredIcon ? widget.width - FlexoValues.widthSpace3Px : widget.width,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(
                      color: FlexoColorConstants.BORDER_COLOR,
                    ),
                    color: FlexoColorConstants.CONTROL_BACKGROUND_COLOR,
                  ),
                  buttonPadding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  alignment: Alignment.center,
                  style: TextStyleWidget.controlsTextStyle,
                  dropdownMaxHeight: 300,
                  dropdownWidth: widget.showRequiredIcon ? widget.width - FlexoValues.widthSpace3Px : widget.width,
                  dropdownDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  selectedItemHighlightColor: Colors.grey.shade400,
                  dropdownElevation: 8,
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  items: widget.items.map((e)
                  {
                    return DropdownMenuItem(value: e.value,child:Text(e.text,style: TextStyleWidget.controlsTextStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,maxLines: 1));
                  }).toList(),
                  value: widget.selectedValue,
                  onChanged: (value) {
                    setState(() {
                      widget.selectedValue = value as String;
                      widget.onChange(value);
                    });
                  },
                ),
              )
            ],
          ),

          widget.required ? RequiredIconWidget() : SizedBox(width: 0,)

        ],
      ),
    );
  }
}




