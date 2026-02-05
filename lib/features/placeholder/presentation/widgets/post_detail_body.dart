import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/domain/entities/post.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import 'meta_chip.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return AppScaffold(
      appBar: CommonAppBar(
        title: 'Post',
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toTitleCase(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.appBarForeground,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                MetaChip(
                  label: 'ID',
                  value: '${post.id}',
                  colorScheme: color,
                ),
                const SizedBox(width: 8),
                MetaChip(
                  label: 'User',
                  value: '${post.userId}',
                  colorScheme: color,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              post.body.isEmpty ? '—' : post.body,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: color.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
