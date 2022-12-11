/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Widgets/ShimmerAnimation.dart';
import 'package:provider/provider.dart';

class HomePageProducts{

  getHomePageProducts({required BuildContext context, required LocalResourceProvider localResourceProvider})
  {
    var homeProvider = context.watch<HomeProvider>();
    return homeProvider.isHomePageProductsLoader?
    Container(
      width: FlexoValues.deviceWidth,
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
      child: Wrap(
        children: [
          productShimmer(),
          productShimmer(),
          productShimmer(),
          productShimmer(),
        ],
      ),
    ):
    Container(
      width: FlexoValues.deviceWidth,
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: homeProvider.getHomepageProductsModel.map((e) {
          return Container(
            child: ProductBox().getProductBox(context: context,productBoxModel: e,localResourceProvider: localResourceProvider,updateHeaderData: homeProvider.getHeaderData),
          );
        }).toList(),
      ),
    );
  }

  getHomePageBestSeller({required BuildContext context, required LocalResourceProvider localResourceProvider})
  {
    var homeProvider = context.watch<HomeProvider>();
    return homeProvider.isHomePageBestSellerLoader?
    Container(
      width: FlexoValues.deviceWidth,
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
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
    ):
    Container(
      width: FlexoValues.deviceWidth,
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: homeProvider.getHomepageBestSellerModel.map((e) {
            return Container(
              child: ProductBox().getHorizontalProductBox(context: context,productBoxModel: e,localResourceProvider: localResourceProvider,updateHeaderData: homeProvider.getHeaderData),
            );
          }).toList(),
        ),
      ),
    );
  }

  productShimmer()
  {
    return Container(
      width: FlexoValues.deviceWidth * 0.49,
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
      alignment: Alignment.center,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
            highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR,
            period: Duration(seconds: 1),
            direction: ShimmerDirection.ltr,
            child: Container(
              width: FlexoValues.deviceWidth * 0.48,
              height: FlexoValues.deviceWidth * 0.48,
              color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
            ),
          ),
          SizedBox(
            height: FlexoValues.heightSpace1Px,
          ),

          Shimmer.fromColors(
            baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
            highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR,
            period: Duration(seconds: 1),
            direction: ShimmerDirection.ltr,
            child: Container(
              width: FlexoValues.deviceWidth * 0.48,
              height: FlexoValues.deviceWidth * 0.06,
              alignment: Alignment.center,
              color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
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
      padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
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
            height: FlexoValues.heightSpace1Px,
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