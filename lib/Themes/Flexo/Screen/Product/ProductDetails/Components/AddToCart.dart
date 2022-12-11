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

class AddToCartWidget {
  getView({required BuildContext context, required GetProductDetailsModel getProductDetailsModel, required bool isCart})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    return StatefulBuilder(builder: (context, setState)
    {
      return Container(
        child: Column(
          children: [

            getProductDetailsModel.addToCart.customerEntersPrice ?
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

                  SizedBox(height: FlexoValues.widthSpace1Px),

                  TextFieldAttributeWidgets(
                    width: FlexoValues.controlsWidth,
                    showRequiredIcon: false,
                    keyBoardType: TextInputType.number,
                    textFieldType: TextFieldType.Numeric,
                    initialValue: getProductDetailsModel.addToCart.customerEnteredPrice.toString(),
                    onChange: (String val) {
                      if(val != "")
                      {
                        setState((){
                          getProductDetailsModel.addToCart.customerEnteredPrice = double.parse(val);
                        });
                      }
                    },
                  ),

                  SizedBox(height: FlexoValues.heightSpace1Px),

                  Container(
                    width: FlexoValues.deviceWidth,
                    child: FlexoTextWidget().headingText15(text: getProductDetailsModel.addToCart.customerEnteredPriceRange,),
                  )
                ],
              ),
            ) : Container(),

            getProductDetailsModel.addToCart.minimumQuantityNotification!=null?
            Column(
              children: [
                Container(
                  width: FlexoValues.controlsWidth,
                  child: FlexoTextWidget().contentText15(text: getProductDetailsModel.addToCart.minimumQuantityNotification,),
                ),

                SizedBox(height: FlexoValues.heightSpace1Px,)
              ],
            ):Container(),

            SizedBox(height: FlexoValues.heightSpace2Px,),

            !getProductDetailsModel.addToCart.disableBuyButton ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatefulBuilder(
                    builder: (context, setState)
                    {
                      return Container(
                        width: FlexoValues.deviceWidth * 0.31,
                        height: FlexoValues.deviceWidth * 0.1,
                        child: getProductDetailsModel.addToCart.allowedQuantities.isEmpty?
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
                                    if(getProductDetailsModel.addToCart.enteredQuantity > 1){
                                      getProductDetailsModel.addToCart.enteredQuantity--;
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
                                child: FlexoTextWidget().headingText16(text: getProductDetailsModel.addToCart.enteredQuantity > 100 ? "99+" : getProductDetailsModel.addToCart.enteredQuantity.toString(),maxLines: 1)
                              ),

                              GestureDetector(
                                onTap:(){
                                  setState((){
                                    getProductDetailsModel.addToCart.enteredQuantity++;
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
                            selectedValue: getProductDetailsModel.addToCart.enteredQuantity.toString(),
                            items: getProductDetailsModel.addToCart.allowedQuantities.map((e)
                            {
                              return DropDownModel(text: e.text, value: e.value.toString());
                            }).toList(),
                            onChange: (val)
                            {
                              setState(() {
                                getProductDetailsModel.addToCart.enteredQuantity = int.parse(val);
                              });
                            }
                        ),

                      );
                    },
                  ),

                  GestureDetector(
                    onTap: ()async{
                      KeyboardUtil.hideKeyboard(context);
                      productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Cart,getProductDetailsModel: getProductDetailsModel);
                    },
                    child: Container(
                      width: FlexoValues.deviceWidth * 0.63,
                      height: FlexoValues.deviceWidth * 0.1,
                      alignment: Alignment.center,
                      color: FlexoColorConstants.BUTTON_COLOR,
                      child:Text(
                        getProductDetailsModel.addToCart.availableForPreOrder? localResourceProvider.getResourseByKey("shoppingCart.preorder").toString().toUpperCase() : getProductDetailsModel.isRental ? localResourceProvider.getResourseByKey("shoppingCart.rent").toString().toUpperCase()
                            : isCart ? localResourceProvider.getResourseByKey("products.wishlist.addToWishlist.update").toString().toUpperCase()
                            : localResourceProvider.getResourseByKey('shoppingCart.addToCart').toString().toUpperCase(),
                        style: TextStyle(
                            color: FlexoColorConstants.BUTTON_TEXT_COLOR,
                            fontSize: FlexoValues.fontSize16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):Container(),

            getProductDetailsModel.addToCart.preOrderAvailabilityStartDateTimeUserTime != null?
            Container(
              width: FlexoValues.deviceWidth,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
              child: RichText(
                textAlign: TextAlign.left,
                text: HTML.toTextSpan(
                    context,
                    getProductDetailsModel.addToCart.preOrderAvailabilityStartDateTimeUserTime,
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
      );
    });
  }
}