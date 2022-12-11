/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nopcommerce/Models/GetTopicBlockModel.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextStyleWidget.dart';
import 'package:nopcommerce/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicBlockComponent extends StatelessWidget {
  GetTopicBlockModel getTopicBlockModel;
  TopicBlockComponent({required this.getTopicBlockModel});

  @override
  Widget build(BuildContext context) {
    return getTopicBlockModel == null ? Container() : Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: FlexoValues.widthSpace2Px),

            getTopicBlockModel.title == '' || getTopicBlockModel.title == null || getTopicBlockModel.title == "null" ? Container() :
            Column(
              children: [
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                  alignment: Alignment.center,
                  child: FlexoTextWidget().headingBoldText17(text: getTopicBlockModel.title,maxLines: 5),
                ),

                Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),
              ],
            ),

            getTopicBlockModel.body == '' || getTopicBlockModel.body == null || getTopicBlockModel.body == "null" ? Container() :
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px,vertical: FlexoValues.widthSpace2Px),
                  child: HtmlWidget(
                    '${getTopicBlockModel.body}',
                    textStyle: TextStyleWidget.contentTextStyle16,
                    onTapUrl: (url)=> launch(url),
                  ),
                ),

                Divider(color: FlexoColorConstants.LIST_BORDER_COLOR,thickness: 1,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
