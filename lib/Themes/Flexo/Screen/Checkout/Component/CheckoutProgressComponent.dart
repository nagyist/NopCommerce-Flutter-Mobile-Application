/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutBillingAddress.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutConfirmOrder.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutPaymentMethod.dart';
import 'package:nopcommerce/Screens/Checkout/MultiPageCheckout/MultiPageCheckoutShippingMethod.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/MainScreen.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Shapes/Chevron.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Utils/Enum/Edge.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class CheckoutProgressComponent extends StatelessWidget {

  final bool isShoppingCart;
  final bool isAddress;
  final bool isShipping;
  final bool isPayment;
  final bool isConfirm;
  final bool isComplete;
  final bool isShippable;

  CheckoutProgressComponent({required this.isShoppingCart,required this.isAddress,required this.isShipping,required this.isPayment,required this.isConfirm,required this.isComplete, required this.isShippable});

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return StatefulBuilder(builder: (context,setState){
      return Container(
        width: FlexoValues.deviceWidth,
        color: Color(0xfff2f2f2),
        margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
        alignment: Alignment.center,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [

            GestureDetector(
              onTap: ()
              {
                if (isShoppingCart && !isComplete) {
                  Navigator.push(context, PageTransition(type: selectedTransition, child: MainScreen(tabIndex: 2)));
                }
              },
              child: chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.cart"), isSelected: true),
            ),

            GestureDetector(
              onTap: ()
              {
                if(isAddress && !isComplete){
                  Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutBillingAddress()));
                }
              },
              child: chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.address"), isSelected: isAddress),
            ),

            GestureDetector(
              onTap: ()
              {
                if(isShipping && !isComplete && isShippable){
                  Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutShippingMethod()));
                }
              },
              child: chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.shipping"), isSelected: isShipping),
            ),

            GestureDetector(
              onTap: ()
              {
                if(isPayment && !isComplete){
                  Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutPaymentMethod()));
                }
              },
              child: chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.payment"), isSelected: isPayment),
            ),

            GestureDetector(
              onTap: ()
              {
                if(isConfirm && !isComplete){
                  Navigator.push(context, PageTransition(type: selectedTransition, child: MultiPageCheckoutConfirmOrder(body: "{}")));
                }
              },
              child: chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.confirm"), isSelected: isConfirm),
            ),

            chevronShape(title: localResourceProvider.getResourseByKey("checkout.progress.complete"), isSelected: isComplete),
          ],
        ),
      );
    });
  }

  chevronShape({required String title, required isSelected})
  {
    return Container(
      width: FlexoValues.controlsWidth * 0.3,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
      child: Chevron(
        triangleHeight: FlexoValues.widthSpace5Px,
        edge: Edge.RIGHT,
        child: Container(
          color: isSelected ? FlexoColorConstants.CHECKOUT_PROGRESS_SELECTED_COLOR : FlexoColorConstants.CHECKOUT_PROGRESS_UNSELECTED_COLOR,
          width: FlexoValues.controlsWidth * 0.3,
          height: FlexoValues.controlsWidth * 0.1,
          alignment: Alignment.center,
          child: Container(
            width: FlexoValues.controlsWidth * 0.25,
            alignment: Alignment.center,
            child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyleWidget.checkoutProgressTextStyle
            ),
          ),
        ),
      ),
    );
  }
}
