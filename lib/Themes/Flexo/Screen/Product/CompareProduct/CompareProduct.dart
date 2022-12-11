/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Products/CompareProduct/CompareProductProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Product/CompareProduct/Component/CompareProductComponent.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';

class FlexoCompareProduct extends StatelessWidget {
  const FlexoCompareProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var compareProductProvider = context.watch<CompareProductProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().appbar(context: context,backButton: true,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("products.compare")),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: compareProductProvider.headerModel,headerLoader: compareProductProvider.isPageLoader),
      body: compareProductProvider.isPageLoader ? Loaders.pageLoader() :  Column(
        children: [
          compareProductProvider.isAPILoader ? Loaders.apiLoader() : Container(),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    compareProductProvider.compareProductsList.isEmpty?

                    Container(
                      padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                      alignment: Alignment.topLeft,
                      child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey("products.compare.noItems"),),
                    ):
                    CompareProductComponent().getCompareProductComponent(context: context),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
