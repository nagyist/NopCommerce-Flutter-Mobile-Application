/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import '../RequiredIconWidget.dart';
import '../TextStyleWidget.dart';
import '../TextWidget.dart';

class TextFieldConfirmPasswordWidget extends StatefulWidget {
  final double width;
  final int maxLine;
  final int maxLength;
  final bool readOnly;
  final TextEditingController controller;
  final TextEditingController controller2;
  final String hintText;
  final String heading;
  final TextInputType keyBoardType;
  final bool required;
  final bool showRequiredIcon;
  final bool isPassword;
  final String errorMsg;
  final String errorMsgConfirmPassword;
  final IconData icon;

  TextFieldConfirmPasswordWidget({
    required this.width,
    required this.controller,
    required this.controller2,
    this.hintText = "",
    this.heading = "",
    this.keyBoardType = TextInputType.name,
    this.required = false,
    this.showRequiredIcon = true,
    this.errorMsg = "",
    this.errorMsgConfirmPassword = "",
    this.maxLine = 1,
    this.maxLength = 100000,
    this.readOnly = false,
    this.isPassword = false,
    required this.icon,
  });

  @override
  State<TextFieldConfirmPasswordWidget> createState() => _TextFieldConfirmPasswordWidgetState();
}

class _TextFieldConfirmPasswordWidgetState extends State<TextFieldConfirmPasswordWidget> {
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
          Row(
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
                      color: isValidate|| isEmpty
                          ? FlexoColorConstants.ERROR_TEXT_COLOR
                          : FlexoColorConstants.BORDER_COLOR,
                    ),
                    color: FlexoColorConstants.CONTROL_BACKGROUND_COLOR),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: widget.controller,
                  style: TextStyleWidget.controlsTextStyle,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: FlexoValues.horizontalPadding),
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorMaxLines: 1,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                    suffixIcon: widget.isPassword? GestureDetector(
                      child: Icon(
                        !isVisible
                            ? Ionicons.eye_off_outline
                            : Ionicons.eye_outline,
                        color: Colors.black,
                        size: FlexoValues.iconSize18,
                      ),
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    )
                        : const SizedBox(width: 0),
                    isCollapsed: true,
                    isDense: true,
                    filled: true,
                    hintText: widget.hintText,
                    hintStyle: TextStyleWidget.hintTextStyle,
                    fillColor: FlexoColorConstants.BUTTON_TEXT_COLOR,
                    counterText: "",
                    errorText: "",
                    prefixIcon: Icon(
                      widget.icon,
                      color: FlexoColorConstants.TEXT_FIELD_ICON_COLOR,
                      size: FlexoValues.iconSize18,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      if (val == widget.controller2.text) {
                        setState(() {
                          isEmpty = false;
                          isValidate = false;
                        });
                        return null;
                      } else {
                        setState(() {
                          isEmpty = false;
                          isValidate = true;
                        });
                        return '';
                      }
                    } else {
                      setState(() {
                        isEmpty = true;
                      });
                      return null;
                    }
                  },
                  keyboardType: widget.keyBoardType,
                  cursorColor: FlexoColorConstants.CURSOR_COLOR,
                  textInputAction: TextInputAction.next,
                  maxLines: widget.maxLine,
                  maxLength: widget.maxLength,
                  readOnly: widget.readOnly,
                  obscureText: isVisible ? widget.isPassword : false,
                  // focusNode: FocusNode(),
                ),
              ),

              widget.required  ? RequiredIconWidget() : SizedBox(width: 0,)
            ],
          ),
          isEmpty
              ? Container(
              child: FlexoTextWidget()
                  .controlsErrorText(text: widget.errorMsg))
              : Container(),
          isValidate
              ? Container(
              child: FlexoTextWidget()
                  .controlsErrorText(text: widget.errorMsgConfirmPassword))
              : Container()
        ],
      ),
    );
  }
}
