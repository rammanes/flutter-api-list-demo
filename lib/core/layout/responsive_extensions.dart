import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/layout/app_breakpoints.dart';

/// Responsive helpers on [BuildContext] using [MediaQuery].
/// Use for layout decisions (e.g. single column vs side‑by‑side).
extension ResponsiveContext on BuildContext {
  /// Current screen size (same as [MediaQuery.sizeOf]).
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Current screen width.
  double get screenWidth => screenSize.width;

  /// Current screen height.
  double get screenHeight => screenSize.height;

  /// Safe area padding (insets for status bar, notch, etc.).
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Compact layout: width < 600 (phones, narrow).
  bool get isCompact => screenWidth < AppBreakpoints.compact;

  /// Medium layout: 600 <= width < 840 (tablets, large phones landscape).
  bool get isMedium =>
      screenWidth >= AppBreakpoints.compact &&
      screenWidth < AppBreakpoints.medium;

  /// Expanded layout: width >= 840 (desktop, large tablets).
  bool get isExpanded => screenWidth >= AppBreakpoints.medium;

  /// Use when you need a single responsive value (e.g. horizontal padding).
  T whenBreakpoint<T>({
    required T compact,
    required T medium,
    required T expanded,
  }) {
    if (isCompact) return compact;
    if (isMedium) return medium;
    return expanded;
  }
}
