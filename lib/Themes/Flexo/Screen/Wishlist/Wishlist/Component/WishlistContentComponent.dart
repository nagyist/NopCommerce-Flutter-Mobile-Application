/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetailsById/TopicBlockDetailsById.dart';
import 'package:nopcommerce/Screens/Wishlist/EmailWishlist/EmailWishlist.dart';
import 'package:nopcommerce/Screens/Wishlist/Wishlist/WishlistProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/TaxDisplayType.dart';
import 'package:nopcommerce/Utils/Enum/TopicType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_html_css/simple_html_css.dart';

class WishlistContentComponent
{

  getWishlistContentComponent({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var wishlistProvider = context.watch<WishlistProvider>();

    return StatefulBuilder(builder: (context,setState){

      return Column(
        children: [

          SizedBox(height: FlexoValues.heightSpace1Px),

          Container(
            margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                wishlistProvider.wishlistModel.emailWishlistEnabled?
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageTransition(type: selectedTransition, child: EmailWishlist()));
                  },
                  child: Container(
                    width: FlexoValues.deviceWidth * 0.47,
                    height: FlexoValues.heightSpace5Px,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: FlexoColorConstants.BUTTON_COLOR,
                    ),
                    child: FlexoTextWidget().buttonText(text: localResourceProvider.getResourseByKey("wishlist.emailAFriend").toString().toUpperCase(),maxLines: 1),
                  ),
                ): Container(),

                wishlistProvider.wishlistModel.isEditable && wishlistProvider.wishlistModel.items.length > 0 ?
                wishlistProvider.wishlistShareURL != "" ?
                GestureDetector(
                  onTap: ()async{
                    if(!wishlistProvider.isAPILoader) {
                      wishlistProvider.sharedWishlist(context: context);
                    }
                  },
                  child: Container(
                    width: wishlistProvider.wishlistModel.emailWishlistEnabled ? FlexoValues.deviceWidth * 0.47 : FlexoValues.controlsWidth,
                    height: FlexoValues.heightSpace5Px,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: FlexoColorConstants.BUTTON_COLOR,
                    ),
                    child: FlexoTextWidget().buttonText(text: localResourceProvider.getResourseByKey("nopAdvance.plugin.publicApi.defaultClean.shareWishlist").toString().toUpperCase(),maxLines: 1),
                  ),
                ):
                Container():
                Container(),
              ],
            ),
          ),

          wishlistProvider.wishlistModel.items.length > 0 && wishlistProvider.wishlistModel.displayTaxShippingInfo ?
          Column(
            children: [

              SizedBox(height: FlexoValues.heightSpace1Px),

              Container(
                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: HTML.toTextSpan(
                      context,
                      wishlistProvider.taxTypeModel.currentTaxType == TaxDisplayType.IncludingTax ? localResourceProvider.getResourseByKey("wishlist.taxShipping.inclTax") : localResourceProvider.getResourseByKey("wishlist.taxShipping.exclTax"),
                      defaultTextStyle: TextStyleWidget.contentTextStyle15,
                      overrideStyle: {
                        "a": TextStyleWidget.redirectTextStyle16,
                      },
                      linksCallback: (url)
                      {
                        setState(()
                        {
                          Navigator.push(context, PageTransition(type: selectedTransition, child: TopicBlockDetailsById(name: "", seName: "ShippingInfo", topicId: 0, topicType: TopicType.SeName)));
                        });
                      }
                  ),
                ),
              ),

              SizedBox(height: FlexoValues.heightSpace1Px),
            ],
          ) : Container(),

        ],
      );
    });
  }
}
