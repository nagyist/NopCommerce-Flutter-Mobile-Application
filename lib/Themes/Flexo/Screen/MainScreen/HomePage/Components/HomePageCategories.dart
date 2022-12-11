/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Catalog/ProductsByCategory/ProductByCategory.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:nopcommerce/Widgets/ShimmerAnimation.dart';
import 'package:provider/provider.dart';

class HomePageCategories {
  getHomePageCategories({required BuildContext context}) {
    var homeProvider = context.watch<HomeProvider>();
    return homeProvider.isHomePageCategoryLoader
        ? Container(
            width: FlexoValues.deviceWidth,
            child: Shimmer.fromColors(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        categoryShimmer(),
                        categoryShimmer(),
                        categoryShimmer(),
                        categoryShimmer(),
                      ],
                    ),
                  ),
                ),
                baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
                highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR),
          )
        : Container(
            width: FlexoValues.deviceWidth,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: homeProvider.getHomepageCategoriesModel.map((e) {
                    return GestureDetector(
                      onTap: () {
                        if (e.subCategories.isEmpty) {
                           Navigator.push(context, PageTransition(type: selectedTransition, child: ProductByCategory(categoryId: e.id)));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                maxRadius: FlexoValues.deviceWidth * 0.07,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: CachedNetworkImageProvider(
                                  e.pictureModel.imageUrl,
                                )),
                            Container(
                              width: FlexoValues.deviceWidth * 0.20,
                              padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                              color: Colors.white,
                              child: Text(
                                e.name.toUpperCase(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: FlexoColorConstants.DARK_TEXT_COLOR,
                                  fontSize: FlexoValues.fontSize12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }

  categoryShimmer()
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
      child: Column(
        children: [

          CircleAvatar(
            maxRadius: FlexoValues.deviceWidth * 0.07,
            backgroundColor: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
          ),

          SizedBox(height: FlexoValues.widthSpace1Px),

          Container(
            width: FlexoValues.deviceWidth * 0.20,
            height: FlexoValues.heightSpace3Px,
            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
            color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
          )
        ],
      ),
    );
  }
}
