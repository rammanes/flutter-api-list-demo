import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/domain/entities/user.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import 'detail_row.dart';
import 'meta_chip.dart';

class UserDetailBody extends StatelessWidget {
  const UserDetailBody({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return AppScaffold(
      appBar: CommonAppBar(
        title: 'User',
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name.capitalizeFirst(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.appBarForeground,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                MetaChip(
                  label: 'ID',
                  value: '${user.id}',
                  colorScheme: color,
                ),
                const SizedBox(width: 8),
                if (user.username.isNotEmpty)
                  MetaChip(
                    label: '@',
                    value: user.username,
                    colorScheme: color,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            DetailRow(
              label: 'Email',
              value: user.email.isEmpty ? '—' : user.email,
            ),
            if (user.phone != null && user.phone!.isNotEmpty) ...[
              const SizedBox(height: 12),
              DetailRow(
                label: 'Phone',
                value: user.phone!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
