import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/presentation/widgets/detail_row.dart';
import 'package:vsi_assessment/features/placeholder/presentation/widgets/meta_chip.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import '../../domain/entities/character.dart';

class CharacterDetailBody extends StatelessWidget {
  const CharacterDetailBody({super.key, required this.character});

  final Character character;

  Color _statusColor(BuildContext context) {
    final status = character.status.toLowerCase();
    if (status == 'alive') return Colors.green;
    if (status == 'dead') return Colors.redAccent;
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return AppScaffold(
      appBar: CommonAppBar(
        title: 'Character',
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => SizedBox(
                    width: 140,
                    height: 140,
                    child: Center(
                      child: Icon(Icons.person, size: 48, color: color.onSurface.withValues(alpha: 0.3)),
                    ),
                  ),
                  errorWidget: (_, __, ___) => SizedBox(
                    width: 140,
                    height: 140,
                    child: Center(
                      child: Icon(Icons.person, size: 48, color: color.onSurface.withValues(alpha: 0.3)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              character.name.capitalizeFirst(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.appBarForeground,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                MetaChip(
                  label: 'ID',
                  value: '${character.id}',
                  colorScheme: color,
                ),
                _StatusChip(status: character.status, statusColor: _statusColor(context)),
                MetaChip(
                  label: 'Species',
                  value: character.species,
                  colorScheme: color,
                ),
              ],
            ),
            if (character.type != null && character.type!.trim().isNotEmpty) ...[
              const SizedBox(height: 20),
              DetailRow(label: 'Type', value: character.type!),
            ],
            if (character.gender != null && character.gender!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              DetailRow(label: 'Gender', value: character.gender!),
            ],
            if (character.originName != null && character.originName!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              DetailRow(label: 'Origin', value: character.originName!),
            ],
            if (character.locationName != null && character.locationName!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              DetailRow(label: 'Location', value: character.locationName!),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.statusColor});

  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: statusColor,
        ),
      ),
    );
  }
}
