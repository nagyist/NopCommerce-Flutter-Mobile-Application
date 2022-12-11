/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/AssetsPath.dart';
import 'package:nopcommerce/Themes/Flexo/Utils/Values.dart';
import 'package:nopcommerce/Widgets/ResponsiveSize/responsive_sizer.dart';
import '../../../Utils/Colors.dart';

class FlexoSplashScreen extends StatelessWidget {
  const FlexoSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Device.setScreenSize(context, constraints, orientation, 599);
        return Scaffold(
          body: Container(
            height: FlexoValues.deviceHeight,
            width: FlexoValues.deviceWidth,
            color: FlexoColorConstants.BACKGROUND_COLOR,
            child: SingleChildScrollView(
              child: Container(
                height: FlexoValues.deviceHeight,
                width: FlexoValues.deviceWidth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(FlexoAssetsPath.splashScreenBackground),
                      fit: BoxFit.cover,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: FlexoValues.deviceWidth * 0.6,
                      child: Image.asset(FlexoAssetsPath.logo),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}
