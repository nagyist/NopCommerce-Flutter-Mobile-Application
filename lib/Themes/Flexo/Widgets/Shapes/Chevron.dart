/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/widgets.dart';
import 'package:nopcommerce/Utils/Enum/Edge.dart';
import 'chevron_clipper.dart';
import 'clip_shadow.dart';

class Chevron extends StatelessWidget {
  const Chevron(
      {Key? key,
        required this.triangleHeight,
        required this.child,
        this.edge = Edge.RIGHT,
        this.clipShadows = const []})
      : super(key: key);

  ///The widget that is going to be clipped as chevron shape
  final Widget child;

  ///The height of triangle
  final double triangleHeight;

  ///The edge the chevron points
  final Edge edge;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  @override
  Widget build(BuildContext context) {
    var clipper = ChevronClipper(triangleHeight, edge);
    return CustomPaint(
      painter: ClipShadowPainter(clipper, clipShadows),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}