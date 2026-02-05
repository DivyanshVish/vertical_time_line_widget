import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Default animation duration for stepper transitions.
const Duration kStepperAnimationDuration = Duration(milliseconds: 200);

/// Default small step indicator size in logical pixels.
const double kSmallStepIndicatorSize = 36.0;

/// Default medium step indicator size in logical pixels.
const double kMediumStepIndicatorSize = 40.0;

/// Default large step indicator size in logical pixels.
const double kLargeStepIndicatorSize = 44.0;

/// Theme configuration for [VerticalStepper] components.
///
/// Defines default values for stepper direction, size, and visual variant.
///
/// Example:
/// ```dart
/// VerticalStepperThemeData(
///   theme: VerticalStepperTheme(
///     direction: Axis.vertical,
///     size: StepSize.large,
///     variant: StepVariant.circle,
///   ),
///   child: MyApp(),
/// );
/// ```
class VerticalStepperTheme {
  /// Layout direction for the stepper.
  final Axis direction;

  /// Size variant for step indicators.
  final StepSize size;

  /// Visual variant for step presentation.
  final StepVariant variant;

  /// Color for active/completed steps.
  final Color? activeColor;

  /// Color for inactive/pending steps.
  final Color? inactiveColor;

  /// Color for failed steps.
  final Color? errorColor;

  /// Creates a [VerticalStepperTheme].
  const VerticalStepperTheme({
    this.direction = Axis.vertical,
    this.size = StepSize.medium,
    this.variant = StepVariant.circle,
    this.activeColor,
    this.inactiveColor,
    this.errorColor,
  });

  /// Creates a copy of this theme with optionally overridden properties.
  VerticalStepperTheme copyWith({
    Axis? direction,
    StepSize? size,
    StepVariant? variant,
    Color? activeColor,
    Color? inactiveColor,
    Color? errorColor,
  }) {
    return VerticalStepperTheme(
      direction: direction ?? this.direction,
      size: size ?? this.size,
      variant: variant ?? this.variant,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VerticalStepperTheme &&
        other.direction == direction &&
        other.size == size &&
        other.variant == variant &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.errorColor == errorColor;
  }

  @override
  int get hashCode => Object.hash(
    direction,
    size,
    variant,
    activeColor,
    inactiveColor,
    errorColor,
  );
}

/// An inherited widget that provides [VerticalStepperTheme] to descendant widgets.
class VerticalStepperThemeData extends InheritedWidget {
  /// The theme configuration for Stepper widgets.
  final VerticalStepperTheme theme;

  /// Creates a [VerticalStepperThemeData].
  const VerticalStepperThemeData({
    super.key,
    required this.theme,
    required super.child,
  });

  /// Returns the [VerticalStepperTheme] from the closest ancestor.
  static VerticalStepperTheme? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VerticalStepperThemeData>()
        ?.theme;
  }

  /// Returns the [VerticalStepperTheme] from the closest ancestor,
  /// or a default theme if none is found.
  static VerticalStepperTheme of(BuildContext context) {
    return maybeOf(context) ?? const VerticalStepperTheme();
  }

  @override
  bool updateShouldNotify(VerticalStepperThemeData oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Represents the state of an individual step in a stepper.
enum StepState {
  /// Indicates a step has failed validation or encountered an error.
  failed,
}

/// Immutable value representing the current state of a stepper.
///
/// Contains the current active step index and a map of step states
/// for any steps that have special states (like failed).
class StepperValue {
  /// Map of step indices to their special states.
  final Map<int, StepState> stepStates;

  /// Index of the currently active step (0-based).
  final int currentStep;

  /// Creates a [StepperValue].
  StepperValue({required this.stepStates, required this.currentStep});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperValue &&
        mapEquals(other.stepStates, stepStates) &&
        other.currentStep == currentStep;
  }

  @override
  int get hashCode => Object.hash(stepStates, currentStep);

  @override
  String toString() {
    return 'StepperValue{stepStates: $stepStates, currentStep: $currentStep}';
  }
}

/// Represents a single step in a stepper component.
///
/// Contains the step's title, optional content builder for step details,
/// and an optional custom icon.
class StepData {
  /// The title widget displayed for this step.
  final Widget title;

  /// Optional subtitle widget displayed below the title.
  final Widget? subtitle;

  /// Optional builder for step content shown when active.
  final WidgetBuilder? contentBuilder;

  /// Optional custom icon for the step indicator.
  final Widget? icon;

  /// Creates a [StepData].
  const StepData({
    required this.title,
    this.subtitle,
    this.contentBuilder,
    this.icon,
  });
}

/// Defines the size variants available for step indicators.
enum StepSize {
  /// Small step indicators with compact text and icons.
  small(kSmallStepIndicatorSize),

  /// Medium step indicators with normal text and icons (default).
  medium(kMediumStepIndicatorSize),

  /// Large step indicators with larger text and icons.
  large(kLargeStepIndicatorSize);

  /// The numeric size value for the step indicator.
  final double size;

  const StepSize(this.size);

  /// Returns the appropriate text style for this size.
  TextStyle getTextStyle(BuildContext context) {
    final baseStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    switch (this) {
      case StepSize.small:
        return baseStyle.copyWith(fontSize: 12);
      case StepSize.medium:
        return baseStyle.copyWith(fontSize: 14);
      case StepSize.large:
        return baseStyle.copyWith(fontSize: 16);
    }
  }

  /// Returns the appropriate icon size for this size.
  double get iconSize {
    switch (this) {
      case StepSize.small:
        return 16;
      case StepSize.medium:
        return 20;
      case StepSize.large:
        return 24;
    }
  }
}

/// Abstract base class for step visual presentation variants.
///
/// Defines how steps are rendered and connected to each other.
abstract class StepVariant {
  /// Circle variant with numbered indicators and connecting lines.
  static const StepVariant circle = _StepVariantCircle();

  /// Alternative circle variant with centered step names.
  static const StepVariant circleAlt = _StepVariantCircleAlternative();

  /// Minimal line variant with progress bars as step indicators.
  static const StepVariant line = _StepVariantLine();

  /// Creates a [StepVariant].
  const StepVariant();

  /// Builds the stepper widget using this variant's visual style.
  Widget build(BuildContext context, StepProperties properties);
}

/// Contains properties and state information for stepper rendering.
class StepProperties {
  /// Size configuration for step indicators.
  final StepSize size;

  /// List of steps in the stepper.
  final List<StepData> steps;

  /// Listenable state containing current step and step states.
  final ValueListenable<StepperValue> state;

  /// Layout direction for the stepper.
  final Axis direction;

  /// Color for active/completed steps.
  final Color activeColor;

  /// Color for inactive/pending steps.
  final Color inactiveColor;

  /// Color for failed steps.
  final Color errorColor;

  /// Background color.
  final Color backgroundColor;

  /// Creates [StepProperties].
  const StepProperties({
    required this.size,
    required this.steps,
    required this.state,
    required this.direction,
    required this.activeColor,
    required this.inactiveColor,
    required this.errorColor,
    required this.backgroundColor,
  });

  /// Safely accesses a step by index, returning null if out of bounds.
  StepData? operator [](int index) {
    if (index < 0 || index >= steps.length) {
      return null;
    }
    return steps[index];
  }

  /// Returns true if any step has a failed state.
  bool get hasFailure => state.value.stepStates.containsValue(StepState.failed);
}

/// Controller for managing stepper state and navigation.
///
/// Extends [ValueNotifier] to provide reactive state updates when
/// the current step changes or step states are modified.
class StepperController extends ValueNotifier<StepperValue> {
  /// Creates a [StepperController].
  StepperController({Map<int, StepState>? stepStates, int? currentStep})
    : super(
        StepperValue(
          stepStates: stepStates ?? {},
          currentStep: currentStep ?? 0,
        ),
      );

  /// Advances to the next step.
  void nextStep() {
    value = StepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep + 1,
    );
  }

  /// Returns to the previous step.
  void previousStep() {
    value = StepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep - 1,
    );
  }

  /// Sets or clears the state of a specific step.
  void setStatus(int step, StepState? state) {
    Map<int, StepState> newStates = Map.from(value.stepStates);
    if (state == null) {
      newStates.remove(step);
    } else {
      newStates[step] = state;
    }
    value = StepperValue(stepStates: newStates, currentStep: value.currentStep);
  }

  /// Jumps directly to the specified step.
  void jumpToStep(int step) {
    value = StepperValue(stepStates: value.stepStates, currentStep: step);
  }
}

/// A multi-step navigation component with visual progress indication.
///
/// Displays a sequence of steps with customizable visual styles, supporting
/// both horizontal and vertical layouts.
///
/// Example:
/// ```dart
/// final controller = StepperController();
///
/// VerticalStepper(
///   controller: controller,
///   direction: Axis.vertical,
///   variant: StepVariant.circle,
///   size: StepSize.medium,
///   steps: [
///     StepData(
///       title: Text('Personal Info'),
///       contentBuilder: (context) => PersonalInfoForm(),
///     ),
///     StepData(
///       title: Text('Address'),
///       contentBuilder: (context) => AddressForm(),
///     ),
///     StepData(
///       title: Text('Confirmation'),
///       contentBuilder: (context) => ConfirmationView(),
///     ),
///   ],
/// );
/// ```
class VerticalStepper extends StatelessWidget {
  /// Controller for managing stepper state and navigation.
  final StepperController controller;

  /// List of steps to display in the stepper.
  final List<StepData> steps;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Size variant for step indicators.
  final StepSize? size;

  /// Visual variant for step presentation.
  final StepVariant? variant;

  /// Color for active/completed steps.
  final Color? activeColor;

  /// Color for inactive/pending steps.
  final Color? inactiveColor;

  /// Color for failed steps.
  final Color? errorColor;

  /// Creates a [VerticalStepper].
  const VerticalStepper({
    super.key,
    required this.controller,
    required this.steps,
    this.direction,
    this.size,
    this.variant,
    this.activeColor,
    this.inactiveColor,
    this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = VerticalStepperThemeData.maybeOf(context);
    final dir = direction ?? compTheme?.direction ?? Axis.vertical;
    final sz = size ?? compTheme?.size ?? StepSize.medium;
    final varnt = variant ?? compTheme?.variant ?? StepVariant.circle;
    final active =
        activeColor ?? compTheme?.activeColor ?? theme.colorScheme.primary;
    final inactive =
        inactiveColor ?? compTheme?.inactiveColor ?? theme.colorScheme.outline;
    final error =
        errorColor ?? compTheme?.errorColor ?? theme.colorScheme.error;
    final background = theme.colorScheme.surface;

    var stepProperties = StepProperties(
      size: sz,
      steps: steps,
      state: controller,
      direction: dir,
      activeColor: active,
      inactiveColor: inactive,
      errorColor: error,
      backgroundColor: background,
    );

    return _StepPropertiesProvider(
      properties: stepProperties,
      child: varnt.build(context, stepProperties),
    );
  }
}

/// Internal inherited widget for providing step properties.
class _StepPropertiesProvider extends InheritedWidget {
  final StepProperties properties;

  const _StepPropertiesProvider({
    required this.properties,
    required super.child,
  });

  static StepProperties? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_StepPropertiesProvider>()
        ?.properties;
  }

  @override
  bool updateShouldNotify(_StepPropertiesProvider oldWidget) {
    return properties != oldWidget.properties;
  }
}

/// Internal inherited widget for providing step index.
class _StepIndexProvider extends InheritedWidget {
  final int stepIndex;

  const _StepIndexProvider({required this.stepIndex, required super.child});

  static int? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_StepIndexProvider>()
        ?.stepIndex;
  }

  @override
  bool updateShouldNotify(_StepIndexProvider oldWidget) {
    return stepIndex != oldWidget.stepIndex;
  }
}

/// Circle variant implementation.
class _StepVariantCircle extends StepVariant {
  const _StepVariantCircle();

  @override
  Widget build(BuildContext context, StepProperties properties) {
    if (properties.direction == Axis.horizontal) {
      return _buildHorizontal(context, properties);
    } else {
      return _buildVertical(context, properties);
    }
  }

  Widget _buildHorizontal(BuildContext context, StepProperties properties) {
    List<Widget> children = [];
    for (int i = 0; i < properties.steps.length; i++) {
      final isLast = i == properties.steps.length - 1;
      
      // Build the connector line widget for non-last items
      Widget? connectorLine;
      if (!isLast) {
        connectorLine = ValueListenableBuilder<StepperValue>(
          valueListenable: properties.state,
          builder: (context, value, child) {
            return Container(
              height: 2,
              constraints: const BoxConstraints(minWidth: 16),
              color:
                  properties.hasFailure && value.currentStep <= i
                      ? properties.errorColor
                      : value.currentStep >= i
                      ? properties.activeColor
                      : properties.inactiveColor,
            );
          },
        );
      }

      Widget childWidget = _StepIndexProvider(
        stepIndex: i,
        child: Row(
          children: [
            properties[i]?.icon ?? const StepNumber(),
            const SizedBox(width: 4),
            Flexible(
              child: DefaultTextStyle.merge(
                style: properties.size.getTextStyle(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                child: properties[i]?.title ?? const SizedBox(),
              ),
            ),
            if (!isLast) ...[
              const SizedBox(width: 4),
              Expanded(child: connectorLine!),
            ],
          ],
        ),
      );
      
      // All items get wrapped in Expanded for equal distribution
      children.add(Expanded(child: childWidget));
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        ValueListenableBuilder<StepperValue>(
          valueListenable: properties.state,
          builder: (context, value, child) {
            var current = value.currentStep;
            return IndexedStack(
              index:
                  current < 0 || current >= properties.steps.length
                      ? properties.steps.length
                      : current,
              children: [
                for (int i = 0; i < properties.steps.length; i++)
                  properties[i]?.contentBuilder?.call(context) ??
                      const SizedBox(),
                const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildVertical(BuildContext context, StepProperties properties) {
    List<Widget> children = [];
    for (int i = 0; i < properties.steps.length; i++) {
      children.add(
        _StepIndexProvider(
          stepIndex: i,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  properties.steps[i].icon ?? const StepNumber(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: properties.size.getTextStyle(context),
                          child: properties.steps[i].title,
                        ),
                        if (properties.steps[i].subtitle != null)
                          DefaultTextStyle(
                            style: properties.size
                                .getTextStyle(context)
                                .copyWith(
                                  color: properties.inactiveColor,
                                  fontSize:
                                      properties.size
                                          .getTextStyle(context)
                                          .fontSize! -
                                      2,
                                ),
                            child: properties.steps[i].subtitle!,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 16),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: properties.size.size / 2 - 1,
                      bottom: 0,
                      child:
                          i == properties.steps.length - 1
                              ? const SizedBox()
                              : ValueListenableBuilder<StepperValue>(
                                valueListenable: properties.state,
                                builder: (context, value, child) {
                                  return Container(
                                    width: 2,
                                    color:
                                        properties.hasFailure &&
                                                value.currentStep <= i
                                            ? properties.errorColor
                                            : value.currentStep >= i
                                            ? properties.activeColor
                                            : properties.inactiveColor,
                                  );
                                },
                              ),
                    ),
                    ValueListenableBuilder<StepperValue>(
                      valueListenable: properties.state,
                      builder: (context, value, child) {
                        final content = properties.steps[i].contentBuilder
                            ?.call(context);
                        return AnimatedCrossFade(
                          firstChild: const SizedBox(height: 0),
                          secondChild: Container(
                            margin: EdgeInsets.only(
                              left: properties.size.size + 8,
                            ),
                            child: content ?? const SizedBox(),
                          ),
                          crossFadeState:
                              value.currentStep == i
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: kStepperAnimationDuration,
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (i != properties.steps.length - 1) const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Circle alternative variant implementation.
class _StepVariantCircleAlternative extends StepVariant {
  const _StepVariantCircleAlternative();

  @override
  Widget build(BuildContext context, StepProperties properties) {
    if (properties.direction == Axis.horizontal) {
      return _buildHorizontal(context, properties);
    } else {
      // Same as circle variant for vertical
      return const _StepVariantCircle().build(context, properties);
    }
  }

  Widget _buildHorizontal(BuildContext context, StepProperties properties) {
    List<Widget> children = [];
    for (int i = 0; i < properties.steps.length; i++) {
      children.add(
        _StepIndexProvider(
          stepIndex: i,
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    i == 0
                        ? const Spacer()
                        : Expanded(
                          child: ValueListenableBuilder<StepperValue>(
                            valueListenable: properties.state,
                            builder: (context, value, child) {
                              return Container(
                                height: 2,
                                color:
                                    properties.hasFailure &&
                                            value.currentStep <= i - 1
                                        ? properties.errorColor
                                        : value.currentStep >= i - 1
                                        ? properties.activeColor
                                        : properties.inactiveColor,
                              );
                            },
                          ),
                        ),
                    const SizedBox(width: 4),
                    properties.steps[i].icon ?? const StepNumber(),
                    const SizedBox(width: 4),
                    i == properties.steps.length - 1
                        ? const Spacer()
                        : Expanded(
                          child: ValueListenableBuilder<StepperValue>(
                            valueListenable: properties.state,
                            builder: (context, value, child) {
                              return Container(
                                height: 2,
                                color:
                                    properties.hasFailure &&
                                            value.currentStep <= i
                                        ? properties.errorColor
                                        : value.currentStep >= i
                                        ? properties.activeColor
                                        : properties.inactiveColor,
                              );
                            },
                          ),
                        ),
                  ],
                ),
                const SizedBox(height: 4),
                Center(
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: properties.size.getTextStyle(context),
                    child: properties.steps[i].title,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
        ValueListenableBuilder<StepperValue>(
          valueListenable: properties.state,
          builder: (context, value, child) {
            var current = value.currentStep;
            return IndexedStack(
              index:
                  current < 0 || current >= properties.steps.length
                      ? properties.steps.length
                      : current,
              children: [
                for (int i = 0; i < properties.steps.length; i++)
                  properties[i]?.contentBuilder?.call(context) ??
                      const SizedBox(),
                const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Line variant implementation.
class _StepVariantLine extends StepVariant {
  const _StepVariantLine();

  @override
  Widget build(BuildContext context, StepProperties properties) {
    if (properties.direction == Axis.horizontal) {
      return _buildHorizontal(context, properties);
    } else {
      return _buildVertical(context, properties);
    }
  }

  Widget _buildHorizontal(BuildContext context, StepProperties properties) {
    List<Widget> children = [];
    for (int i = 0; i < properties.steps.length; i++) {
      children.add(
        Expanded(
          child: _StepIndexProvider(
            stepIndex: i,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<StepperValue>(
                  valueListenable: properties.state,
                  builder: (context, value, child) {
                    return Container(
                      height: 3,
                      color:
                          properties.hasFailure && value.currentStep <= i
                              ? properties.errorColor
                              : value.currentStep >= i
                              ? properties.activeColor
                              : properties.inactiveColor,
                    );
                  },
                ),
                const SizedBox(height: 8),
                DefaultTextStyle(
                  style: properties.size.getTextStyle(context),
                  child: properties.steps[i].title,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                children.expand((w) => [w, const SizedBox(width: 16)]).toList()
                  ..removeLast(),
          ),
        ),
        ValueListenableBuilder<StepperValue>(
          valueListenable: properties.state,
          builder: (context, value, child) {
            var current = value.currentStep;
            return IndexedStack(
              index:
                  current < 0 || current >= properties.steps.length
                      ? properties.steps.length
                      : current,
              children: [
                for (int i = 0; i < properties.steps.length; i++)
                  properties[i]?.contentBuilder?.call(context) ??
                      const SizedBox(),
                const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildVertical(BuildContext context, StepProperties properties) {
    List<Widget> children = [];
    for (int i = 0; i < properties.steps.length; i++) {
      children.add(
        _StepIndexProvider(
          stepIndex: i,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ValueListenableBuilder<StepperValue>(
                      valueListenable: properties.state,
                      builder: (context, value, child) {
                        return Container(
                          width: 3,
                          color:
                              properties.hasFailure && value.currentStep <= i
                                  ? properties.errorColor
                                  : value.currentStep >= i
                                  ? properties.activeColor
                                  : properties.inactiveColor,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: DefaultTextStyle(
                          style: properties.size.getTextStyle(context),
                          child: properties.steps[i].title,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 16),
                child: ValueListenableBuilder<StepperValue>(
                  valueListenable: properties.state,
                  builder: (context, value, child) {
                    final content = properties.steps[i].contentBuilder?.call(
                      context,
                    );
                    return AnimatedCrossFade(
                      firstChild: const SizedBox(height: 0),
                      secondChild: content ?? const SizedBox(),
                      crossFadeState:
                          value.currentStep == i
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                      duration: kStepperAnimationDuration,
                    );
                  },
                ),
              ),
              if (i != properties.steps.length - 1) const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Step indicator widget displaying step number, checkmark, or custom icon.
///
/// Renders a circular step indicator that shows the step number by default,
/// a checkmark for completed steps, or an X for failed steps.
class StepNumber extends StatelessWidget {
  /// Custom icon to display instead of step number.
  final Widget? icon;

  /// Callback invoked when the step indicator is pressed.
  final VoidCallback? onPressed;

  /// Creates a [StepNumber].
  const StepNumber({super.key, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final properties = _StepPropertiesProvider.of(context);
    final stepIndex = _StepIndexProvider.of(context);

    assert(
      properties != null,
      'StepNumber must be a descendant of VerticalStepper',
    );
    assert(stepIndex != null, 'StepNumber must be used within a step context');

    return ValueListenableBuilder<StepperValue>(
      valueListenable: properties!.state,
      builder: (context, value, child) {
        final isFailed = value.stepStates[stepIndex] == StepState.failed;
        final isCompleted = value.currentStep > stepIndex!;
        final isCurrent = value.currentStep == stepIndex;

        Color backgroundColor;
        Color borderColor;
        Color contentColor;

        if (isFailed) {
          backgroundColor = properties.errorColor;
          borderColor = properties.errorColor;
          contentColor = Colors.white;
        } else if (isCompleted) {
          backgroundColor = properties.activeColor;
          borderColor = properties.activeColor;
          contentColor = properties.backgroundColor;
        } else if (isCurrent) {
          // Create a semi-transparent version of the active color
          final c = properties.activeColor;
          backgroundColor = Color.fromRGBO(
            (c.r * 255).round(),
            (c.g * 255).round(),
            (c.b * 255).round(),
            0.1,
          );
          borderColor = properties.activeColor;
          contentColor = properties.activeColor;
        } else {
          backgroundColor = properties.backgroundColor;
          borderColor = properties.inactiveColor;
          contentColor = properties.inactiveColor;
        }

        Widget indicator = Container(
          width: properties.size.size,
          height: properties.size.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            child:
                isFailed
                    ? Icon(
                      Icons.close,
                      color: contentColor,
                      size: properties.size.iconSize,
                    )
                    : isCompleted
                    ? Icon(
                      Icons.check,
                      color: contentColor,
                      size: properties.size.iconSize,
                    )
                    : icon ??
                        Text(
                          (stepIndex + 1).toString(),
                          style: TextStyle(
                            color: contentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: properties.size.iconSize * 0.7,
                          ),
                        ),
          ),
        );

        if (onPressed != null) {
          return GestureDetector(
            onTap: onPressed,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: indicator,
            ),
          );
        }

        return indicator;
      },
    );
  }
}

/// Container widget for step content with optional action buttons.
///
/// Provides consistent padding and layout for step content.
class StepContainer extends StatelessWidget {
  /// The main content widget for the step.
  final Widget child;

  /// List of action widgets (typically buttons) displayed below content.
  final List<Widget> actions;

  /// Creates a [StepContainer].
  const StepContainer({
    super.key,
    required this.child,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: child,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: actions),
        ],
      ),
    );
  }
}
