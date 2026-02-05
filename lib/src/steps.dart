import 'package:flutter/material.dart';

/// Theme configuration for [Steps] widget.
///
/// Use this to customize the appearance of the Steps widget including
/// indicator size, spacing, colors, and connector thickness.
class StepsTheme {
  /// Diameter of the step indicator circle.
  final double indicatorSize;

  /// Gap between the indicator and the step content.
  final double spacing;

  /// Color of the indicator and connector line.
  final Color indicatorColor;

  /// Thickness of the connector line.
  final double connectorThickness;

  /// Text style for the step number inside the indicator.
  final TextStyle? numberTextStyle;

  /// Creates a [StepsTheme].
  const StepsTheme({
    this.indicatorSize = 28.0,
    this.spacing = 18.0,
    this.indicatorColor = Colors.grey,
    this.connectorThickness = 1.0,
    this.numberTextStyle,
  });

  /// Creates a copy of this theme with the given fields replaced.
  StepsTheme copyWith({
    double? indicatorSize,
    double? spacing,
    Color? indicatorColor,
    double? connectorThickness,
    TextStyle? numberTextStyle,
  }) {
    return StepsTheme(
      indicatorSize: indicatorSize ?? this.indicatorSize,
      spacing: spacing ?? this.spacing,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      connectorThickness: connectorThickness ?? this.connectorThickness,
      numberTextStyle: numberTextStyle ?? this.numberTextStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepsTheme &&
        other.indicatorSize == indicatorSize &&
        other.spacing == spacing &&
        other.indicatorColor == indicatorColor &&
        other.connectorThickness == connectorThickness &&
        other.numberTextStyle == numberTextStyle;
  }

  @override
  int get hashCode => Object.hash(
    indicatorSize,
    spacing,
    indicatorColor,
    connectorThickness,
    numberTextStyle,
  );
}

/// An inherited widget that provides [StepsTheme] to descendant [Steps] widgets.
class StepsThemeData extends InheritedWidget {
  /// The theme configuration for Steps widgets.
  final StepsTheme theme;

  /// Creates a [StepsThemeData].
  const StepsThemeData({super.key, required this.theme, required super.child});

  /// Returns the [StepsTheme] from the closest [StepsThemeData] ancestor.
  static StepsTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StepsThemeData>()?.theme;
  }

  /// Returns the [StepsTheme] from the closest [StepsThemeData] ancestor,
  /// or a default theme if none is found.
  static StepsTheme of(BuildContext context) {
    return maybeOf(context) ?? const StepsTheme();
  }

  @override
  bool updateShouldNotify(StepsThemeData oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Vertical step progression widget with numbered indicators and connectors.
///
/// A layout widget that displays a vertical sequence of steps, each with a
/// numbered circular indicator connected by lines. Ideal for showing progress
/// through multi-step processes, tutorials, or workflows.
///
/// ## Features
///
/// - **Numbered indicators**: Circular indicators with automatic step numbering
/// - **Connector lines**: Visual lines connecting consecutive steps
/// - **Flexible content**: Each step can contain any widget content
/// - **Responsive theming**: Customizable indicator size, spacing, and colors
/// - **Intrinsic sizing**: Automatically adjusts to content height
///
/// The widget automatically numbers each step starting from 1 and connects
/// them with vertical lines. Each step's content is placed to the right of
/// its indicator.
///
/// Example:
/// ```dart
/// Steps(
///   children: [
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Sign up with your email address'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Verify Email', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Check your inbox for verification'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Complete Profile', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Add your personal information'),
///       ],
///     ),
///   ],
/// );
/// ```
class Steps extends StatelessWidget {
  /// List of widgets representing each step in the sequence.
  ///
  /// Each widget will be displayed with an automatically numbered
  /// circular indicator showing its position in the sequence.
  final List<Widget> children;

  /// Diameter of the step indicator circle.
  /// Overrides [StepsTheme.indicatorSize] if provided.
  final double? indicatorSize;

  /// Gap between the indicator and the step content.
  /// Overrides [StepsTheme.spacing] if provided.
  final double? spacing;

  /// Color of the indicator and connector line.
  /// Overrides [StepsTheme.indicatorColor] if provided.
  final Color? indicatorColor;

  /// Thickness of the connector line.
  /// Overrides [StepsTheme.connectorThickness] if provided.
  final double? connectorThickness;

  /// Text style for the step number inside the indicator.
  /// Overrides [StepsTheme.numberTextStyle] if provided.
  final TextStyle? numberTextStyle;

  /// Bottom padding for each step content.
  final double bottomPadding;

  /// Creates a [Steps] widget.
  ///
  /// Each child widget represents one step in the sequence and will be
  /// displayed with an automatically numbered circular indicator.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): list of widgets representing each step
  /// - [indicatorSize]: diameter of the step indicator circle
  /// - [spacing]: gap between the indicator and step content
  /// - [indicatorColor]: color of the indicator and connector line
  /// - [connectorThickness]: thickness of the connector line
  /// - [numberTextStyle]: text style for the step number
  /// - [bottomPadding]: bottom padding for each step content (default: 32.0)
  ///
  /// Example:
  /// ```dart
  /// Steps(
  ///   children: [
  ///     Text('First step content'),
  ///     Text('Second step content'),
  ///     Text('Third step content'),
  ///   ],
  /// )
  /// ```
  const Steps({
    super.key,
    required this.children,
    this.indicatorSize,
    this.spacing,
    this.indicatorColor,
    this.connectorThickness,
    this.numberTextStyle,
    this.bottomPadding = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = StepsThemeData.maybeOf(context) ?? const StepsTheme();
    final effectiveIndicatorSize = indicatorSize ?? theme.indicatorSize;
    final effectiveSpacing = spacing ?? theme.spacing;
    final effectiveIndicatorColor = indicatorColor ?? theme.indicatorColor;
    final effectiveConnectorThickness =
        connectorThickness ?? theme.connectorThickness;
    final effectiveNumberTextStyle =
        numberTextStyle ??
        theme.numberTextStyle ??
        const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace');

    List<Widget> mapped = [];
    for (var i = 0; i < children.length; i++) {
      final isLast = i == children.length - 1;
      mapped.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: effectiveIndicatorColor,
                      shape: BoxShape.circle,
                    ),
                    width: effectiveIndicatorSize,
                    height: effectiveIndicatorSize,
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: effectiveNumberTextStyle,
                      ),
                    ),
                  ),
                  if (!isLast) ...[
                    const SizedBox(height: 4),
                    Expanded(
                      child: VerticalDivider(
                        thickness: effectiveConnectorThickness,
                        color: effectiveIndicatorColor,
                        width: effectiveConnectorThickness,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ],
              ),
              SizedBox(width: effectiveSpacing),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : bottomPadding),
                  child: children[i],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: mapped,
      ),
    );
  }
}

/// A vertical step indicator widget that displays a step's title and content.
///
/// Typically used as children within [Steps] to create a multi-step
/// process visualization. Displays a title in bold followed by content items.
///
/// Example:
/// ```dart
/// StepItem(
///   title: Text('Step Title'),
///   content: [
///     Text('Step description'),
///     Text('Additional details'),
///   ],
/// )
/// ```
class StepItem extends StatelessWidget {
  /// The title of this step, displayed prominently.
  final Widget title;

  /// List of content widgets to display under the title.
  final List<Widget> content;

  /// Text style for the title.
  final TextStyle? titleStyle;

  /// Spacing between title and content items.
  final double spacing;

  /// Creates a [StepItem].
  const StepItem({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitleStyle =
        titleStyle ??
        Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultTextStyle.merge(style: effectiveTitleStyle, child: title),
        SizedBox(height: spacing),
        ...content,
      ],
    );
  }
}
