/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/widgets.dart';

class BadgePositioned extends StatelessWidget {
  /// This specify a badge position according to [child]
  final BadgePosition? position;

  /// It is a child that will be displayed according to [position]
  final Widget child;

  /// This creates a new instance of [BadgePositioned].
  ///
  /// See also:
  /// * [PositionedDirectional]
  const BadgePositioned({Key? key, this.position, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = this.position;
    if (position == null) {
      final topRight = BadgePosition();
      return PositionedDirectional(
        top: topRight.top,
        end: topRight.end,
        child: child,
      );
    }

    if (position.isCenter) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: child,
        ),
      );
    }

    return PositionedDirectional(
      top: position.top,
      end: position.end,
      bottom: position.bottom,
      start: position.start,
      child: child,
    );
  }
}

class BadgePosition {
  /// This is the distance to the top side of a parent widget.
  final double? top;

  /// This is the distance to the end side of a parent widget.
  final double? end;

  /// This is the distance to the start side of a parent widget.
  final double? start;

  /// This is the distance to the bottom side of a parent widget.
  final double? bottom;

  /// This is indicate that centralise is required
  final bool isCenter;

  /// This creates a new instance of this widget
  const BadgePosition({
    this.top,
    this.end,
    this.bottom,
    this.start,
    this.isCenter = false,
  });

  /// Factory method that creates a new instance of this widget
  /// according to the center
  factory BadgePosition.center() {
    return BadgePosition(isCenter: true);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [start]
  factory BadgePosition.topStart({double top = -5, double start = -10}) {
    return BadgePosition(top: top, start: start);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [end]
  factory BadgePosition.topEnd({double top = -8, double end = -10}) {
    return BadgePosition(top: top, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [end]
  factory BadgePosition.bottomEnd({double bottom = -8, double end = -10}) {
    return BadgePosition(bottom: bottom, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [start]
  factory BadgePosition.bottomStart({double bottom = -8, double start = -10}) {
    return BadgePosition(bottom: bottom, start: start);
  }
}