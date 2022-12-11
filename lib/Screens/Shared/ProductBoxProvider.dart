/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Common/FlushbarMessage.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/Models/CompareProductModel.dart';
import 'package:nopcommerce/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopcommerce/Services/AddToCartWishListService.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/SQFliteDatabase.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';

class ProductBoxProvider extends ChangeNotifier{

  getRating(int ratingSum, totalReviews)
  {
    if(ratingSum==0){
      return 0.0;
    }
    else{
      return ((((ratingSum * 100)/totalReviews)/5)/20);
    }

  }

  addToWishlistOnclickEvent({required BuildContext context,required int productId,required LocalResourceProvider localResourceProvider})async
  {
    if(await CheckConnectivity().checkInternet(context)){
      var body ='{'
        ' "quantity": 1,'
        ' "updateCartItemId": 0,'
        ' "attributes": {}'
        '}';
      Response response = await AddToCartWishListService().addToWishList(context: context,urlParams: "/$productId", body: body);
      if(response.statusCode == 200){
        FlushBarMessage().successMessage(context: context, title: localResourceProvider.getResourseByKey('products.productHasBeenAddedToTheWishlist'));
        return true;
      }else if(response.statusCode == 500){
      }else{
        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: productId,updateId: 0,isCart: false,)));
        return false;
      }
    }

  }

  addToCartOnclickEvent({required BuildContext context,required int productId,required LocalResourceProvider localResourceProvider})async
  {
    if(await CheckConnectivity().checkInternet(context)){

      var body ='{'
          ' "quantity": 1,'
          ' "updateCartItemId": 0,'
          ' "attributes": {}'
          '}';

      Response response = await AddToCartWishListService().addToCart(context:context,urlParams: "/$productId", body: body);
      if(response.statusCode == 200){

        FlushBarMessage().successMessage(context: context, title: localResourceProvider.getResourseByKey('products.ProductHasBeenAddedToTheCart'));

      }else if(response.statusCode == 500){

      }else{
        Navigator.push(context, PageTransition(type: selectedTransition, child: ProductDetails(productId: productId,updateId: 0,isCart: false,))).then((value)
        {
          // getHeaderOnlyData();
          // notifyListeners();
        });
      }

      return true;

    }

  }
  addToCompareOnClickEvent({required BuildContext context,required int productId}){

    SQFLiteDatabase().dbHelper.addCompareProduct(model: CompareProductResourseModel(productId: productId));
    FlushBarMessage().successMessage(context: context, title: LocalResourceProvider().getResourseByKey("products.producthasbeenaddedtocomparelist"));
  }
}