/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Screens/Wishlist/Wishlist/WishlistProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class WishlistProductsComponent {
  getWishlistProductListComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var wishlistProvider = context.watch<WishlistProvider>();

    return StatefulBuilder(builder: (context, setState){

      return Container(
        child: Column(
          children: [

            wishlistProvider.wishlistModel.warnings.length > 0 ?
            Container(
              width: FlexoValues.controlsWidth,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: wishlistProvider.wishlistModel.warnings.map((w){
                  return Container(
                    child: FlexoTextWidget().warningMessageText(text: w),
                  );
                }).toList(),
              ),
            ) : Container(),

            Container(
              width: FlexoValues.deviceWidth,
              padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: wishlistProvider.wishlistModel.items.map((e){

                  return Container(
                    width: FlexoValues.deviceWidth * 0.49,
                    padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              wishlistProvider.wishlistModel.showProductImages ?
                              Stack(
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      setState(()
                                      {
                                        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: 0,isCart: false))).then((value)
                                        {
                                          setState(()
                                          {
                                            wishlistProvider.getWishlistData(context: context);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: FlexoValues.deviceWidth * 0.47,
                                      height: FlexoValues.deviceWidth * 0.47,
                                      child: CachedNetworkImage(
                                        imageUrl: e.picture.imageUrl,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: FlexoValues.deviceWidth * 0.47,
                                    height: FlexoValues.deviceWidth * 0.47,
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        wishlistProvider.wishlistModel.displayAddToCart ?
                                        Container(
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap:() async {
                                                  setState(() {
                                                    wishlistProvider.addToCartWishlistItem(context: context, itemId: e.id);
                                                  });
                                                },
                                                child: Container(
                                                    child: CircleAvatar(
                                                      child: Icon(
                                                        Ionicons.cart_outline,
                                                        color: FlexoColorConstants.THEME_COLOR,
                                                        size: FlexoValues.iconSize18,
                                                      ),
                                                      maxRadius: FlexoValues.deviceHeight * 0.022,
                                                      backgroundColor: Colors.white,
                                                    ),
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: new Border.all(
                                                        color: FlexoColorConstants.BORDER_COLOR,
                                                        width: 1,
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) : Container(),

                                        SizedBox(height: FlexoValues.widthSpace2Px),

                                        GestureDetector(
                                          onTap:() async {
                                            wishlistProvider.deleteWishlistItem(context: context, itemId: e.id);
                                          },
                                          child: Container(
                                              child: CircleAvatar(
                                                child: Icon(
                                                  Ionicons.trash_outline,
                                                  color: FlexoColorConstants.THEME_COLOR,
                                                  size: FlexoValues.iconSize18,
                                                ),
                                                maxRadius: FlexoValues.deviceHeight * 0.022,
                                                backgroundColor: Colors.white,
                                              ),
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: new Border.all(
                                                  color: FlexoColorConstants.BORDER_COLOR,
                                                  width: 1,
                                                ),
                                              )
                                          ),
                                        ),

                                        e.allowItemEditing && wishlistProvider.wishlistModel.isEditable?
                                        Container(
                                          child: Column(
                                            children: [
                                              SizedBox(height: FlexoValues.widthSpace2Px),

                                              GestureDetector(
                                                onTap:()async{
                                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: e.id,isCart: false))).then((value)
                                                  {
                                                    setState(()
                                                    {
                                                      wishlistProvider.getWishlistData(context: context);
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                    child: CircleAvatar(
                                                      child: Icon(
                                                        Ionicons.pencil_outline,
                                                        color: FlexoColorConstants.THEME_COLOR,
                                                        size: FlexoValues.iconSize18,
                                                      ),
                                                      maxRadius: FlexoValues.deviceHeight * 0.022,
                                                      backgroundColor: Colors.white,
                                                    ),
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: new Border.all(
                                                        color: FlexoColorConstants.BORDER_COLOR,
                                                        width: 1,
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ):Container(),

                              Container(
                                width: FlexoValues.deviceWidth * 0.47,
                                alignment: Alignment.topRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                        setState(()
                                        {
                                          Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: 0,isCart: false))).then((value)
                                          {
                                            setState(()
                                            {
                                              wishlistProvider.getWishlistData(context: context);
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: FlexoValues.heightSpace3Px,
                                        alignment: Alignment.topCenter,
                                        child: FlexoTextWidget().productBoxText(text: e.productName,maxLines: 1),
                                        width: FlexoValues.deviceWidth * 0.45,
                                      ),
                                    ),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          SizedBox(height: FlexoValues.widthSpace1Px),

                                          e.sku == null ? Container () :
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [

                                                        wishlistProvider.wishlistModel.showSku?
                                                        Container(
                                                            child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("shoppingCart.sku")+": ",),
                                                        ):Container(),

                                                        Flexible(
                                                          child: Container(
                                                            child: FlexoTextWidget().contentText15(text: e.sku != null ? e.sku : "",maxLines: 1),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),

                                                SizedBox(height: FlexoValues.heightSpace1Px),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: FlexoValues.deviceWidth * 0.45,
                                            alignment: Alignment.bottomCenter,
                                            child: FlexoTextWidget().productPriceText(text: e.unitPrice,maxLines: 1),
                                          ),

                                          wishlistProvider.wishlistModel.showProductImages?Container():
                                          Container(
                                            width: FlexoValues.deviceWidth * 0.47,
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                                            child: Row(
                                              mainAxisAlignment:e.allowItemEditing && wishlistProvider.wishlistModel.isEditable?MainAxisAlignment.spaceEvenly:MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap:() async {
                                                    wishlistProvider.deleteWishlistItem(context: context, itemId: e.id);
                                                  },
                                                  child: Container(
                                                      child: CircleAvatar(
                                                        child: Icon(
                                                          Ionicons.trash_outline,
                                                          color: FlexoColorConstants.THEME_COLOR,
                                                          size: FlexoValues.iconSize18,
                                                        ),
                                                        maxRadius: FlexoValues.deviceHeight * 0.022,
                                                        backgroundColor: Colors.white,
                                                      ),
                                                      decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: new Border.all(
                                                          color: FlexoColorConstants.BORDER_COLOR,
                                                          width: 1,
                                                        ),
                                                      )
                                                  ),
                                                ),

                                                e.allowItemEditing && wishlistProvider.wishlistModel.isEditable?
                                                Container(
                                                  child: GestureDetector(
                                                    onTap:()async{
                                                      Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId,updateId: e.id,isCart: false))).then((value)
                                                      {
                                                        setState(()
                                                        {
                                                          wishlistProvider.getWishlistData(context: context);
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                        child: CircleAvatar(
                                                          child: Icon(
                                                            Ionicons.pencil_outline,
                                                            color: FlexoColorConstants.THEME_COLOR,
                                                            size: FlexoValues.iconSize18,
                                                          ),
                                                          maxRadius: FlexoValues.deviceHeight * 0.022,
                                                          backgroundColor: Colors.white,
                                                        ),
                                                        decoration: new BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: new Border.all(
                                                            color: FlexoColorConstants.BORDER_COLOR,
                                                            width: 1,
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ) : Container(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                         ),
                        SizedBox(width: FlexoValues.widthSpace1Px),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}