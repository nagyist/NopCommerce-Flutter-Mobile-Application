/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'RequiredIconWidget.dart';
import 'TextWidget.dart';

class FlexoDatePickerPlugin extends StatefulWidget {
  final BuildContext context;
  final double width;
  final TextEditingController controller;
  final String hintText;
  final String heading;
  final String errorMsg;
  final bool required;
  final bool showRequiredIcon;
  final bool futureDateEnable;
  final bool pastDateEnable;
  final Function(String formattedDate)? onClick;

  FlexoDatePickerPlugin({
    required this.context,
    required this.width,
    required this.controller,
    this.hintText="",
    this.heading="",
    this.errorMsg="",
    this.required=false,
    this.showRequiredIcon = true,
    this.futureDateEnable=true,
    this.pastDateEnable=true,
    required this.onClick,
  });

  @override
  State<FlexoDatePickerPlugin> createState() => _FlexoDatePickerPluginState();
}

class _FlexoDatePickerPluginState extends State<FlexoDatePickerPlugin> {
  bool isEmpty = false;
  var initializeDate;

  @override
  Widget build(BuildContext context) {

    if(widget.controller.text.isNotEmpty)
    {
      initializeDate = DateFormat(StringConstants.DATE_FORMAT).parse(widget.controller.text);
    }else{
      initializeDate = DateTime.now();
    }

    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: widget.showRequiredIcon ? widget.width - FlexoValues.widthSpace3Px : widget.width,
                height: FlexoValues.controlsHeight,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: isEmpty
                          ? FlexoColorConstants.ERROR_TEXT_COLOR
                          : FlexoColorConstants.BORDER_COLOR,
                    ),
                    //color: FlexoColorConstants.CONTROL_BACKGROUND_COLOR
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller:widget.controller,
                  readOnly: true,
                  onTap: () async
                  {
                    KeyboardUtil.hideKeyboard(widget.context);
                    FocusScope.of(context).unfocus();
                    if(CheckDeviceType().isIOS())
                    {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: MediaQuery.of(context).copyWith().size.height*0.25,
                              child: CupertinoTheme(
                                data: CupertinoThemeData(
                                  textTheme: CupertinoTextThemeData(
                                      dateTimePickerTextStyle: TextStyleWidget.contentTextStyle15,
                                      textStyle: TextStyleWidget.dropdownControlTextStyle,
                                  ),
                                  scaffoldBackgroundColor: Colors.grey,
                                  barBackgroundColor: Colors.blue,
                                  primaryContrastingColor: Colors.red
                                ),
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (value) {
                                    initializeDate = value;
                                    String formattedDate = DateFormat(StringConstants.DATE_FORMAT).format(initializeDate);
                                    widget.controller.text = formattedDate;
                                    widget.onClick!(formattedDate);
                                  },
                                  initialDateTime: initializeDate == null ? DateTime.now() : initializeDate,
                                  maximumDate: widget.futureDateEnable? DateTime(DateTime.now().year + 100, 1) : DateTime.now(),
                                  minimumDate: widget.pastDateEnable? DateTime(DateTime.now().year - 100, 1) : DateTime.now(),
                                ),
                              ),
                            );
                          }
                      );
                    }else{
                      DateTime? pickedDate = await showDatePicker(

                          context: context, initialDate: DateTime.now(),
                          firstDate: widget.pastDateEnable? DateTime(DateTime.now().year - 100, 1) : DateTime.now(),
                          lastDate: widget.futureDateEnable? DateTime(DateTime.now().year + 100, 1) : DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.black, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );
                      if(pickedDate != null ){
                        String formattedDate = DateFormat(StringConstants.DATE_FORMAT).format(pickedDate);
                        setState(() {
                          widget.controller.text = formattedDate;
                          widget.onClick!(formattedDate);
                        });
                      }
                    }
                  },
                  style: TextStyleWidget.controlsTextStyle,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Ionicons.calendar_outline,
                      color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                      size: FlexoValues.iconSize18,
                    ),
                    hintStyle: TextStyleWidget.hintTextStyle,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    filled: true,
                    fillColor: FlexoColorConstants.CONTROL_BACKGROUND_COLOR,
                    hintText: widget.hintText,
                    contentPadding: EdgeInsets.symmetric(horizontal: FlexoValues.horizontalPadding),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                    isCollapsed: true,
                  ),
                  validator:(val){
                    if(widget.required && val!.isEmpty)
                    {
                      setState(() {
                        isEmpty = true;
                      });
                      return widget.errorMsg;
                    }else{
                      setState(() {
                        isEmpty = false;
                      });
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              widget.required ? RequiredIconWidget() : Container(width: 0,),
            ],
          ),
          isEmpty ? Container(child: FlexoTextWidget().controlsErrorText(text: widget.errorMsg)) : SizedBox(height: 0,),
        ],
      ),
    );
  }
}