/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Colors.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';

class BottomNavigationBadge extends StatelessWidget {
  final bool showBadge;
  final int displayValue;
  BottomNavigationBadge({required this.showBadge, required this.displayValue});

  @override
  Widget build(BuildContext context) {
    final border = CircleBorder(side: BorderSide.none);

    Widget _badgeView() {
      return AnimatedOpacity(
        opacity: showBadge ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: Material(
          shape: border,
          elevation: 2,
          color: FlexoColorConstants.APPBAR_BADGE_BACKGROUND_COLOR,
          child: Padding(
            padding: EdgeInsets.all(FlexoValues.deviceHeight * 0.004),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(displayValue > 9 ? 0 : FlexoValues.deviceHeight * 0.004),
              child: Text(
                displayValue > 9 ? "9+" : "$displayValue",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: FlexoValues.fontSize13,
                  color: FlexoColorConstants.APPBAR_BADGE_TEXT_COLOR,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return _badgeView();
  }
}
