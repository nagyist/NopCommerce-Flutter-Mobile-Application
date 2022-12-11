/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/Customer/ReturnRequestDetail/ReturnRequestDetailProvider.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';

class FlexoReturnRequestMassage extends StatelessWidget {
  const FlexoReturnRequestMassage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var returnRequestDetailProvider = context.watch<ReturnRequestDetailProvider>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: FlexoAppBarWidget().appbar(context: context,backButton: true , title:  localResourceProvider.isLocalDataLoad ? "" :  localResourceProvider.getResourseByKey("returnRequests.title").toString().replaceAll("<a href=\"{0}\">","" ).replaceAll("{1}", returnRequestDetailProvider.getReturnRequestModel.customOrderNumber).replaceAll("</a>", "") ),
          backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
          bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: returnRequestDetailProvider.headerModel,headerLoader: returnRequestDetailProvider.isAPILoader),
          body: returnRequestDetailProvider.isPageLoader ? Loaders.pageLoader() : Column(
            children: [
              returnRequestDetailProvider.isAPILoader ? Loaders.apiLoader() : Container(),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                            width: FlexoValues.deviceWidth,
                            child: SingleChildScrollView(
                                child: Container(
                                    padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                    child: FlexoTextWidget().headingText17(text: localResourceProvider.getResourseByKey(returnRequestDetailProvider.returnRequestModel.result))
                                )
                            )
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
