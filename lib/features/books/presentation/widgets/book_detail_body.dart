import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/presentation/widgets/detail_row.dart';
import 'package:vsi_assessment/features/placeholder/presentation/widgets/meta_chip.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import '../../domain/entities/book.dart';

/// Open Library cover URL by cover ID (large size for detail).
String coverUrl(int coverId, {String size = 'L'}) =>
    'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';

class BookDetailBody extends StatelessWidget {
  const BookDetailBody({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final hasCover = book.coverId != null;

    return AppScaffold(
      appBar: CommonAppBar(
        title: 'Book',
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: hasCover
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: coverUrl(book.coverId!),
                        width: 120,
                        height: 180,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _placeholderBox(context, 120, 180),
                        errorWidget: (_, __, ___) => _placeholderBox(context, 120, 180),
                      ),
                    )
                  : _placeholderBox(context, 120, 180),
            ),
            const SizedBox(height: 20),
            Text(
              book.title.capitalizeFirst(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.appBarForeground,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                MetaChip(
                  label: 'Key',
                  value: book.key,
                  colorScheme: color,
                ),
                if (book.firstPublishYear != null)
                  MetaChip(
                    label: 'Year',
                    value: '${book.firstPublishYear}',
                    colorScheme: color,
                  ),
              ],
            ),
            if (book.authorNames.isNotEmpty) ...[
              const SizedBox(height: 20),
              DetailRow(
                label: 'Authors',
                value: book.authorNames.join(', '),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _placeholderBox(BuildContext context, double width, double height) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Iconsax.book_1,
        size: 48,
        color: color.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}
