import 'package:flutter/material.dart';

/// Theme configuration for [Timeline] widgets.
///
/// Provides styling and layout defaults for timeline components including
/// column constraints, spacing, indicator appearance, and connector styling.
/// Wrap your widget tree with [TimelineThemeData] to apply consistent
/// timeline styling across an application while allowing per-instance customization.
///
/// Example:
/// ```dart
/// TimelineThemeData(
///   theme: TimelineTheme(
///     timeConstraints: BoxConstraints(minWidth: 100, maxWidth: 150),
///     spacing: 20.0,
///     dotSize: 16.0,
///     color: Colors.blue,
///     rowGap: 24.0,
///   ),
///   child: MyTimelineWidget(),
/// );
/// ```
class TimelineTheme {
  /// Default constraints for the time column width.
  ///
  /// Controls the minimum and maximum width allocated for displaying time
  /// information in each timeline row. If null, individual Timeline widgets
  /// use their own constraints or a default of 120 logical pixels.
  final BoxConstraints? timeConstraints;

  /// Default horizontal spacing between timeline columns.
  ///
  /// Determines the gap between the time column, indicator column, and content
  /// column. If null, defaults to 16 logical pixels.
  final double? spacing;

  /// Default diameter of timeline indicator dots.
  ///
  /// Controls the size of the circular indicator that marks each timeline entry.
  /// If null, defaults to 12 logical pixels.
  final double? dotSize;

  /// Default thickness of connector lines between timeline entries.
  ///
  /// Controls the width of vertical lines that connect timeline indicators.
  /// If null, defaults to 2 logical pixels.
  final double? connectorThickness;

  /// Default color for indicators and connectors when not specified per entry.
  ///
  /// Used as the fallback color for timeline dots and connecting lines when
  /// individual [TimelineData] entries don't specify their own color.
  final Color? color;

  /// Default vertical spacing between timeline rows.
  ///
  /// Controls the gap between each timeline entry in the vertical layout.
  /// If null, defaults to 16 logical pixels.
  final double? rowGap;

  /// Text style for the time/timestamp text.
  ///
  /// If null, uses a medium-weight, smaller text style based on the theme.
  final TextStyle? timeTextStyle;

  /// Text style for the title text.
  ///
  /// If null, uses a semi-bold text style based on the theme.
  final TextStyle? titleTextStyle;

  /// Text style for the content/description text.
  ///
  /// If null, uses a muted, smaller text style based on the theme.
  final TextStyle? contentTextStyle;

  /// Whether to use circular dots (true) or square dots (false).
  ///
  /// Defaults to true (circular dots).
  final bool useCircularDots;

  /// Creates a [TimelineTheme] with the specified styling options.
  ///
  /// All parameters are optional and will be merged with widget-level settings
  /// or system defaults when not specified.
  const TimelineTheme({
    this.timeConstraints,
    this.spacing,
    this.dotSize,
    this.connectorThickness,
    this.color,
    this.rowGap,
    this.timeTextStyle,
    this.titleTextStyle,
    this.contentTextStyle,
    this.useCircularDots = true,
  });

  /// Creates a copy of this theme with the given values replaced.
  TimelineTheme copyWith({
    BoxConstraints? timeConstraints,
    double? spacing,
    double? dotSize,
    double? connectorThickness,
    Color? color,
    double? rowGap,
    TextStyle? timeTextStyle,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    bool? useCircularDots,
  }) {
    return TimelineTheme(
      timeConstraints: timeConstraints ?? this.timeConstraints,
      spacing: spacing ?? this.spacing,
      dotSize: dotSize ?? this.dotSize,
      connectorThickness: connectorThickness ?? this.connectorThickness,
      color: color ?? this.color,
      rowGap: rowGap ?? this.rowGap,
      timeTextStyle: timeTextStyle ?? this.timeTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      useCircularDots: useCircularDots ?? this.useCircularDots,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimelineTheme &&
        other.timeConstraints == timeConstraints &&
        other.spacing == spacing &&
        other.dotSize == dotSize &&
        other.connectorThickness == connectorThickness &&
        other.color == color &&
        other.rowGap == rowGap &&
        other.timeTextStyle == timeTextStyle &&
        other.titleTextStyle == titleTextStyle &&
        other.contentTextStyle == contentTextStyle &&
        other.useCircularDots == useCircularDots;
  }

  @override
  int get hashCode => Object.hash(
    timeConstraints,
    spacing,
    dotSize,
    connectorThickness,
    color,
    rowGap,
    timeTextStyle,
    titleTextStyle,
    contentTextStyle,
    useCircularDots,
  );
}

/// An inherited widget that provides [TimelineTheme] to descendant widgets.
///
/// Wrap your widget tree with this to provide theme configuration to all
/// [Timeline] widgets in the subtree.
///
/// Example:
/// ```dart
/// TimelineThemeData(
///   theme: TimelineTheme(
///     color: Colors.blue,
///     dotSize: 14.0,
///   ),
///   child: Timeline(
///     data: [...],
///   ),
/// );
/// ```
class TimelineThemeData extends InheritedWidget {
  /// The timeline theme configuration to provide to descendants.
  final TimelineTheme theme;

  /// Creates a [TimelineThemeData] widget.
  const TimelineThemeData({
    super.key,
    required this.theme,
    required super.child,
  });

  /// Retrieves the nearest [TimelineTheme] from the widget tree.
  ///
  /// Returns null if no [TimelineThemeData] ancestor is found.
  static TimelineTheme? maybeOf(BuildContext context) {
    final data =
        context.dependOnInheritedWidgetOfExactType<TimelineThemeData>();
    return data?.theme;
  }

  /// Retrieves the nearest [TimelineTheme] from the widget tree.
  ///
  /// Throws an assertion error if no [TimelineThemeData] ancestor is found.
  static TimelineTheme of(BuildContext context) {
    final theme = maybeOf(context);
    assert(theme != null, 'No TimelineThemeData found in widget tree');
    return theme!;
  }

  @override
  bool updateShouldNotify(TimelineThemeData oldWidget) {
    return theme != oldWidget.theme;
  }
}
