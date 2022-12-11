/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Screens/General/LocalResourceProvider.dart';
import 'package:nopcommerce/Screens/General/TopicBlockDetails/TopicBlockDetailsProvider.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopcommerce/Themes/Flexo/Screen/Shared/BottomNavigation/BottomNavigationWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopcommerce/Utils/Enum/BottomNavigationIndexType.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';

class FlexoTopicBlockDetails extends StatelessWidget {
  const FlexoTopicBlockDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var topicBlockDetailsProvider = context.watch<TopicBlockDetailsProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbar(context: context,title: topicBlockDetailsProvider.isPageLoader ? "" : topicBlockDetailsProvider.topicTitle, backButton: true),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        bottomNavigationBar: FlexoBottomNavigationWidget().bottomNavigation(context: context, tabIndexType: BottomNavigationIndexType.Other,headerData: topicBlockDetailsProvider.headerModel,headerLoader: topicBlockDetailsProvider.isPageLoader),
        body: topicBlockDetailsProvider.isPageLoader ? Loaders.pageLoader() :
        Column(
          children: [
            topicBlockDetailsProvider.isAPILoader ? Loaders.apiLoader() : Container(),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: StatefulBuilder(
                    builder: (context, setState)
                    {
                      return Column(
                        children: [

                          SizedBox(height: FlexoValues.widthSpace2Px),

                          topicBlockDetailsProvider.topicTitle !=null ? Container(
                            width: FlexoValues.controlsWidth,
                            margin: EdgeInsets.symmetric(vertical: FlexoValues.widthSpace2Px),
                            alignment: Alignment.topLeft,
                            child: FlexoTextWidget().headingBoldText17(text: topicBlockDetailsProvider.topicTitle,maxLines: 3),
                          ):Container(),

                          Divider(color: Colors.grey),

                          SizedBox(height: FlexoValues.widthSpace2Px),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: HTML.toTextSpan(
                                context,
                                topicBlockDetailsProvider.topicBody,
                                defaultTextStyle: TextStyle(
                                  color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                  fontSize: FlexoValues.fontSize16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
