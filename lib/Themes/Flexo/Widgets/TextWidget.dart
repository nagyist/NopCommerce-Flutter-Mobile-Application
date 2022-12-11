/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';

class FlexoTextWidget {

  Widget appbarText({required String text,int maxLines = 10,})
  {
    return Text(
      text.toUpperCase(),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.appbarTextStyle
    );
  }

  Widget buttonText({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.buttonTextStyle,
    );
  }


  Widget borderButtonText({required String text,required int maximumLine}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maximumLine,
      style: TextStyleWidget.borderButtonTextStyle,
    );
  }

  Widget controlsText({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.headingTextStyle16,
    );
  }

  Widget dropdownControlsText({required String text,int maxLines = 1}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.dropdownControlTextStyle,
    );
  }

  Widget redirectText14({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.redirectTextStyle14,
    );
  }


  Widget redirectText15({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.redirectTextStyle15,
    );
  }

  Widget redirectText16({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.redirectTextStyle16
    );
  }

  Widget redirectText17({required String text,int maxLines = 10}) {
    return Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        style: TextStyleWidget.redirectTextStyle17
    );
  }

  Widget redirectBoldText15({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.redirectBoldTextStyle15
    );
  }


  Widget redirectBoldText16({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.redirectBoldTextStyle16,
    );
  }

  Widget productPriceText({required String text,int maxLines = 10}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyleWidget.priceTextStyle
    );
  }

  Widget controlsErrorText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.errorTextStyle14
    );
  }

  Widget controlsRequiredText({required String text,int maxLines = 10,})
  {
    return Text(
      text.toUpperCase(),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.controlsRequiredMessage
    );
  }


  Widget headingBoldText14({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingBoldTextStyle14
    );
  }

  Widget headingBoldText15({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingBoldTextStyle15
    );
  }

  Widget headingBoldText16({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingBoldTextStyle16
    );
  }

  Widget headingBoldText17({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style:TextStyleWidget.headingBoldTextStyle17
    );
  }

  Widget headingBoldText18({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingBoldTextStyle18
    );
  }

  Widget headingText14({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle14
    );
  }

  Widget headingText15({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle15
    );
  }

  Widget headingText16({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle16
    );
  }



  Widget headingCenterText16({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.headingTextStyle16
    );
  }

  Widget headingText17({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle17
    );
  }

  Widget headingText18({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle18
    );
  }

  Widget contentText12({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.contentTextStyle12
    );
  }

  Widget contentText13({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.contentTextStyle13
    );
  }

  Widget contentText14({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle14
    );
  }

  Widget contentText15({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle15
    );
  }

  Widget contentText16({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle16
    );
  }

  Widget contentText17({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle17
    );
  }

  Widget contentText18({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle18
    );
  }

  Widget productBoxText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.productBoxTextStyle
    );
  }

  Widget productBoxHorizontalText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.productBoxHorizontalTextStyle,
    );
  }

  warningMessageText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.errorTextStyle15
    );
  }


  browseButtonText({required String text})
  {
    return Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.browseButtonTextStyle
    );
  }

  Widget menuItemText({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.menuItemTextStyle
    );
  }

  Widget richTextContentText16({required String text,int maxLines = 10,required List<String> subTextList})
  {
    return RichText(
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: new TextSpan(
          text: text,
          style: TextStyleWidget.contentTextStyle16,
          children: subTextList.map((subText)
          {
            return TextSpan(
              text: subText,
              style: TextStyleWidget.contentTextStyle16,
            );
          }).toList()
      ),
    );
  }

  Widget subTotalLeftText({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.headingTextStyle16
    );
  }

  Widget subTotalRightText({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.headingTextStyle16
    );
  }

  Widget subTotalLeftTextBold({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.headingBoldTextStyle17
    );
  }

  Widget subTotalRightTextBold({required String text,int maxLines = 10,})
  {
    return Text(
        text,
        maxLines: maxLines,
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        style: TextStyleWidget.headingBoldTextStyle17
    );
  }

}