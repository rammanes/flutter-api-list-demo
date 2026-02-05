import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
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
                CachedNetworkImage(
                  imageUrl: character.image,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _placeholderBox(context),
                  errorWidget: (_, __, ___) => _placeholderBox(context),
                ),
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
        Icons.person,
        size: 64,
        color: color.onSurface.withValues(alpha: 0.5),
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
