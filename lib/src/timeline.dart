import 'package:flutter/material.dart';

import 'timeline_data.dart';
import 'timeline_theme.dart';

/// A vertical timeline widget for displaying chronological data.
///
/// [Timeline] creates a structured vertical layout showing a sequence of events
/// or data points with time information, titles, optional content, and visual
/// indicators. Each entry is represented by a [TimelineData] object and displayed
/// with a consistent three-column layout:
///
/// 1. Left column: Time/timestamp information (right-aligned)
/// 2. Center column: Visual indicator dot and connecting lines
/// 3. Right column: Title and optional content
///
/// The timeline automatically handles:
/// - Proper spacing and alignment between columns
/// - Visual indicators with customizable colors per entry
/// - Connecting lines between entries (except for the last entry)
/// - Text styling consistent with the design system
///
/// Supports theming via [TimelineTheme] for consistent styling and can be
/// customized per instance with parameters.
///
/// Example:
/// ```dart
/// Timeline(
///   data: [
///     TimelineData(
///       time: Text('9:00 AM'),
///       title: Text('Morning Standup'),
///       content: Text('Daily team sync to discuss progress and blockers.'),
///       color: Colors.green,
///     ),
///     TimelineData(
///       time: Text('2:00 PM'),
///       title: Text('Code Review'),
///       content: Text('Review pull requests and provide feedback.'),
///     ),
///   ],
/// );
/// ```
class Timeline extends StatelessWidget {
  /// List of timeline entries to display.
  ///
  /// Each [TimelineData] object represents one row in the timeline with
  /// time information, title, optional content, and optional custom color.
  /// The timeline renders entries in the order provided in this list.
  final List<TimelineData> data;

  /// Override constraints for the time column width.
  ///
  /// When provided, overrides the theme's [TimelineTheme.timeConstraints]
  /// for this specific timeline instance. Controls how much space is allocated
  /// for displaying time information. If null, uses theme or default constraints.
  final BoxConstraints? timeConstraints;

  /// Override horizontal spacing between columns.
  ///
  /// When provided, overrides the theme's [TimelineTheme.spacing].
  final double? spacing;

  /// Override diameter of timeline indicator dots.
  ///
  /// When provided, overrides the theme's [TimelineTheme.dotSize].
  final double? dotSize;

  /// Override thickness of connector lines.
  ///
  /// When provided, overrides the theme's [TimelineTheme.connectorThickness].
  final double? connectorThickness;

  /// Override default color for indicators and connectors.
  ///
  /// When provided, overrides the theme's [TimelineTheme.color].
  final Color? color;

  /// Override vertical spacing between rows.
  ///
  /// When provided, overrides the theme's [TimelineTheme.rowGap].
  final double? rowGap;

  /// Override text style for time text.
  ///
  /// When provided, overrides the theme's [TimelineTheme.timeTextStyle].
  final TextStyle? timeTextStyle;

  /// Override text style for title text.
  ///
  /// When provided, overrides the theme's [TimelineTheme.titleTextStyle].
  final TextStyle? titleTextStyle;

  /// Override text style for content text.
  ///
  /// When provided, overrides the theme's [TimelineTheme.contentTextStyle].
  final TextStyle? contentTextStyle;

  /// Override whether to use circular dots.
  ///
  /// When provided, overrides the theme's [TimelineTheme.useCircularDots].
  final bool? useCircularDots;

  /// Creates a [Timeline] widget with the specified data entries.
  ///
  /// Parameters:
  /// - [data] (`List<TimelineData>`, required): Timeline entries to display in order.
  /// - [timeConstraints] (BoxConstraints?, optional): Override width constraints for time column.
  /// - [spacing] (double?, optional): Override horizontal spacing between columns.
  /// - [dotSize] (double?, optional): Override size of timeline indicator dots.
  /// - [connectorThickness] (double?, optional): Override thickness of connecting lines.
  /// - [color] (Color?, optional): Override default color for indicators and connectors.
  /// - [rowGap] (double?, optional): Override vertical spacing between rows.
  /// - [timeTextStyle] (TextStyle?, optional): Override text style for time text.
  /// - [titleTextStyle] (TextStyle?, optional): Override text style for title text.
  /// - [contentTextStyle] (TextStyle?, optional): Override text style for content text.
  /// - [useCircularDots] (bool?, optional): Override whether to use circular dots.
  ///
  /// Example:
  /// ```dart
  /// Timeline(
  ///   timeConstraints: BoxConstraints(minWidth: 80, maxWidth: 120),
  ///   data: [
  ///     TimelineData(
  ///       time: Text('Yesterday'),
  ///       title: Text('Initial Setup'),
  ///       content: Text('Project repository created and initial structure added.'),
  ///     ),
  ///     TimelineData(
  ///       time: Text('Today'),
  ///       title: Text('Feature Development'),
  ///       content: Text('Implementing core functionality and UI components.'),
  ///       color: Colors.orange,
  ///     ),
  ///   ],
  /// );
  /// ```
  const Timeline({
    super.key,
    required this.data,
    this.timeConstraints,
    this.spacing,
    this.dotSize,
    this.connectorThickness,
    this.color,
    this.rowGap,
    this.timeTextStyle,
    this.titleTextStyle,
    this.contentTextStyle,
    this.useCircularDots,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = TimelineThemeData.maybeOf(context);

    // Resolve values from widget props -> theme -> defaults
    final resolvedTimeConstraints =
        timeConstraints ??
        compTheme?.timeConstraints ??
        const BoxConstraints(minWidth: 120, maxWidth: 120);
    final resolvedSpacing = spacing ?? compTheme?.spacing ?? 16.0;
    final resolvedDotSize = dotSize ?? compTheme?.dotSize ?? 12.0;
    final resolvedConnectorThickness =
        connectorThickness ?? compTheme?.connectorThickness ?? 2.0;
    final resolvedColor =
        color ?? compTheme?.color ?? theme.colorScheme.primary;
    final resolvedRowGap = rowGap ?? compTheme?.rowGap ?? 16.0;
    final resolvedUseCircularDots =
        useCircularDots ?? compTheme?.useCircularDots ?? true;

    // Default text styles
    final defaultTimeTextStyle =
        timeTextStyle ??
        compTheme?.timeTextStyle ??
        theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        );
    final defaultTitleTextStyle =
        titleTextStyle ??
        compTheme?.titleTextStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.87),
        );
    final defaultContentTextStyle =
        contentTextStyle ??
        compTheme?.contentTextStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        );

    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final entryColor = entry.color ?? resolvedColor;

      // Build the top row with time, dot, and title aligned
      final topRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time column
          ConstrainedBox(
            constraints: resolvedTimeConstraints,
            child: Align(
              alignment: Alignment.centerRight,
              child: DefaultTextStyle(
                style: defaultTimeTextStyle ?? const TextStyle(),
                child: entry.time,
              ),
            ),
          ),
          SizedBox(width: resolvedSpacing),
          // Dot indicator
          Container(
            width: resolvedDotSize,
            height: resolvedDotSize,
            decoration: BoxDecoration(
              shape:
                  resolvedUseCircularDots
                      ? BoxShape.circle
                      : BoxShape.rectangle,
              color: entryColor,
            ),
          ),
          SizedBox(width: resolvedSpacing),
          // Title
          Expanded(
            child: DefaultTextStyle(
              style: defaultTitleTextStyle ?? const TextStyle(),
              child: entry.title,
            ),
          ),
        ],
      );

      // Build the content area with connector line
      Widget? contentArea;
      if (entry.content != null || i != data.length - 1) {
        contentArea = IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Empty space for time column
              ConstrainedBox(
                constraints: resolvedTimeConstraints,
                child: const SizedBox(),
              ),
              SizedBox(width: resolvedSpacing),
              // Connector line
              if (i != data.length - 1)
                SizedBox(
                  width: resolvedDotSize,
                  child: Center(
                    child: Container(
                      width: resolvedConnectorThickness,
                      color: entryColor,
                    ),
                  ),
                )
              else
                SizedBox(width: resolvedDotSize),
              SizedBox(width: resolvedSpacing),
              // Content
              if (entry.content != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: DefaultTextStyle(
                      style: defaultContentTextStyle ?? const TextStyle(),
                      child: entry.content!,
                    ),
                  ),
                )
              else
                const Expanded(child: SizedBox(height: 8)),
            ],
          ),
        );
      }

      rows.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [topRow, if (contentArea != null) contentArea],
        ),
      );

      // Add gap between rows (except after the last row)
      if (i != data.length - 1) {
        rows.add(SizedBox(height: resolvedRowGap));
      }
    }

    return Column(mainAxisSize: MainAxisSize.min, children: rows);
  }
}
