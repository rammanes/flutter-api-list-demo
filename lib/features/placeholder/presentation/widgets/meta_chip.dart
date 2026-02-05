import 'package:flutter/material.dart';

class MetaChip extends StatelessWidget {
  const MetaChip({
    super.key,
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  final String label;
  final String value;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
