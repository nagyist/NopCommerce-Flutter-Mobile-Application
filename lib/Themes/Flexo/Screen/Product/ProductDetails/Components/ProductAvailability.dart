/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/Model/GetProductDetailsModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ProductAvailability{

  backInSubscriptionOnclickEvent({required BuildContext context})async
  {

    var localResourceProvider = context.watch<LocalResourceProvider>();
    var productDetailsProvider = context.watch<ProductDetailsProvider>();

    await productDetailsProvider.backInStockClickEvent(context: context);

    showDialog(
        context: context,
        builder:(ctx) {
          return SimpleDialog(
            children:  [
              Container(
                padding: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace1Px,horizontal: FlexoValues.widthSpace2Px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("backInStockSubscriptions.notifyMeWhenAvailable"),),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        child: Icon(
                          Icons.clear,
                          size: FlexoValues.fontSize20,
                          color: FlexoColorConstants.THEME_COLOR,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Divider(thickness: 1,color: FlexoColorConstants.BORDER_COLOR,),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  productDetailsProvider.getSubscribesModel.alreadySubscribed?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().headingText17(text: localResourceProvider.getResourseByKey("backInStockSubscriptions.alreadySubscribed"),),
                  ):
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().headingText17(text: localResourceProvider.getResourseByKey("backInStockSubscriptions.popupTitle"),),
                  ),

                  productDetailsProvider.getSubscribesModel.subscriptionAllowed?Container() :
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().headingText16(text: localResourceProvider.getResourseByKey("BackInStockSubscriptions.NotAllowed"),),
                  ),

                  productDetailsProvider.getSubscribesModel.isCurrentCustomerRegistered?Container():
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().contentText15(text: localResourceProvider.getResourseByKey("BackInStockSubscriptions.onlyRegistered"),),
                  ),

                  !productDetailsProvider.getSubscribesModel.alreadySubscribed && productDetailsProvider.getSubscribesModel.maximumBackInStockSubscriptions==productDetailsProvider.getSubscribesModel.currentNumberOfBackInStockSubscriptions ?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().contentText17(text: productDetailsProvider.max,),
                  ):Container(),

                  SizedBox(
                    height: FlexoValues.widthSpace2Px,
                  ),

                  !productDetailsProvider.getSubscribesModel.alreadySubscribed?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("backInStockSubscriptions.tooltip"),),
                  ):Container(),

                  SizedBox(
                    height: FlexoValues.widthSpace2Px,
                  ),

                  GestureDetector(
                    onTap:()async{
                      Navigator.pop(ctx);
                      productDetailsProvider.backInStockSubscribe(context: context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(FlexoValues.widthSpace3Px),
                      color: FlexoColorConstants.THEME_COLOR,
                      child: Text(
                        productDetailsProvider.getSubscribesModel.alreadySubscribed? localResourceProvider.getResourseByKey("backInStockSubscriptions.unsubscribe"):
                        localResourceProvider.getResourseByKey("backInStockSubscriptions.notifyMe"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  getView({required BuildContext context,required GetProductDetailsModel getProductDetailsModel})
  {
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return Column(
      children: [
        getProductDetailsModel.stockAvailability.isNotEmpty?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          child: Row(
            children: [
              Container(
                child: FlexoTextWidget().headingBoldText15(text: '${localResourceProvider.getResourseByKey("products.availability")}: ',),
              ),
              Flexible(
                child: Container(
                  child: FlexoTextWidget().contentText15(text: getProductDetailsModel.stockAvailability,),
                ),
              ),
            ],
          ),
        ):Container(),

        SizedBox(height: FlexoValues.widthSpace2Px),

        getProductDetailsModel.displayBackInStockSubscription?
        Container(
          padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
          width: FlexoValues.deviceWidth,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:()async{
                  if(await CheckConnectivity().checkInternet(context)){
                    backInSubscriptionOnclickEvent(context: context);
                  }
                },
                child: Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Icon(
                          Icons.mail_outline,
                          size: FlexoValues.iconSize20,
                          color: FlexoColorConstants.THEME_COLOR,
                        ),
                      ),

                      SizedBox(width: FlexoValues.widthSpace2Px),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: FlexoTextWidget().headingText15(text: localResourceProvider.getResourseByKey("backInStockSubscriptions.notifyMeWhenAvailable"),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: FlexoValues.widthSpace2Px),
            ],
          ),
        ):
        Container(),
      ],
    );
  }
}