/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'TextWidget.dart';

class ButtonWidget {
  getButton({required String text,required double width,required Function() onClick, required bool isApiLoad})
  {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: width,
        alignment: Alignment.center,
        height: FlexoValues.controlsHeight,
        color: FlexoColorConstants.BUTTON_COLOR,
        child: FlexoTextWidget().buttonText(text: text,maxLines: 1)
      ),
    );
  }

  getBackButton({required String text,required double width,required Function() onClick, required bool isApiLoad})
  {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          width: width,
          alignment: Alignment.center,
          height: FlexoValues.controlsHeight,
          color: FlexoColorConstants.BUTTON_COLOR_GREY,
          child: FlexoTextWidget().buttonText(text: text,maxLines: 1)
      ),
    );
  }

  getBorderButton({required String text,required double width,required Function() onClick, required bool isApiLoad})
  {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: FlexoColorConstants.BUTTON_COLOR
          ),
          color: FlexoColorConstants.BUTTON_TEXT_COLOR,
        ),
          alignment: Alignment.center,
        width: width,
        height: FlexoValues.controlsHeight,
        child: FlexoTextWidget().borderButtonText(text: text,maximumLine: 1)
      ),
    );
  }

  getRatioButton({required String text,required bool isCheck})
  {
    return Container(
        padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
        decoration: BoxDecoration(
          color: isCheck ? FlexoColorConstants.ACCENT_COLOR : Colors.white,
          borderRadius: BorderRadius.zero,
          border: Border.all(
              color: isCheck ? FlexoColorConstants.ACCENT_COLOR : FlexoColorConstants.THEME_COLOR,
              width: 1
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isCheck ? Colors.white : FlexoColorConstants.ACCENT_COLOR,
              fontSize: FlexoValues.fontSize15,
              fontWeight: FontWeight.normal
          ),
        )
    );
  }
}
