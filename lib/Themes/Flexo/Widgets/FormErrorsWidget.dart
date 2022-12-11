/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nopcommerce/Common/HtmlAttribute.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

import 'TextStyleWidget.dart';


class FormErrorWidget extends StatelessWidget {
  const FormErrorWidget({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!,context: context)),
    );
  }

  Row formErrorText({required String error, required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.multiply_circle,
          size: FlexoValues.iconSize16,
          color: FlexoColorConstants.ERROR_TEXT_COLOR
        ),
        SizedBox(
          width: FlexoValues.verticalSpace,
        ),

        Expanded(
          child: HtmlWidget(
            '$error',
            textStyle: TextStyle(
                fontSize: FlexoValues.fontSize14,
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),
            onTapUrl: (url)=> launch(url),
          ),
        ),
      ],
    );
  }
}

