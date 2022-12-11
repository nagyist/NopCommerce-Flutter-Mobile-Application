/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/Order/OrderDetails/OrderDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class OrderPrintView extends StatefulWidget {
  var base64;
  String printName="";
  String orderNo="";
  OrderPrintView({required this.base64,required this.printName,required this.orderNo});

  @override
  _OrderPrintViewState createState() => _OrderPrintViewState();
}

class _OrderPrintViewState extends State<OrderPrintView> {
  var bytesArray;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bytesArray = base64Decode(widget.base64.replaceAll('\n', ''));
  }
  @override
  Widget build(BuildContext context) {
    var orderDetailsProvider = context.watch<OrderDetailsProvider>();
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor:FlexoColorConstants.BACKGROUND_COLOR,
          appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  widget.orderNo),
          body: orderDetailsProvider.isAPILoader ?
          Loaders.apiLoader() :
          PdfPreview(
            build: (format) => bytesArray,
            pdfFileName: widget.printName,
          ),
        )
    );
  }
}
