/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';

class TextFieldAttributeWidgets extends StatefulWidget {
  final double width;
  final int maxLine;
  final int maxLength;
  final bool readOnly;
  final bool enable;
  final String hintText;
  final String heading;
  final TextInputType keyBoardType;
  final bool required;
  final bool showRequiredIcon;
  final String errorMsg;
  final String initialValue;
  final String errorMsgForEmail;
  final IconData? icon;
  final int textFieldType;
  final Function(String value)? onChange;
  final Function(String? value)? onSaved;

  TextFieldAttributeWidgets({
    required this.width,
    this.hintText = "",
    this.heading = "",
    this.keyBoardType = TextInputType.name,
    this.required = false,
    this.showRequiredIcon = true,
    this.errorMsg = "",
    this.initialValue = "",
    this.errorMsgForEmail = "",
    this.maxLine = 1,
    this.maxLength = 100000,
    this.readOnly = false,
    this.enable = true,
    this.onChange,
    this.onSaved,
    this.textFieldType = TextFieldType.Text,
    this.icon,
  });

  @override
  State<TextFieldAttributeWidgets> createState() => _TextFieldAttributeWidgetsState();
}

class _TextFieldAttributeWidgetsState extends State<TextFieldAttributeWidgets> {
  bool isValidate = false;
  bool isEmpty = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.showRequiredIcon ? widget.width - FlexoValues.widthSpace3Px : widget.width,
            height: widget.maxLine == 1
                ? FlexoValues.controlsHeight
                : widget.maxLine * (FlexoValues.controlsHeight / 2),
            decoration: BoxDecoration(
                border: Border.all(
                  color: isValidate
                      ? FlexoColorConstants.ERROR_TEXT_COLOR
                      : FlexoColorConstants.BORDER_COLOR,
                ),
                color: FlexoColorConstants.CONTROL_BACKGROUND_COLOR),
            alignment: Alignment.center,
            child: TextFormField(
              style: TextStyleWidget.controlsTextStyle,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              enabled: widget.enable,
              onChanged: widget.onChange,
              onSaved: widget.onSaved,
              initialValue: widget.initialValue,
              inputFormatters: <TextInputFormatter>[
                widget.textFieldType == TextFieldType.Numeric ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter,
              ],
              validator: (val) {

                if(widget.textFieldType == TextFieldType.Email)
                {
                  if(widget.required && val!.isEmpty )
                  {
                    setState(() {
                      isEmpty = true;
                      isValidate = false;
                    });
                    return widget.errorMsg;
                  }else if(widget.required && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)){
                    {
                      setState(() {
                        isEmpty = false;
                        isValidate = true;
                      });
                      return widget.errorMsgForEmail;
                    }
                  }
                  else{
                    setState(() {
                      isEmpty = false;
                      isValidate = false;
                    });
                    return null;
                  }
                }else{
                  if(widget.required && val!.isEmpty)
                  {
                    setState(() {
                      isEmpty = true;
                      isValidate = false;
                    });
                    return widget.errorMsg;
                  }else{
                    setState(() {
                      isEmpty = false;
                      isValidate = false;
                    });
                    return null;
                  }
                }

              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: FlexoValues.horizontalPadding),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorMaxLines: 1,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                isCollapsed: true,
                isDense: true,
                filled: true,
                hintText: widget.hintText,
                hintStyle: TextStyleWidget.hintTextStyle,
                fillColor: FlexoColorConstants.CONTROL_BACKGROUND_COLOR,
                counterText: "",
                errorText: "",
                prefixIcon: widget.icon == null ? null : Icon(
                  widget.icon,
                  color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                  size: FlexoValues.iconSize18,
                ),
              ),
              keyboardType: widget.keyBoardType,
              cursorColor: FlexoColorConstants.CURSOR_COLOR,
              textInputAction: TextInputAction.next,
              maxLines: widget.maxLine,
              maxLength: widget.maxLength,
              readOnly: widget.readOnly,
              // focusNode: FocusNode(),
            ),
          ),
          isEmpty? Container(child: FlexoTextWidget().controlsErrorText(text: widget.errorMsg)): Container(),
          isValidate? Container(child: FlexoTextWidget().controlsErrorText(text: widget.errorMsgForEmail))
              : Container()
        ],
      ),
    );
  }
}