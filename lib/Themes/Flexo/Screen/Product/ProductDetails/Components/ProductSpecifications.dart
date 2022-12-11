/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/ProductSpecificationModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/SpecificationAttributes.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class ProductSpecifications {
  getView({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    ProductSpecificationModel productSpecificationModel = productDetailsProvider.getProductDetailsModel.productSpecificationModel;
    int rowCount = 0;
    for(var group in productSpecificationModel.groups)
    {
      rowCount += group.attributes.length;
    }

    return rowCount > 0 ?
    StatefulBuilder(builder: (context, setState)
    {
      return Column(
        children: [

          Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,),

          Container(
            width: FlexoValues.deviceWidth,
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("Products.Specs")),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Column(
                          children: productSpecificationModel.groups.map((group)
                          {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                group.attributes.length > 0 ?
                                group.id > 0 ?
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
                                        child: FlexoTextWidget().headingBoldText15(text: group.name)
                                    )
                                : Container()
                                : Container(),

                                Container(
                                  width: FlexoValues.deviceWidth * 0.96,
                                  child: Table(
                                    columnWidths: {
                                      0:FlexColumnWidth(FlexoValues.deviceWidth * 0.36),
                                      1:FlexColumnWidth(FlexoValues.deviceWidth * 0.6),
                                    },
                                    border: TableBorder.all(color:FlexoColorConstants.LIST_BORDER_COLOR,width: 1),
                                    textBaseline: TextBaseline.alphabetic,
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    children: group.attributes.map((attr)
                                    {
                                      return TableRow(
                                        children: [
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.36,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            child: FlexoTextWidget().headingText15(text: attr.name),
                                          ),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.6,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                            child: StatefulBuilder(builder: (context, setState)
                                            {
                                              for(var value in attr.values)
                                              {
                                                if(value.colorSquaresRgb != null && (value.attributeTypeId == SpecificationType.Option))
                                                {
                                                  int colorCode = int.parse(value.colorSquaresRgb.replaceAll("#", "0xff"));

                                                  return Container(
                                                    width: FlexoValues.deviceWidth * 0.1,
                                                    height: FlexoValues.deviceWidth * 0.1,
                                                    color: Color(colorCode),
                                                  );
                                                }else{
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                    child: RichText(
                                                      text: HTML.toTextSpan(
                                                        context,
                                                        value.valueRaw,
                                                        defaultTextStyle: TextStyleWidget.contentTextStyle15,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }

                                              return FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("Products.Specs.AttributeValue"));
                                            }),
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),

                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

              ],
            ),
          ),
        ],
      );
    }) : Container();
  }
}