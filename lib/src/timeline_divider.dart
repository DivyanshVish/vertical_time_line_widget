import 'package:flutter/material.dart';
import 'package:vertical_timeline_widget/src/tile.dart';


/// A customizable divider widget designed for use with timeline layouts.
///
/// [TimelineDivider] creates a line that can be rendered horizontally or
/// vertically, with precise control over where the line begins and ends
/// within the available space. This is particularly useful for creating
/// connecting lines between timeline tiles.
///
/// The [begin] and [end] parameters use percentage values (0.0 to 1.0)
/// to define the start and end positions of the divider relative to
/// the available width (horizontal) or height (vertical).
///
/// Example usage:
/// ```dart
/// // Horizontal divider connecting two tiles at 10% and 90%
/// TimelineDivider(
///   begin: 0.1,
///   end: 0.9,
///   thickness: 6,
///   color: Colors.purple,
/// )
/// ```
///
/// This widget is often used in conjunction with [TimelineTile] to create
/// visual connections between timeline entries with different alignments.
class TimelineDivider extends StatelessWidget {
  /// Creates a [TimelineDivider] widget.
  ///
  /// Parameters:
  /// - [axis] (`TimelineAxis`, optional): The direction of the divider.
  ///   Defaults to [TimelineAxis.horizontal].
  /// - [thickness] (double, optional): The thickness of the divider line.
  ///   Defaults to 2.0. Must be non-negative.
  /// - [begin] (double, optional): The starting position as a percentage (0.0-1.0).
  ///   Defaults to 0.0. Must be less than [end].
  /// - [end] (double, optional): The ending position as a percentage (0.0-1.0).
  ///   Defaults to 1.0. Must be greater than [begin].
  /// - [color] (Color, optional): The color of the divider line.
  ///   Defaults to [Colors.grey].
  const TimelineDivider({
    super.key,
    this.axis = TimelineAxis.horizontal,
    this.thickness = 2.0,
    this.begin = 0.0,
    this.end = 1.0,
    this.color = Colors.grey,
    this.borderRadius,

  })  : assert(thickness >= 0.0, 'The thickness must be a non-negative value'),
        assert(
          begin >= 0.0 && begin <= 1.0,
          'The begin value must be between 0.0 and 1.0',
        ),
        assert(
          end >= 0.0 && end <= 1.0,
          'The end value must be between 0.0 and 1.0',
        ),
        assert(end > begin, 'The end value must be greater than begin');

  /// The axis direction for the divider.
  ///
  /// Use [TimelineAxis.horizontal] for a left-to-right line, or
  /// [TimelineAxis.vertical] for a top-to-bottom line.
  ///
  /// When building timelines, this is typically set to the opposite axis
  /// of the timeline tiles. For example, use horizontal dividers between
  /// vertically stacked tiles.
  ///
  /// Defaults to [TimelineAxis.horizontal].
  final TimelineAxis axis;

  /// The thickness of the divider line in logical pixels.
  ///
  /// Must be a non-negative value. Defaults to 2.0.
  final double thickness;

  /// The starting position of the divider as a percentage.
  ///
  /// A value of 0.0 starts at the left edge (horizontal) or top edge (vertical).
  /// A value of 1.0 represents the right edge (horizontal) or bottom edge (vertical).
  ///
  /// Must be between 0.0 and 1.0, and must be less than [end].
  /// Defaults to 0.0.
  final double begin;

  /// The ending position of the divider as a percentage.
  ///
  /// A value of 0.0 represents the left edge (horizontal) or top edge (vertical).
  /// A value of 1.0 ends at the right edge (horizontal) or bottom edge (vertical).
  ///
  /// Must be between 0.0 and 1.0, and must be greater than [begin].
  /// Defaults to 1.0.
  final double end;

  /// The color of the divider line.
  ///
  /// Defaults to [Colors.grey].
  final Color color;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (axis == TimelineAxis.horizontal) {
          return _buildHorizontalDivider(constraints);
        } else {
          return _buildVerticalDivider(constraints);
        }
      },
    );
  }

  /// Builds the horizontal divider layout.
  /// The line connects the centers at begin% and end% of total width.
  Widget _buildHorizontalDivider(BoxConstraints constraints) {
    final double totalWidth = constraints.maxWidth;
    
    // The indicator centers are at these positions
    final double startCenter = totalWidth * begin;
    final double endCenter = totalWidth * end;
    
    // The line's left edge should start at startCenter so it overlaps
    // with the vertical line drawn at that center point
    final double leftMargin = startCenter;
    final double lineWidth = endCenter - startCenter;

    return Container(
      height: thickness,
      margin: EdgeInsets.only(left: leftMargin),
      width: lineWidth > 0 ? lineWidth : 1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(2),
      ),
    );
  }

  /// Builds the vertical divider layout.
  /// The line connects the centers at begin% and end% of total height.
  Widget _buildVerticalDivider(BoxConstraints constraints) {
    final double totalHeight = constraints.maxHeight;
    
    // The indicator centers are at these positions
    final double startCenter = totalHeight * begin;
    final double endCenter = totalHeight * end;
    
    // The line's top edge should start at startCenter
    final double topMargin = startCenter;
    final double lineHeight = endCenter - startCenter;

    return Container(
      width: thickness,
      margin: EdgeInsets.only(top: topMargin),
      height: lineHeight > 0 ? lineHeight : 1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(thickness / 2),
      ),
    );
  }
}
