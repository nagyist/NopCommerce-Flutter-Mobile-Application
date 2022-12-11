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
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetails.dart';
import 'package:nopcommerce/Screens/Customer/OrderConfirmPage/OrderConfirmPage.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Services/CheckoutService.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/Enum/PageTransitionType.dart';
import 'package:nopcommerce/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutPaypalView extends StatefulWidget {
  final String redirectionUrl;
  final int orderId;
  CheckoutPaypalView({required this.redirectionUrl, required this.orderId});

  @override
  State<CheckoutPaypalView> createState() => _CheckoutPaypalViewState();
}

class _CheckoutPaypalViewState extends State<CheckoutPaypalView> {

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
  String pageUrl = "";
  double pageProgress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    initMethod();
  }
  loadData() async
  {
    context.read<LocalResourceProvider>().loadLocalResources();
  }

  initMethod() async
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
      setState(() {
        getOrderCompletedResponseModel = getOrderCompletedResponseModelFromJson(response.body);
        isPageLoader = false;
      });
    }else{
      setState(() {

        isPageLoader = false;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("checkout.progress.payment"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: isPageLoader ? Loaders.pageLoader() :
        InAppWebView(
          key: webViewKey,
          initialUrlRequest:
          URLRequest(url: Uri.parse(widget.redirectionUrl)),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStart: (controller, url) {
            setState(() {
              pageUrl = url.toString();
              urlController.text = pageUrl;
              if(urlController.text=='https://webapi.nopadvance.team/'){

                if(localResourceProvider.getSettingByName("ordersettings.disableordercompletedpage")=='True') {
                  Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderDetails(orderId: widget.orderId)));
                }else{
                  Navigator.pushReplacement(context, PageTransition(type: selectedTransition, child: OrderConfirmPage(orderId: widget.orderId)));
                }
              }
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![ "http", "https", "file", "chrome",
              "data", "javascript", "about"].contains(uri.scheme)) {
              if (await canLaunch(pageUrl)) {
                // Launch the App
                await launch(
                  pageUrl,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            pullToRefreshController.endRefreshing();
            setState(() {
              pageUrl = url.toString();
              urlController.text = pageUrl;
            });
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController.endRefreshing();
            }
            setState(() {
              pageProgress = progress / 100;
              urlController.text = pageUrl;
            });
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              urlController.text = widget.redirectionUrl;
            });
          },
          onConsoleMessage: (controller, consoleMessage) {

          },
        ),
      ),
    );
  }
}
