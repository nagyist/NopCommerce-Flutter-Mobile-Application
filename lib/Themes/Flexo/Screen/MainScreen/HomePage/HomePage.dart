/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/Home/HomeProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:provider/provider.dart';
import 'Components/HomePageCategories.dart';
import 'Components/HomePageNivoSlider.dart';
import 'Components/HomePageProducts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: FlexoAppBarWidget().searchableAppbar(context: context,backButton: false),
      backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
      body: RefreshIndicator(
        onRefresh: () async{
          await homeProvider.homePageRefresh(context: context);
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: SingleChildScrollView(
          controller: homeProvider.homeScrollController,
          child: Column(
            children: [

              homeProvider.isHomePageRefresh ? Loaders.apiLoader() : Container(),

              HomePageNivoSlider().getHomePageNivoSlider(context: context),

              SizedBox(height: FlexoValues.verticalPadding,),

              HomePageCategories().getHomePageCategories(context: context),

              homeProvider.getHomepageProductsModel.length > 0 ?
              Container(
                width: FlexoValues.deviceWidth,
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                      child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("homepage.products").toUpperCase(),maxLines: 2),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ) : Container(),

              HomePageProducts().getHomePageProducts(context: context,localResourceProvider: localResourceProvider),

              localResourceProvider.getSettingByName("catalogsettings.showbestsellersonhomepage") == "True" ?
              Column(
                children: [

                  homeProvider.getHomepageBestSellerModel.length > 0 ?
                  Container(
                    width: FlexoValues.deviceWidth,
                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                          child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("bestsellers").toUpperCase(),maxLines: 2),
                        ),

                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ) : Container(),

                  HomePageProducts().getHomePageBestSeller(context: context,localResourceProvider: localResourceProvider),
                ],
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
