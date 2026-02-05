import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import '../../domain/entities/book.dart';

class BookSuggestionTile extends StatelessWidget {
  const BookSuggestionTile({
    super.key,
    required this.book,
    required this.onTap,
  });

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                book.title.capitalizeFirst(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appBarForeground,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (book.authorNames.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  book.authorNames.join(', '),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
