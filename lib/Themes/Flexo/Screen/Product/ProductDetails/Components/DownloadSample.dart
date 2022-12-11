/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class DownloadSample {
  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return Column(
      children: [
        Container(
          child: Column(
            children: [

              getProductDetailsModel.hasSampleDownload?
              Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                alignment: Alignment.centerLeft,
                width: FlexoValues.deviceWidth,
                child: Column(
                  children: [
                    SizedBox(height: FlexoValues.heightSpace1Px,),
                    GestureDetector(
                      onTap: ()async{
                         productDetailsProvider.downloadSample(context: context,productId: getProductDetailsModel.id);
                      },
                      child: Container(
                        height: FlexoValues.deviceHeight * 0.05,
                        color: Colors.grey.shade300,
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.download_outlined,
                              size: FlexoValues.iconSize20,
                              color: FlexoColorConstants.DARK_TEXT_COLOR,
                            ),

                            SizedBox(width: FlexoValues.widthSpace2Px,),

                            FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("products.downloadSample"),),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: FlexoValues.widthSpace4Px)
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ],
    );
  }
}