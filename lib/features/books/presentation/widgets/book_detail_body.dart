import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
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
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                hasCover
                    ? CachedNetworkImage(
                        imageUrl: coverUrl(book.coverId!),
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _placeholderBox(context),
                        errorWidget: (_, __, ___) => _placeholderBox(context),
                      )
                    : _placeholderBox(context),
                Positioned(
                  top: topPadding,
                  left: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => context.pop(),
                      color: Colors.white,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderBox(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color.onSurface.withValues(alpha: 0.08),
      child: Icon(
        Iconsax.book_1,
        size: 64,
        color: color.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}
