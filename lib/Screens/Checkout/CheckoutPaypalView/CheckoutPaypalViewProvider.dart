/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:nopcommerce/Common/CheckInternet.dart';
import 'package:nopcommerce/Screens/Checkout/Models/GetOrderCompletedResponseModel.dart';
import 'package:nopcommerce/Services/CheckoutService.dart';

class CheckoutPaypalViewProvider extends ChangeNotifier {
  bool isPageLoader = true;
  bool isAPILoader = false;
  final GlobalKey webViewKey = GlobalKey();
  late GetOrderCompletedResponseModel getOrderCompletedResponseModel;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  initMethod({required BuildContext context}) async
  {
    if(await CheckConnectivity().checkInternet(context)){
      completeOrderMethod(context: context);
      pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            webViewController?.reload();
          } else if (Platform.isIOS) {
            webViewController?.loadUrl( urlRequest: URLRequest(url: await webViewController?.getUrl()));
          }
        },
      );
    }
  }

  completeOrderMethod({required BuildContext context})async{
    Response response = await CheckoutService().getOrderCompleteInfo(context: context);
    if(response.statusCode == 200)
    {
      getOrderCompletedResponseModel = getOrderCompletedResponseModelFromJson(response.body);
    }

    isPageLoader = false;
    notifyListeners();
  }
}