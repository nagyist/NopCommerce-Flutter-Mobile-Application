/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

/// Transition enum
enum PageTransitionType {
  /// theme default
  theme,

  /// Fade Animation
  fade,

  /// Right to left animation
  rightToLeft,

  /// Left to right animation
  leftToRight,

  /// Top to bottom animation
  topToBottom,

  /// Bottom to top animation
  bottomToTop,

  /// Scale animation
  scale,

  /// Rotate animation
  rotate,

  /// Size animation
  size,

  /// Right to left with fading animation
  rightToLeftWithFade,

  /// Left to right with fading animation
  leftToRightWithFade,

  /// Left to right slide as if joined
  leftToRightJoined,

  /// Right to left slide as if joined
  rightToLeftJoined,

  /// Top to bottom as if joined
  topToBottomJoined,

  /// Bottom to top as if joined
  bottomToTopJoined,

  /// Pop the current screen left to right
  leftToRightPop,

  /// Pop the current screen right to left
  rightToLeftPop,

  /// Pop the current screen top to bottom
  topToBottomPop,

  /// Pop the current screen bottom to top
  bottomToTopPop,
}

PageTransitionType selectedTransition = PageTransitionType.rightToLeft;
PageTransitionType popupTransition = PageTransitionType.bottomToTop;