/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nopcommerce/Common/ThemeFont.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutPaypalView/CheckoutPaypalViewProvider.dart';
import 'package:nopcommerce/Screens/Checkout/CheckoutProvider.dart';
import 'package:nopcommerce/Screens/Customer/Address/CreateOrUpdateAddress/CreateOrUpdateAddressProvider.dart';
import 'package:nopcommerce/Screens/Customer/CustomerProductReview/CustomerProductReviewProvider.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestList/ReturnRequestProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/SplashScreen.dart';
import 'package:nopcommerce/Screens/Customer/Avatar/AvatarProvider.dart';
import 'package:nopcommerce/Screens/Customer/ChangePassword/ChangePasswordProvider.dart';
import 'package:nopcommerce/Screens/Customer/Login/LoginProvider.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Screens/Customer/RewardPoint/RewardPointProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Screens/Shared/ProductBoxProvider.dart';
import 'package:provider/provider.dart';
import 'Screens/Catalog/SearchProducts/SearchProductsProvider.dart';
import 'Screens/General/ContactUs/ContactUsProvider.dart';
import 'Screens/General/SearchTermProvider.dart';
import 'Screens/Customer/Address/AddressList/AddressListProvider.dart';
import 'Screens/Customer/BackInStockSubscriptions/BackInStockSubscriptionsProvider.dart';
import 'Screens/Customer/CustomerInfo/CustomerInfoProvider.dart';
import 'Screens/Customer/DownloadableProduct/DownloadableProductProvider.dart';
import 'Screens/Customer/DownloadableProduct/UserAgreement/UserAgreementProvider.dart';
import 'Screens/Customer/GdprTools/GdprToolsProvider.dart';
import 'Screens/Customer/GiftCardBalance/GiftCardBalanceProvider.dart';
import 'Screens/Customer/Order/OrderList/OrderListProvider.dart';
import 'Screens/Customer/Order/OrderShipmate/OrderShipmateDetailProvider.dart';
import 'Screens/Customer/OrderConfirmPage/OrderConfirmPageProvider.dart';
import 'Screens/Customer/Register/RegisterProvider.dart';
import 'Screens/Customer/ReturnRequestDetail/ReturnRequestDetailProvider.dart';
import 'Screens/General/TopicBlockDetails/TopicBlockDetailsProvider.dart';
import 'Screens/Home/CartEstimateShipping/CartEstimateShippingProvider.dart';
import 'Screens/Products/CompareProduct/CompareProductProvider.dart';
import 'Screens/Products/EmailProduct/EmailProductProvider.dart';
import 'Screens/Products/NewProducts/NewProductsProvider.dart';
import 'Screens/Products/ProductByPopularTag/ProductByPopularTagProvider.dart';
import 'Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'Screens/Products/ProductEstimateShipping/ProductEstimateShippingProvider.dart';
import 'Screens/Products/ProductReview/ProductReviewProvider.dart';
import 'Screens/Products/ProductTag/ProductTagProvider.dart';
import 'Screens/Wishlist/EmailWishlist/EmailWishlistProvider.dart';
import 'Screens/Wishlist/Wishlist/WishlistProvider.dart';
import 'Screens/Shared/AppBarProvider.dart';
import 'Screens/Shared/BottomNavigationProvider.dart';
import 'Screens/Shared/ProductBoxProvider.dart';
import 'Screens/General/AppSettings/AppSettingsProvider.dart';
import 'Screens/Customer/ForgotPassword/ForgotPasswordProvider.dart';


void main() async {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppSettingsProvider>(create: (_) => AppSettingsProvider()),
          ChangeNotifierProvider<LocalResourceProvider>(create: (_) => LocalResourceProvider()),
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider<ForgotPasswordProvider>(create: (_) => ForgotPasswordProvider()),
          ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
          ChangeNotifierProvider<ProductBoxProvider>(create: (_) => ProductBoxProvider()),
          ChangeNotifierProvider<RegisterProvider>(create: (_) => RegisterProvider()),
          ChangeNotifierProvider<OrderListProvider>(create: (_) => OrderListProvider()),
          ChangeNotifierProvider<OrderDetailsProvider>(create: (_) => OrderDetailsProvider()),
          ChangeNotifierProvider<ChangePasswordProvider>(create: (_) => ChangePasswordProvider()),
          ChangeNotifierProvider<GdprToolsProvider>(create: (_) => GdprToolsProvider()),
          ChangeNotifierProvider<RewardPointProvider>(create: (_) => RewardPointProvider()),
          ChangeNotifierProvider<BackInStockSubscriptionsProvider>(create: (_) => BackInStockSubscriptionsProvider()),
          ChangeNotifierProvider<GiftCardBalanceProvider>(create: (_) => GiftCardBalanceProvider()),
          ChangeNotifierProvider<AvatarProvider>(create: (_) => AvatarProvider()),
          ChangeNotifierProvider<ProductDetailsProvider>(create: (_) => ProductDetailsProvider()),
          ChangeNotifierProvider<CustomerInfoProvider>(create: (_) => CustomerInfoProvider()),
          ChangeNotifierProvider<AddressListProvider>(create: (_) => AddressListProvider()),
          ChangeNotifierProvider<ProductReviewProvider>(create: (_) => ProductReviewProvider()),
          ChangeNotifierProvider<SearchTermProvider>(create: (_) => SearchTermProvider()),
          ChangeNotifierProvider<ProductEstimateShippingProvider>(create: (_) => ProductEstimateShippingProvider()),
          ChangeNotifierProvider<DownloadableProductProvider>(create: (_) => DownloadableProductProvider()),
          ChangeNotifierProvider<UserAgreementProvider>(create: (_) => UserAgreementProvider()),
          ChangeNotifierProvider<AppBarProvider>(create: (_) => AppBarProvider()),
          ChangeNotifierProvider<EmailProductProvider>(create: (_) => EmailProductProvider()),
          ChangeNotifierProvider<BottomNavigationProvider>(create: (_) => BottomNavigationProvider()),
          ChangeNotifierProvider<CompareProductProvider>(create: (_) => CompareProductProvider()),
          ChangeNotifierProvider<CartEstimateShippingProvider>(create: (_) => CartEstimateShippingProvider()),
          ChangeNotifierProvider<CheckoutProvider>(create: (_) => CheckoutProvider()),
          ChangeNotifierProvider<OrderShipmateDetailProvider>(create: (_) => OrderShipmateDetailProvider()),
          ChangeNotifierProvider<ReturnRequestDetailProvider>(create: (_) => ReturnRequestDetailProvider()),
          ChangeNotifierProvider<ReturnRequestProvider>(create: (_) => ReturnRequestProvider()),
          ChangeNotifierProvider<OrderConfirmPageProvider>(create: (_) => OrderConfirmPageProvider()),
          ChangeNotifierProvider<CheckoutPaypalViewProvider>(create: (_) => CheckoutPaypalViewProvider()),
          ChangeNotifierProvider<TopicBlockDetailsProvider>(create: (_) => TopicBlockDetailsProvider()),
          ChangeNotifierProvider<SearchProductsProvider>(create: (_) => SearchProductsProvider()),
          ChangeNotifierProvider<WishlistProvider>(create: (_) => WishlistProvider()),
          ChangeNotifierProvider<EmailWishlistProvider>(create: (_) => EmailWishlistProvider()),
          ChangeNotifierProvider<ProductByPopularTagProvider>(create: (_) => ProductByPopularTagProvider()),
          ChangeNotifierProvider<ProductTagProvider>(create: (_) => ProductTagProvider()),
          ChangeNotifierProvider<NewProductsProvider>(create: (_) => NewProductsProvider()),
          ChangeNotifierProvider<ContactUsProvider>(create: (_) => ContactUsProvider()),
          ChangeNotifierProvider<CustomerProductReviewProvider>(create: (_) => CustomerProductReviewProvider()),
          ChangeNotifierProvider<CreateOrUpdateAddressProvider>(create: (_) => CreateOrUpdateAddressProvider()),
        ],
        child: const MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white)
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeFont(),
      scrollBehavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      home: SplashScreen(),
    );
  }
}

