/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/widgets.dart';
import 'package:nopcommerce/Utils/Enum/Edge.dart';

class ChevronClipper extends CustomClipper<Path> {
  ChevronClipper(this.triangleHeight, this.edge);

  ///The height of triangle
  final double triangleHeight;

  ///The edge the chevron points
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.TOP:
        return _getTopPath(size);
      case Edge.RIGHT:
        return _getRightPath(size);
      case Edge.BOTTOM:
        return _getBottomPath(size);
      case Edge.LEFT:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.moveTo(0.0, triangleHeight);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - triangleHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, triangleHeight);
    path.lineTo(size.width / 2, 0.0);
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.lineTo(triangleHeight, size.height / 2);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width - triangleHeight, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - triangleHeight, 0.0);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.lineTo(size.width / 2, triangleHeight);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height - triangleHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0.0, size.height - triangleHeight);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(triangleHeight, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - triangleHeight, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.lineTo(triangleHeight, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    ChevronClipper oldie = oldClipper as ChevronClipper;
    return triangleHeight != oldie.triangleHeight || edge != oldie.edge;
  }
}