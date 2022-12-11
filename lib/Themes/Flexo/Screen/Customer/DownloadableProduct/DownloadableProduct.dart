/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/DownloadableProduct/DownloadableProductProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';
import 'Component/DownloadableProductComponent.dart';

class FlexoDownloadableProduct extends StatelessWidget {
  const FlexoDownloadableProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var downloadableProductProvider = context.watch<DownloadableProductProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("account.myAccount")+" - "+localResourceProvider.getResourseByKey("account.downloadableProducts") ),
            backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
            bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: downloadableProductProvider.headerModel,headerLoader:downloadableProductProvider.isAPILoader),
            body: downloadableProductProvider.isPageLoader || localResourceProvider.isLocalDataLoad ? Loaders.pageLoader() :
            downloadableProductProvider.getDownloadableProductModel.items.length==0 ?
            Container(
              child: Padding(
                padding:  EdgeInsets.all(FlexoValues.widthSpace2Px,),
                child: Container(child: Text(
                  localResourceProvider.getResourseByKey("downloadableProducts.noItems"),
                  style: TextStyle(
                    fontSize: FlexoValues.fontSize17,
                    color:FlexoColorConstants.LIGHT_TEXT_COLOR,
                  ),
                )
                ),
              ),
            ):
            Column(
              children: [
                downloadableProductProvider.isAPILoader ? Loaders.apiLoader() : Container(),
                Container(
                  padding: EdgeInsets.only(left:  FlexoValues.widthSpace2Px,right:  FlexoValues.widthSpace2Px,top:  FlexoValues.widthSpace2Px),
                  child: Column(
                    children: [

                      Container(
                        width:  FlexoValues.deviceWidth * 0.95,
                        child:  Row(
                            children: [
                              Container(
                                width:  FlexoValues.deviceWidth * 0.1,
                                height:  FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    right: BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    top:   BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    bottom:  BorderSide(
                                        color:  FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.35,
                                height:FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    top:   BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    bottom:  BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localResourceProvider.getResourseByKey("downloadableProducts.fields.order"),
                                  style: TextStyle(
                                      fontSize: FlexoValues.fontSize16,
                                      color:  FlexoColorConstants.LIGHT_TEXT_COLOR,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              Container(
                                width: FlexoValues.deviceWidth * 0.5,
                                height: FlexoValues.deviceHeight * 0.06,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    top:   BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                    bottom:  BorderSide(
                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal:FlexoValues.widthSpace2Px),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localResourceProvider.getResourseByKey("downloadableProducts.fields.product"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize:FlexoValues.fontSize16,
                                      color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          DigitalDownloadComponent().getDigitalDownloadComponent(context:context),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




