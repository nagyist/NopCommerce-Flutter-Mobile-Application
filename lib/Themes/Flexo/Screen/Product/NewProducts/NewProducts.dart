/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/NewProducts/NewProductsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/ProductBox/ProductBox.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';

class FlexoNewProducts extends StatelessWidget {
  const FlexoNewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var newProductsProvider = context.watch<NewProductsProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("pageTitle.newProducts"), backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: newProductsProvider.headerModel,headerLoader: newProductsProvider.isPageLoader),
        body: newProductsProvider.isPageLoader || localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :
        Column(
          children: [

            newProductsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        width: FlexoValues.deviceWidth,
                        padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: newProductsProvider.newProductList.map((e) {
                            return Container(
                              child: ProductBox().getProductBox(context: context,productBoxModel: e,localResourceProvider: localResourceProvider,updateHeaderData: newProductsProvider.getHeaderData),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
