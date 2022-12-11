/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Dropdown/FlexoCustomDropDown.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/DropdownWidget/DropdownModel.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class ShoppingCartProductListComponent{

  getShoppingCartProductListComponent({required BuildContext context}){

    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return StatefulBuilder(builder: (context,setState)
    {
      return Container(
        child: Column(
          children: [

            homeProvider.getCartModel.warnings.length > 0 ?
            Container(
              width: FlexoValues.deviceWidth,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: homeProvider.getCartModel.warnings.map((w){
                      return Container(
                        width: FlexoValues.controlsWidth,
                        child: FlexoTextWidget().warningMessageText(text: w)
                      );
                    }).toList(),
                  ),

                  Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,)
                ],
              ),
            ) : Container(),

            Container(
              width: FlexoValues.deviceWidth,
              child: Column(
                children: homeProvider.getCartModel.items.map((e){
                  if(homeProvider.isCartItemDeleteMap[e.id]==null){
                    homeProvider.isCartItemDeleteMap[e.id]=false;
                  }
                  List<DropDownModel> dropDownQtyList = [];
                  for(var item in e.allowedQuantities)
                  {
                    setState(()
                    {
                      dropDownQtyList.add(new DropDownModel(text: item.text, value: item.text));
                    });
                  }
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: FlexoColorConstants.PRODUCT_BORDER_COLOR
                            )
                        )
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                homeProvider.getCartModel.showProductImages ?
                                GestureDetector(
                                  onTap: (){
                                      Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                      {
                                        homeProvider.getCartData(context: context);
                                        homeProvider.getHeaderData(context: context);
                                      });
                                  },
                                  child: Container(
                                    width: FlexoValues.deviceWidth * 0.4,
                                    height: FlexoValues.deviceWidth * 0.4,
                                    padding: EdgeInsets.fromLTRB(FlexoValues.widthSpace1Px, FlexoValues.widthSpace1Px, 0, FlexoValues.widthSpace1Px),
                                    child: CachedNetworkImage(
                                      imageUrl: e.picture.imageUrl,
                                    ),
                                  ),
                                ) : Container(),

                                Container(
                                  width:homeProvider.getCartModel.showProductImages ? FlexoValues.deviceWidth * 0.6 : FlexoValues.deviceWidth,
                                  padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px,),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                        padding:EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState(()
                                                  {
                                                    Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: 0, isCart: false))).then((value)
                                                    {
                                                      setState(()
                                                      {
                                                        homeProvider.getCartData(context: context);
                                                        homeProvider.getHeaderData(context: context);
                                                      });
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  child: FlexoTextWidget().productBoxHorizontalText(text: e.productName,maxLines: 3),
                                                  width: FlexoValues.deviceWidth * 0.5,
                                                ),
                                              ),
                                            ),
                                            homeProvider.getCartModel.isEditable ?
                                            e.disableRemoval ? Container() :
                                            GestureDetector(
                                              onTap:()async {
                                                homeProvider.removeCartItemClickEvent(context: context,id: e.id);
                                              },
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                child: Icon(
                                                  Icons.clear,
                                                  size:FlexoValues.fontSize20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ) : Container(),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      homeProvider.getCartModel.showSku && e.sku == null ? Container () :
                                      Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                              child: FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("ShoppingCart.sku")+": ", subTextList: [e.sku]),
                                            ),

                                          SizedBox(height: FlexoValues.heightSpace1Px,),
                                        ],
                                      ),

                                      homeProvider.getCartModel.showVendorName && e.vendorName != null ?
                                      Container(
                                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                          child:Column(
                                            children: [
                                              FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("ShoppingCart.VendorName")+": ", subTextList: [e.vendorName]),
                                              SizedBox(height: FlexoValues.heightSpace1Px,),
                                            ],
                                          )
                                      ) : Container(),

                                      e.attributeInfo == "" || e.attributeInfo == null ? Container() :
                                      Container(
                                          child: Column(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                child: HtmlWidget(
                                                  '${e.attributeInfo}',
                                                  textStyle: TextStyleWidget.contentTextStyle16,
                                                  onTapUrl: (url)=> launch(url),
                                                ),
                                              ),

                                              SizedBox(height: FlexoValues.heightSpace1Px,),
                                            ],
                                          )
                                      ),

                                      e.recurringInfo == "" || e.recurringInfo == null ? Container() :
                                      Container(
                                          child: Column(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                child: HtmlWidget(
                                                  '${e.recurringInfo}',
                                                  textStyle: TextStyleWidget.contentTextStyle16,
                                                  customStylesBuilder: (element) {
                                                    if (element.localName == 'a') {
                                                      return {'color': "#"+ FlexoColorConstants.HIGHLIGHT_COLOR.value.toRadixString(16).substring(2, 8)};
                                                    }
                                                    return null;
                                                  },
                                                  onTapUrl: (url)=> launch(url),
                                                ),
                                              ),

                                              SizedBox(height: FlexoValues.heightSpace1Px,),
                                            ],
                                          )
                                      ),

                                      e.rentalInfo == "" || e.rentalInfo == null ? Container() :
                                      Container(
                                          child: Column(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                child: HtmlWidget(
                                                  '${e.rentalInfo}',
                                                  textStyle: TextStyleWidget.contentTextStyle16,
                                                  onTapUrl: (url)=> launch(url),
                                                ),
                                              ),

                                              SizedBox(height: FlexoValues.heightSpace1Px,),
                                            ],
                                          )
                                      ),

                                      Container(
                                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                          child:FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("shoppingCart.UnitPrice")+": ", subTextList: [e.unitPrice]),
                                      ),

                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      Container(
                                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                          child: FlexoTextWidget().richTextContentText16(text: localResourceProvider.getResourseByKey("shoppingCart.itemTotal")+": ", subTextList: [e.subTotal]),
                                      ),

                                      e.discount != null ?
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(height: FlexoValues.widthSpace1Px,),

                                            Container(
                                              child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("shoppingCart.itemYouSave").toString().replaceAll("{0}", e.discount),maxLines: 2),
                                            ),

                                            e.maximumDiscountedQty != null ?
                                            Container(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: FlexoValues.widthSpace1Px,),
                                                  Container(
                                                    child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("shoppingCart.maximumDiscountedQty").toString().replaceAll("{0}", e.maximumDiscountedQty.toString()),maxLines: 2),
                                                  ),
                                                ],
                                              ),
                                            ) :  Container()
                                          ],
                                        ),
                                      ) : Container(),

                                      SizedBox(height: FlexoValues.heightSpace1Px,),

                                      Container(
                                        width: homeProvider.getCartModel.showProductImages ? FlexoValues.deviceWidth * 0.6 : FlexoValues.deviceWidth,
                                        margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            homeProvider.getCartModel.isEditable ?
                                            e.allowedQuantities.length > 0 ?

                                            FlexoCustomDropDown(
                                                width: FlexoValues.deviceWidth * 0.25,
                                                height: FlexoValues.deviceWidth * 0.08,
                                                selectedValue: e.quantity.toString(),
                                                showRequiredIcon: false,
                                                items: dropDownQtyList,
                                                onChange: (value)
                                                {
                                                  setState(()
                                                  {
                                                    e.quantity = int.parse(value);
                                                    homeProvider.updateCartClickEvent(context: context);

                                                  });
                                                }):

                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: FlexoColorConstants.LIST_BORDER_COLOR)
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: (){
                                                            setState(() {
                                                              if(e.quantity>1){
                                                                e.quantity=e.quantity-1;
                                                                homeProvider.updateCartClickEvent(context: context);
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                              height: FlexoValues.deviceWidth * 0.08,
                                                              width: FlexoValues.deviceWidth * 0.08,
                                                              decoration: BoxDecoration(
                                                                border: Border(
                                                                  right:BorderSide(
                                                                    color: FlexoColorConstants.LIST_BORDER_COLOR,
                                                                  ),
                                                                ),
                                                              ),
                                                              child:Center(
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    size: FlexoValues.fontSize20,
                                                                  )
                                                              )
                                                          ),
                                                        ),

                                                        Container(
                                                          height: FlexoValues.deviceWidth * 0.08,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                              right:BorderSide(
                                                                color:  FlexoColorConstants.LIST_BORDER_COLOR,
                                                              ),
                                                            ),
                                                          ),
                                                          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                          child: FlexoTextWidget().contentText16(text: "${e.quantity}",),
                                                        ),

                                                        GestureDetector(
                                                          onTap: (){
                                                            setState(() {
                                                              e.quantity=e.quantity+1;
                                                              homeProvider.updateCartClickEvent(context: context);
                                                            });
                                                          },
                                                          child: Container(
                                                              height: FlexoValues.deviceWidth * 0.08,
                                                              width: FlexoValues.deviceWidth * 0.08,
                                                              child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: FlexoValues.fontSize20,
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ):
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("shoppingCart.quantity") +" : ${e.quantity}",maxLines: 2),
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace1Px,),
                                          ],
                                        ),
                                      ),

                                      e.allowItemEditing && homeProvider.getCartModel.isEditable?
                                      Container(
                                        child: Column(
                                          children: [

                                            SizedBox(height: FlexoValues.heightSpace1Px,),

                                            GestureDetector(
                                              onTap: () async{
                                                Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: e.productId, updateId: e.id, isCart: true))).then((value)
                                                {
                                                  homeProvider.getCartData(context: context);
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                child: FlexoTextWidget().redirectText16(text: localResourceProvider.getResourseByKey("common.edit"),maxLines: 2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ): Container()
                                    ],
                                  ),
                                ),
                              ]
                          ),

                          e.warnings.length > 0 ?
                          Container(
                            width: FlexoValues.controlsWidth,
                            padding: EdgeInsets.symmetric(vertical: FlexoValues.heightSpace1Px),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: e.warnings.map((w){
                                return Container(
                                  width: FlexoValues.controlsWidth,
                                  child: FlexoTextWidget().warningMessageText(text: w,maxLines: 2),
                                );
                              }).toList(),
                            ),
                          ) : Container()
                        ],
                      ),
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