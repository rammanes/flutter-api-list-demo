import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/layout/responsive_extensions.dart';

/// Use as the outer wrapper for screen body content.
class AppPageFrame extends StatelessWidget {
  const AppPageFrame({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: context.whenBreakpoint<double>(
            compact: 16,
            medium: 20,
            expanded: 32,
          ),
        );
    return SafeArea(
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );
  }
}
