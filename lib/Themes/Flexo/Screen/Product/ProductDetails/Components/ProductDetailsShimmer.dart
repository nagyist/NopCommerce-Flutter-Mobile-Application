/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Widgets/ShimmerAnimation.dart';

class ProductDetailsShimmer {

  getView()
  {
    return Container(
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Column(
              children: [
                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.7,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.3,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Row(
                  children: [
                    Shimmer.fromColors(
                        child:  Container(
                          width: FlexoValues.deviceWidth * 0.25,
                          height: FlexoValues.deviceHeight * 0.03,
                          color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                        ),
                        baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                        highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                    ),

                    SizedBox(width: FlexoValues.widthSpace2Px,),

                    Shimmer.fromColors(
                        child:  Container(
                          width: FlexoValues.deviceWidth * 0.2,
                          height: FlexoValues.deviceHeight * 0.03,
                          color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                        ),
                        baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                        highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                    ),

                    SizedBox(width: FlexoValues.widthSpace2Px,),

                    Shimmer.fromColors(
                        child:  Container(
                          width: FlexoValues.deviceWidth * 0.3,
                          height: FlexoValues.deviceHeight * 0.03,
                          color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                        ),
                        baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                        highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                    ),
                  ],
                ),

                SizedBox(height: FlexoValues.heightSpace2Px,),

                Container(
                  width: FlexoValues.deviceWidth * 0.96,
                  height: FlexoValues.deviceWidth * 0.96,
                  child: Shimmer.fromColors(
                      child: Container(
                        width: FlexoValues.deviceWidth,
                        height: FlexoValues.deviceHeight * 0.25,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.7,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.3,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.4,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.5,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                        child:  Container(
                          width: FlexoValues.deviceWidth * 0.30,
                          height: FlexoValues.deviceWidth * 0.1,
                          color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                        ),
                        baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                        highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                    ),

                    SizedBox(width: FlexoValues.widthSpace2Px,),

                    Shimmer.fromColors(
                        child:  Container(
                          width: FlexoValues.deviceWidth * 0.6,
                          height: FlexoValues.deviceWidth * 0.1,
                          color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                        ),
                        baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                        highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                    ),
                  ],
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

              ],
            ),
          ),

          Container(
            width: FlexoValues.deviceWidth,
            child: Column(
              children: [

                Shimmer.fromColors(
                    child: Divider(color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,thickness: 1,),
                    baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                    highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  width: FlexoValues.deviceWidth,
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                      child:  Container(
                        width: FlexoValues.deviceWidth * 0.9,
                        height: FlexoValues.deviceHeight * 0.03,
                        color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                      ),
                      baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                      highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        productHorizontalShimmer(),
                        productHorizontalShimmer(),
                        productHorizontalShimmer(),
                        productHorizontalShimmer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getProductListShimmer()
  {
    return Container(
      width: FlexoValues.deviceWidth,
      child: Column(
        children: [

          Shimmer.fromColors(
              child: Divider(color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,thickness: 1,),
              baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
              highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
          ),

          SizedBox(height: FlexoValues.heightSpace1Px,),

          Container(
            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
            width: FlexoValues.deviceWidth,
            alignment: Alignment.centerLeft,
            child: Shimmer.fromColors(
                child:  Container(
                  width: FlexoValues.deviceWidth * 0.9,
                  height: FlexoValues.deviceHeight * 0.03,
                  color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
                ),
                baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  productHorizontalShimmer(),
                  productHorizontalShimmer(),
                  productHorizontalShimmer(),
                  productHorizontalShimmer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  productHorizontalShimmer()
  {
    return Container(
      width: FlexoValues.deviceWidth * 0.40,
      padding: EdgeInsets.all(FlexoValues.deviceWidth * 0.01),
      alignment: Alignment.center,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
            highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR,
            period: Duration(seconds: 1),
            direction: ShimmerDirection.ltr,
            child: Container(
              width: FlexoValues.deviceWidth * 0.38,
              height: FlexoValues.deviceWidth * 0.38,
              color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
            ),
          ),
          SizedBox(
            height: FlexoValues.deviceWidth * 0.02,
          ),

          Shimmer.fromColors(
            baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
            highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR,
            period: Duration(seconds: 1),
            direction: ShimmerDirection.ltr,
            child: Container(
              width: FlexoValues.deviceWidth * 0.38,
              height: FlexoValues.deviceHeight * 0.06,
              alignment: Alignment.center,
              color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}