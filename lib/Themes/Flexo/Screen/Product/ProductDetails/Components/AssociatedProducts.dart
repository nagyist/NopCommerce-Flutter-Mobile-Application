/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopcommerce/Models/AllowedQuantityModel.dart';
import 'package:nopcommerce/Models/CountryStateModel.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/ProductDetailsAttributeChangeModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductEstimateShipping/Models/ProductEstimateShippingChangeRequestModel.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/ProductDetails/Components/ProductAttribute.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoCustomDropDown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextFormWidgets/TextFieldAttributeWidgets.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/AddToCartType.dart';
import 'package:nopcommerce/Utils/Enum/TextFieldType.dart';
import 'package:nopcommerce/Utils/hide_keyboard.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AddToCart.dart';
import 'DeliveryInfo.dart';
import 'DownloadSample.dart';
import 'GiftCardInfo.dart';
import 'ProductAvailability.dart';
import 'ProductEstimateShipping.dart';
import 'ProductPrice.dart';
import 'ProductTierPrices.dart';
import 'RentalInfo.dart';
import 'SKU_Man_GTIN_Ven.dart';

class AssociatedProducts {
  getView({required BuildContext context})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return StatefulBuilder(builder: (context, setState)
    {

      return Column(
        children: productDetailsProvider.getProductDetailsModel.associatedProducts.map((e)
        {


          if(e.productEstimateShipping.enabled)
          {
            if(e.productEstimateShipping.countryId == null || e.productEstimateShipping.countryId == "")
            {
              List<CountryStateModel> availableCountries = e.productEstimateShipping.availableCountries.where((element) => element.selected).toList();
              if(availableCountries.isNotEmpty)
              {
                e.productEstimateShipping.countryId = availableCountries[0].value;
              } else {
                e.productEstimateShipping.countryId = e.productEstimateShipping.availableCountries[0].value;
              }
            }

            if(e.productEstimateShipping.stateProvinceId == null || e.productEstimateShipping.stateProvinceId == ''){
              List<CountryStateModel> availableStates = e.productEstimateShipping.availableStates.where((element) => element.selected).toList();
              if(availableStates.isNotEmpty)
              {
                e.productEstimateShipping.stateProvinceId = availableStates[0].value;
              }else{
                e.productEstimateShipping.stateProvinceId = e.productEstimateShipping.availableStates[0].value;
              }

            }

            e.productEstimateShipping.city = e.productEstimateShipping.city == null ? "" : e.productEstimateShipping.city;
            e.productEstimateShipping.zipPostalCode = e.productEstimateShipping.zipPostalCode == null ? "" : e.productEstimateShipping.zipPostalCode;

          }

          if(e.addToCart.allowedQuantities.isNotEmpty)
          {
            for(var i in e.addToCart.allowedQuantities){
              if(e.addToCart.enteredQuantity==null){
                if(i.selected){
                  e.addToCart.enteredQuantity=int.parse(i.value);
                }
              }
            }

            List<AllowedQuantity> checkList=e.addToCart.allowedQuantities.where((element) => int.parse(element.value)==e.addToCart.enteredQuantity).toList();
            if(checkList.isNotEmpty){
              e.addToCart.enteredQuantity=int.parse(checkList[0].value);
            }else{
              e.addToCart.enteredQuantity=int.parse(e.addToCart.allowedQuantities[0].value);
            }

          }

          return Container(
            width: FlexoValues.deviceWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child: FlexoTextWidget().headingBoldText16(text: e.name,),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  height: FlexoValues.deviceWidth * 0.4,
                  width: FlexoValues.deviceWidth * 0.4,
                  child: CachedNetworkImage(
                    imageUrl: e.defaultPictureModel.fullSizeImageUrl,
                  ),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,),

                e.shortDescription == null ||e.shortDescription == '' ? Container() :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                  child: Column(
                    children: [

                      StatefulBuilder(builder: (context, setState){
                        return Container(
                          width: FlexoValues.deviceWidth,
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: HTML.toTextSpan(
                                context,
                                '${e.shortDescription}',
                                defaultTextStyle: TextStyleWidget.contentTextStyle16,
                                linksCallback: (url)
                                {
                                  launch(url!);
                                }
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: FlexoValues.heightSpace2Px),
                    ],
                  ),
                ),

                ProductAvailability().getView(context: context,getProductDetailsModel: e),

                SKUManGTINVen().getView(context: context,getProductDetailsModel: e,isSimple: false),

                DeliveryInfo().getView(context: context,getProductDetailsModel: e),

                DownloadSample().getView(context: context,getProductDetailsModel: e),

                FlexoProductAttribute(getProductDetailsModel: e),

                GiftCardInfo().getView(context: context,giftCard: e.giftCard),

                RentalInfo().getView(context: context,getProductDetailsModel: e),

                ProductPriceWidget().getView(context: context,productPrice: e.productPrice),

                ProductTierPrices().getView(context: context,tierPrices: e.tierPrices),

                Container(
                  child: Column(
                    children: [

                      e.addToCart.customerEntersPrice ?
                      Container(
                        width: FlexoValues.deviceWidth,
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [

                            SizedBox(height: FlexoValues.widthSpace2Px),

                            Container(
                              width: FlexoValues.controlsWidth,
                              alignment: Alignment.centerLeft,
                              child: FlexoTextWidget().headingBoldText15(text: "${localResourceProvider.getResourseByKey("products.enterProductPrice")}: ",),
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px),

                            TextFieldAttributeWidgets(
                              width: FlexoValues.controlsWidth,
                              keyBoardType: TextInputType.number,
                              textFieldType: TextFieldType.Numeric,
                              showRequiredIcon: false,
                              initialValue: e.addToCart.customerEnteredPrice.ceil().toString(),
                              onChange: (String val) {
                                if(val != "")
                                {
                                  setState((){
                                    e.addToCart.customerEnteredPrice = double.parse(val);
                                  });
                                }
                              },
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px),

                            Container(
                              width: FlexoValues.deviceWidth,
                              child: FlexoTextWidget().headingText15(text: e.addToCart.customerEnteredPriceRange,),
                            )
                          ],
                        ),
                      ) : Container(),

                      e.addToCart.minimumQuantityNotification!=null?
                      Column(
                        children: [
                          Container(
                            width: FlexoValues.controlsWidth,
                            child: FlexoTextWidget().contentText15(text: e.addToCart.minimumQuantityNotification,),
                          ),

                          SizedBox(height: FlexoValues.heightSpace1Px,)
                        ],
                      ):Container(),

                      SizedBox(height: FlexoValues.heightSpace2Px,),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            !e.addToCart.disableBuyButton ?
                            StatefulBuilder(
                              builder: (context, setState)
                              {
                                return Container(
                                  width: FlexoValues.deviceWidth * 0.31,
                                  height: FlexoValues.deviceWidth * 0.1,
                                  child: e.addToCart.allowedQuantities.isEmpty?
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                            setState((){
                                              if(e.addToCart.enteredQuantity > 1){
                                                e.addToCart.enteredQuantity--;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: FlexoValues.deviceWidth* 0.1,
                                            height: FlexoValues.deviceWidth * 0.1,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color: Colors.grey
                                                    )
                                                )
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: FlexoValues.iconSize20,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: FlexoValues.deviceWidth* 0.1,
                                          height: FlexoValues.deviceWidth * 0.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color: Colors.grey
                                                  )
                                              )
                                          ),
                                          child: FlexoTextWidget().headingText16(text: e.addToCart.enteredQuantity > 100 ? "99+" : e.addToCart.enteredQuantity.toString(),maxLines: 1)
                                        ),

                                        GestureDetector(
                                          onTap:(){
                                            setState((){
                                              e.addToCart.enteredQuantity++;
                                            });
                                          },
                                          child: Container(
                                            width: FlexoValues.deviceWidth* 0.1,
                                            height: FlexoValues.deviceWidth * 0.1,
                                            child: Icon(
                                              Icons.add,
                                              size: FlexoValues.iconSize20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  FlexoCustomDropDown(
                                      width: FlexoValues.deviceWidth * 0.31,
                                      height: FlexoValues.deviceWidth * 0.1,
                                      showRequiredIcon: false,
                                      selectedValue: e.addToCart.enteredQuantity.toString(),
                                      items: e.addToCart.allowedQuantities.map((e)
                                      {
                                        return DropDownModel(text: e.text, value: e.value.toString());
                                      }).toList(),
                                      onChange: (val)
                                      {
                                        setState(() {
                                          e.addToCart.enteredQuantity = int.parse(val);
                                        });
                                      }
                                  ),

                                );
                              },
                            ):Container(),

                            GestureDetector(
                              onTap: () async
                              {
                                productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Wishlist,getProductDetailsModel: e);
                              },
                              child: Container(
                                width: FlexoValues.deviceWidth * 0.31,
                                height: FlexoValues.deviceWidth * 0.1,
                                color: FlexoColorConstants.BUTTON_BACKGROUND_COLOR,
                                child: Icon(
                                  Ionicons.heart_outline,
                                  color: FlexoColorConstants.THEME_COLOR,
                                  size: FlexoValues.fontSize22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: FlexoValues.heightSpace1Px,),

                      !e.addToCart.disableBuyButton ?
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: GestureDetector(
                          onTap: ()async{
                            KeyboardUtil.hideKeyboard(context);
                            productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Cart,getProductDetailsModel: e);
                          },
                          child: Container(
                            width: FlexoValues.controlsWidth,
                            height: FlexoValues.controlsHeight,
                            alignment: Alignment.center,
                            color: FlexoColorConstants.BUTTON_COLOR,
                            child:Text(
                              e.addToCart.availableForPreOrder? localResourceProvider.getResourseByKey("shoppingCart.preorder").toString().toUpperCase() : e.isRental ? localResourceProvider.getResourseByKey("shoppingCart.rent").toString().toUpperCase()
                                  : productDetailsProvider.isCart ? localResourceProvider.getResourseByKey("products.wishlist.addToWishlist.update").toString().toUpperCase()
                                  : localResourceProvider.getResourseByKey('shoppingCart.addToCart').toString().toUpperCase(),
                              style: TextStyle(
                                  color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                                  fontSize: FlexoValues.fontSize16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ):Container(),

                      e.addToCart.preOrderAvailabilityStartDateTimeUserTime != null?
                      Container(
                        width: FlexoValues.deviceWidth,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: HTML.toTextSpan(
                              context,
                              e.addToCart.preOrderAvailabilityStartDateTimeUserTime,
                              defaultTextStyle: TextStyleWidget.contentTextStyle16,
                              linksCallback: (url)
                              {
                                launch(url!);
                              }
                          ),
                        ),
                      ):Container(),

                      SizedBox(height: FlexoValues.heightSpace2Px,),

                    ],
                  ),
                ),

                productDetailsProvider.productEstimateShippingModelMap[e.id] == null ? Container() :
                ProductEstimateShipping().getView(context: context,getProductDetailsModel: e,estimateShippingMap: productDetailsProvider.estimateShippingMap,productEstimateShippingModel: productDetailsProvider.productEstimateShippingModelMap[e.id]!),


              ],
            )
          );
        }).toList(),
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