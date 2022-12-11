/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Common/DeviceCheck.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Utils/Colors.dart';
import 'package:nopcommerce/Utils/Strings.dart';
import 'package:nopcommerce/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Widgets/TextWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogBoxWidget {
  permissionBox({required BuildContext context, required String message})async{
    if(CheckDeviceType().isIOS())
    {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: TextWidget().dialogContentText(text: message),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.NOT_NOW_BUTTON),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.SETTINGS_BUTTON),
              onPressed: () async
              {
                openAppSettings();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }else{
      return showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      child: Icon(Ionicons.folder_open_outline),
                    ),

                    SizedBox(width: 15,),

                    Expanded(
                        child: Text(
                          message,
                          maxLines: 5,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleWidget.headingTextStyle16,
                        )
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: TextWidget().dialogContentText(text: StringConstants.NOT_NOW_BUTTON),
                ),
                TextButton(
                  onPressed:() async
                  {
                    openAppSettings();
                    Navigator.pop(context);
                  },
                  child: TextWidget().dialogContentText(text: StringConstants.SETTINGS_BUTTON),
                ),
              ],
            );
          });
    }
  }

  confirmationDialogBox({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelText,
    required String submitText,
    required bool isCancelable,
    required Function() onSubmit,
  })
  {
    if(CheckDeviceType().isIOS())
    {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: isCancelable,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: TextWidget().dialogTitleText(text: title),
          content: TextWidget().dialogContentText(text: title),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.CONTROL_CANCEL_BUTTON_STRING),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.CONTROL_OK_BUTTON_STRING),
              isDestructiveAction: true,
              onPressed: ()
              {
                Navigator.pop(context);
                onSubmit();
              },
            )
          ],
        ),
      );
    }else{
      return showDialog(
        context: context,
        barrierDismissible: isCancelable,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget().dialogTitleText(text: title),
            content: content == "" ? SizedBox(height: 0,) :TextWidget().dialogContentText(text: content),
            actions: [
              TextButton(
                child:TextWidget().dialogButtonText(text: StringConstants.CONTROL_CANCEL_BUTTON_STRING),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child:TextWidget().dialogButtonText(text: StringConstants.CONTROL_OK_BUTTON_STRING),
                onPressed: ()
                {
                  Navigator.pop(context);
                  onSubmit();
                },
              )
            ],
          );
        },
      );
    }
  }

  informationDialogBox({
    required BuildContext context,
    required String title,
    required String body,
    required String heading,
  }){

    if(CheckDeviceType().isIOS())
    {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: TextWidget().dialogTitleText(text: heading),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                title == "" ? Container() :
                Column(
                  children: [

                    SizedBox(height: 15,),

                    TextWidget().dialogContentText(text: title)

                  ],
                ),

                SizedBox(height: 15,),

                HtmlWidget(
                  '$body',
                  textStyle: TextStyleWidget.contentTextStyle15,
                  customStylesBuilder: (element) {
                    if (element.localName == 'a') {
                      return {'color': "#"+ColorConstants.HIGHLIGHT_COLOR.value.toRadixString(16).substring(2, 8)};
                    }
                    return null;
                  },
                  onTapUrl: (url)=> launch(url),
                ),
              ],
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.CONTROL_CLOSE_BUTTON_STRING),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }else{
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(5.0)),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Container(
                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: FlexoValues.deviceWidth*0.6,
                            child:
                            TextWidget().dialogHeadingText(text: heading, maximumLine: 3),
                          ),

                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Icon(
                                Icons.close_outlined,
                                color: ColorConstants.LIGHT_TEXT_COLOR,
                                size: FlexoValues.iconSize20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [

                            SizedBox(height: FlexoValues.widthSpace2Px,),

                            title == "" ? Container() :
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  child: TextWidget().dialogTitleText(text: title),
                                ),

                                Divider(color: ColorConstants.LIST_BORDER_COLOR,thickness: 1,),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              alignment: Alignment.center,
                              child: HtmlWidget(
                                '$body',
                                textStyle: TextStyleWidget.contentTextStyle15,
                                customStylesBuilder: (element) {
                                  if (element.localName == 'a') {
                                    return {'color': "#"+ColorConstants.HIGHLIGHT_COLOR.value.toRadixString(16).substring(2, 8)};
                                  }
                                  return null;
                                },
                                onTapUrl: (url)=> launch(url),
                              ),
                            ),

                            SizedBox(height:FlexoValues.widthSpace2Px,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

  }


  deleteItemDialogBox({
    required BuildContext context,
    required String title,
    required String cancelText,
    required String submitText,
    required bool isCancelable,
    required Function() onSubmit,
  })
  {
    if(CheckDeviceType().isIOS())
    {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: isCancelable,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: TextWidget().dialogTitleText(text: title),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.CONTROL_CANCEL_BUTTON_STRING),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: TextWidget().dialogButtonText(text: StringConstants.CONTROL_OK_BUTTON_STRING),
              isDestructiveAction: true,
              onPressed: ()
              {
                Navigator.pop(context);
                onSubmit();
              },
            )
          ],
        ),
      );
    }else{
      return showDialog(
        context: context,
        barrierDismissible: isCancelable,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget().dialogTitleText(text: title),
            actions: [
              TextButton(
                child:TextWidget().dialogButtonText(text: StringConstants.CONTROL_CANCEL_BUTTON_STRING),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child:TextWidget().dialogButtonText(text: StringConstants.CONTROL_OK_BUTTON_STRING),
                onPressed: ()
                {
                  Navigator.pop(context);
                  onSubmit();
                },
              )
            ],
          );
        },
      );
    }
  }
}