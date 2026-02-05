import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import '../../domain/entities/book.dart';

/// Open Library cover URL by cover ID (medium size).
String _coverUrl(int coverId) =>
    'https://covers.openlibrary.org/b/id/$coverId-M.jpg';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final hasCover = book.coverId != null;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        highlightColor: color.primary.withValues(alpha: 0.02),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            children: [
              _buildLeading(context, color, hasCover),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      book.title.capitalizeFirst(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBarForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.authorNames.isEmpty
                          ? 'Unknown author'
                          : book.authorNames.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: color.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                    if (book.firstPublishYear != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${book.firstPublishYear}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: color.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context, ColorScheme color, bool hasCover) {
    const double width = 36;
    const double height = 44;

    if (hasCover) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: _coverUrl(book.coverId!),
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (_, __) => _placeholderBox(color, width, height),
          errorWidget: (_, __, ___) => _placeholderBox(color, width, height),
        ),
      );
    }

    return _placeholderBox(color, width, height);
  }

  Widget _placeholderBox(ColorScheme color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        Iconsax.book_1,
        size: 22,
        color: color.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}
