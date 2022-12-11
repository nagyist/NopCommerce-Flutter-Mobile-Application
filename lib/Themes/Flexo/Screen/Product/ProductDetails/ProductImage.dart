/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Models/PictureBoxModel.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';

class ProductImage extends StatefulWidget {
  List<PictureModel> pictureModel;
  String defaultImage;
  ProductImage({required this.pictureModel,required this.defaultImage});


  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int imageIndex=0;

  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imageIndex = widget.pictureModel.indexWhere((element) => element.imageUrl == widget.defaultImage);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context,setState){
      return Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: "Product Image", backButton: true),
        body: SafeArea(
          child: Container(
            color: FlexoColorConstants.BACKGROUND_COLOR,
            child: Container(
              width: FlexoValues.deviceWidth,
              height: FlexoValues.deviceHeight,
              margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
              color: Colors.white,
              child:  Column(
                children: [
                  Expanded(
                    child: Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            initialPage: imageIndex,
                            height: FlexoValues.deviceWidth,
                            disableCenter: true,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            onPageChanged: (index,reason){
                              setState(() {
                                imageIndex = index;
                                widget.defaultImage = widget.pictureModel[index].imageUrl;
                              });
                            },
                          ),
                          carouselController: _controller,
                          items: widget.pictureModel.map((e){
                            return Container(
                              width: FlexoValues.deviceWidth,
                              child: CachedNetworkImage(imageUrl: e.imageUrl,),
                            );
                          }).toList(),
                        )
                    ),
                  ),
                  widget.pictureModel.length>1?
                  Column(
                    children: [
                      SizedBox(height: FlexoValues.widthSpace4Px),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.pictureModel.map((e){
                              return GestureDetector(
                                child: Container(
                                  height: FlexoValues.deviceWidth * 0.15,
                                  width: FlexoValues.deviceWidth * 0.15,
                                  margin: EdgeInsets.only(right: FlexoValues.widthSpace2Px),
                                  decoration: BoxDecoration(
                                    border:Border.all(
                                        color:e.imageUrl == widget.defaultImage ? Colors.black : Colors.grey
                                    ),
                                  ),
                                  child: CachedNetworkImage(imageUrl: e.imageUrl),
                                ),
                                onTap: (){
                                  setState(() {
                                    widget.defaultImage = e.imageUrl;
                                    imageIndex = imageIndex = widget.pictureModel.indexWhere((element) => element.imageUrl == widget.defaultImage);
                                    _controller.jumpToPage(imageIndex);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ):Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
