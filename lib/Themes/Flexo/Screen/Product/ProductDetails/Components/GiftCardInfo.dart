/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/GiftCardType.dart';
import 'package:provider/provider.dart';

class GiftCardInfo {
  getView({required BuildContext context, required GiftCard giftCard})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              children: [

                giftCard.isGiftCard ?
                Column(
                  children: [

                    Container(
                      width: FlexoValues.deviceWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          attributeHeading(heading: localResourceProvider.getResourseByKey("products.giftcard.recipientName"), isRequired: true, description: ""),

                          SizedBox(height: FlexoValues.widthSpace1Px),

                          TextFieldAttributeWidgets(
                            width: FlexoValues.controlsWidth,
                            initialValue: giftCard.recipientName,
                            showRequiredIcon: false,
                            required: true,
                            onChange: (val)
                            {
                              setState(()
                              {
                                giftCard.recipientName=val;
                              });
                            },
                            onSaved: (val)
                            {
                              setState(()
                              {
                                giftCard.recipientName=val!;
                              });
                            },
                          ),

                          SizedBox(height: FlexoValues.widthSpace2Px),

                          giftCard.giftCardType == GiftCardType.Virtual ?
                          Container(
                            child: Column(
                              children: [

                                attributeHeading(heading: localResourceProvider.getResourseByKey("products.giftcard.recipientEmail"), isRequired: true, description: ""),

                                SizedBox(height: FlexoValues.widthSpace1Px),

                                TextFieldAttributeWidgets(
                                  width: FlexoValues.controlsWidth,
                                  initialValue: giftCard.recipientEmail,
                                  showRequiredIcon: false,
                                  required: true,
                                  onChange: (val)
                                  {
                                    setState(()
                                    {
                                      giftCard.recipientEmail=val;
                                    });
                                  },
                                  onSaved: (val)
                                  {
                                    setState(()
                                    {
                                      giftCard.recipientEmail=val!;
                                    });
                                  },
                                ),

                                SizedBox(height: FlexoValues.widthSpace2Px),
                              ],
                            ),
                          ) : Container(),


                          attributeHeading(heading: localResourceProvider.getResourseByKey("products.giftcard.senderName"), isRequired: true, description: ""),

                          SizedBox(height: FlexoValues.widthSpace1Px),

                          TextFieldAttributeWidgets(
                            width: FlexoValues.controlsWidth,
                            initialValue: giftCard.senderName,
                            showRequiredIcon: false,
                            required: true,
                            onChange: (val)
                            {
                              setState(()
                              {
                                giftCard.senderName=val;
                              });
                            },
                            onSaved: (val)
                            {
                              setState(()
                              {
                                giftCard.senderName=val!;
                              });
                            },
                          ),

                          SizedBox(height: FlexoValues.widthSpace2Px),

                          giftCard.giftCardType == GiftCardType.Virtual ?
                          Container(
                            child: Column(
                              children: [

                                attributeHeading(heading: localResourceProvider.getResourseByKey("products.giftcard.senderEmail"), isRequired: true, description: ""),

                                SizedBox(height: FlexoValues.widthSpace1Px),

                                TextFieldAttributeWidgets(
                                  width: FlexoValues.controlsWidth,
                                  initialValue: giftCard.senderEmail,
                                  showRequiredIcon: false,
                                  required: true,
                                  onChange: (val)
                                  {
                                    setState(()
                                    {
                                      giftCard.senderEmail=val;
                                    });
                                  },
                                  onSaved: (val)
                                  {
                                    setState(()
                                    {
                                      giftCard.senderEmail=val!;
                                    });
                                  },
                                ),

                                SizedBox(height: FlexoValues.widthSpace2Px),
                              ],
                            ),
                          ) : Container(),


                          attributeHeading(heading: localResourceProvider.getResourseByKey("products.giftcard.message"), isRequired: false, description: ""),

                          SizedBox(height: FlexoValues.widthSpace1Px),

                          TextFieldAttributeWidgets(
                            width: FlexoValues.controlsWidth,
                            initialValue: giftCard.message,
                            maxLine: 5,
                            required: true,
                            showRequiredIcon: false,
                            onChange: (val)
                            {
                              setState(()
                              {
                                giftCard.message=val;
                              });
                            },
                            onSaved: (val)
                            {
                              setState(()
                              {
                                giftCard.message=val!;
                              });
                            },
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace2Px,),
                  ],
                ) : Container(),
              ],
            ),
          ),
        ],
      );
    });
  }

  attributeHeading({required String heading, required bool isRequired, required String description})
  {
    return Container(
      child: Column(
        children: [
          Container(
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
          ),

          description == "" ? Container() :
          Container(
            width: FlexoValues.controlsWidth,
            child: Column(
              children: [

                SizedBox(height: FlexoValues.widthSpace1Px),

                Container(
                  width: FlexoValues.controlsWidth,
                  child: FlexoTextWidget().contentText15(text: description,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}