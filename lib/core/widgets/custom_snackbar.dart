import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:vsi_assessment/core/layout/responsive_extensions.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({
    super.key,
    required this.message,
    this.isError = false,
    this.onClose,
  });

  final String message;
  final bool isError;
  final VoidCallback? onClose;

  static void show(BuildContext context, String message, {bool isError = false}) {
    if (!context.mounted) return;

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    late AnimationController localAnimationController;

    showTopSnackBar(
      overlay,
      CustomSnackbar(
        message: message,
        isError: isError,
        onClose: () => localAnimationController.reverse(),
      ),
      onAnimationControllerInit: (controller) {
        localAnimationController = controller;
      },
      displayDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = context.isMedium || context.isExpanded;

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 24 : 16,
          vertical: isWide ? 12 : 8,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: isWide ? 40 : 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(
              isError ? Icons.error : Icons.check_circle,
              color: isError
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              size: isWide ? 32 : 28,
            ),
            SizedBox(width: isWide ? 12 : 8),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: isWide ? 16 : 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onClose != null)
              GestureDetector(
                onTap: onClose,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: isWide ? 12 : 8),
                  child: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    size: isWide ? 24 : 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
