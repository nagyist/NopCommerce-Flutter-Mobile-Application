/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Widgets/ShimmerAnimation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePageNivoSlider
{
  Container getHomePageNivoSlider({required BuildContext context})
  {

    var homeProvider = context.watch<HomeProvider>();
    return homeProvider.isNivoLoader ?
         Container(
           width: FlexoValues.deviceWidth,
           height: FlexoValues.deviceHeight * 0.25,
           child: Shimmer.fromColors(
               child: Container(
                 width: FlexoValues.deviceWidth,
                 height: FlexoValues.deviceHeight * 0.25,
                 color: FlexoColorConstants.SHIMMER_BACKGROUND_COLOR,
               ),
               baseColor: FlexoColorConstants.SHIMMER_BASE_COLOR,
               highlightColor: FlexoColorConstants.SHIMMER_HIGH_LITE_COLOR
           ),
         ) :
          Container(
             width: FlexoValues.deviceWidth,
             height: FlexoValues.deviceHeight * 0.25,
             child: CarouselSlider(
               items: homeProvider.nivoSlider.map((e){
                     return GestureDetector(
                         onTap: (){
                           launch(e.link);
                         },
                         child: Stack(
                           children: [
                             Container(
                               width: FlexoValues.deviceWidth,
                               height: FlexoValues.deviceHeight * 0.25,
                               child: CachedNetworkImage(
                                 imageUrl: e.pictureUrl,
                                 fit: BoxFit.fill,
                               ),
                             ),
                            e.text == '' || e.text == null ?Container():
                            Positioned(
                              bottom: 0,
                              child: Container(
                                 width: FlexoValues.deviceWidth,
                                 alignment: Alignment.bottomCenter,
                                 color: Colors.black54,
                                 padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                 child: Text(
                                   e.text,
                                   maxLines: 5,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontSize: FlexoValues.fontSize15
                                   ),
                                 ),
                               ),
                            )
                           ],
                         )
                     );
               }).toList(),
               options: CarouselOptions(
                 height: FlexoValues.deviceWidth,
                 viewportFraction: 1,
                 enableInfiniteScroll: true,
                 autoPlayInterval: Duration(seconds: 3),
                 autoPlay: true,
                 autoPlayAnimationDuration: Duration(seconds: 1),
               ),
            ),
          );
  }
}