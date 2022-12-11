/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

part of responsive_sizer;

/// Type of Device
///
/// This can be android, ios, fuchsia, web, or desktop (windows, mac, linux)
enum DeviceType { android, ios, fuchsia, web, windows, mac, linux }

/// Type of Screen
///
/// This can either be mobile or tablet
enum ScreenType { mobile, tablet }

class Device {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  static late DeviceType deviceType;

  /// Type of Screen
  static late ScreenType screenType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  /// Device's Aspect Ratio
  static late double aspectRatio;

  /// Device's Pixel Ratio
  static late double pixelRatio;

  /// Sets the Screen's size and Device's `Orientation`,
  /// `BoxConstraints`, `Height`, and `Width`
  static void setScreenSize(
      BuildContext context,
      BoxConstraints constraints,
      Orientation currentOrientation,
      double maxMobileWidth,
      ) {
    // Sets boxconstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    // Sets aspect and pixel ratio
    aspectRatio = constraints.constrainDimensions(width, height).aspectRatio;
    pixelRatio = _ambiguate(WidgetsBinding.instance)!.window.devicePixelRatio;

    // Sets DeviceType
    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceType = DeviceType.android;
          break;
        case TargetPlatform.iOS:
          deviceType = DeviceType.ios;
          break;
        case TargetPlatform.windows:
          deviceType = DeviceType.windows;
          break;
        case TargetPlatform.macOS:
          deviceType = DeviceType.mac;
          break;
        case TargetPlatform.linux:
          deviceType = DeviceType.linux;
          break;
        case TargetPlatform.fuchsia:
          deviceType = DeviceType.fuchsia;
          break;
      }
    }

    // Sets ScreenType
    if ((orientation == Orientation.portrait && width <= maxMobileWidth) ||
        (orientation == Orientation.landscape && height <= maxMobileWidth)) {
      screenType = ScreenType.mobile;
    } else {
      screenType = ScreenType.tablet;
    }
  }

  /// This allows a value of type T or T?
  /// to be treated as a value of type T?.
  ///
  /// We use this so that APIs that have become
  /// non-nullable can still be used with `!` and `?`
  /// to support older versions of the API as well.
  static T? _ambiguate<T>(T? value) => value;
}

class Adaptive {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  static double h(num height) => height.h;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's width
  static double w(num width) => width.w;

  /// Calculates the sp (Scalable Pixel) depending on the device's pixel
  /// density and aspect ratio
  static double sp(num scalablePixel) => scalablePixel.sp;

  /// Calculates the material dp (Pixel Density)
  /// (https://material.io/design/layout/pixel-density.html#pixel-density-on-android))
  static double dp(num densityPixel) => densityPixel.dp;

  /// The respective value in centimeters
  static double cm(num centimeters) => centimeters.cm;

  /// The respective value in millimeters
  static double mm(num millimeters) => millimeters.mm;

  /// The respective value in quarter-millimeters
  static double Q(num quarterMillimeters) => quarterMillimeters.Q;

  /// The respective value in inches
  static double inches(num inches) => inches.inches;

  /// The respective value in picas (1/6th of 1 inch)
  static double pc(num picas) => picas.pc;

  /// The respective value in points (1/72th of 1 inch)
  static double pt(num point) => point.pt;

  /// The respective value in pixels (default)
  static double px(num pixels) => pixels.px;
}