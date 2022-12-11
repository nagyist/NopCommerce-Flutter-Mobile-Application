/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Widgets/FlushBarWidget/FlushBar.dart';

class FlushBarMessage{

  successMessage({required BuildContext context,required String title})
  {
    if(title.isNotEmpty) {
      return Flushbar(
        messageText: Text(
          title,
          maxLines: 20,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: FlexoValues.fontSize15
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace2Px),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        isDismissible: true,
      )..show(context);
    }
  }

  warningMessage({required BuildContext context,required String title})
  {
    if(title.isNotEmpty) {
      return Flushbar(
        messageText: Text(
          title,
          maxLines: 20,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: FlexoValues.fontSize15
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace2Px),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.yellow.shade700,
        duration: Duration(seconds: 3),
      )
        ..show(context);
    }
  }

  failedMessage({required BuildContext context,required String title})
  {
    if(title.isNotEmpty)
    {
      return Flushbar(
        messageText: Text(
          title,
          maxLines: 20,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: FlexoValues.fontSize15
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace2Px),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        duration:  Duration(seconds: 2),
        isDismissible: true,
      )..show(context);
    }
  }

  homeBackPress({required BuildContext context,required String message})
  {
    if(message.isNotEmpty) {
      return Flushbar(
        message: message,
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 1),
      )
        ..show(context);
    }
  }


  simpleMessage({required BuildContext context,required String title})
  {
    if(title.isNotEmpty) {
      return Flushbar(
        messageText: Text(
          title,
          maxLines: 20,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: FlexoValues.fontSize15
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px,horizontal: FlexoValues.widthSpace2Px),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.black54,
        duration: Duration(seconds: 2),
        isDismissible: true,
      )..show(context);
    }
  }

}



