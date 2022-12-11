/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Utils/Colors.dart';
import 'package:nopcommerce/Widgets/TextStyleWidget.dart';

class TextWidget {


  Widget dialogHeadingText({required String text,required int maximumLine}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maximumLine,
      style: TextStyleWidget.headingBoldTextStyle15,
    );
  }

  dialogTitleText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.headingTextStyle16,
    );
  }

  dialogContentText({required String text,int maxLines = 10,})
  {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle15,
    );
  }

  dialogButtonText({required String text,int maxLines = 1,})
  {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyleWidget.contentTextStyle15,
    );
  }
}