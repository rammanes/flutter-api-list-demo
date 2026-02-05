import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/utils/text_format_utils.dart';
import 'package:vsi_assessment/styles/app_colors.dart';

import '../../domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  final Character character;
  final VoidCallback onTap;

  bool get _isAlive =>
      character.status.toLowerCase() == 'alive';

  Color _statusDotColor(BuildContext context) {
    final status = character.status.toLowerCase();
    if (status == 'alive') return Colors.green;
    if (status == 'dead') return Colors.redAccent;
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final baseColor = _isAlive
        ? color.onSurface
        : color.onSurface.withValues(alpha: 0.5);

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
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                    width: 44,
                    height: 44,
                    child: Center(child: Icon(Icons.person)),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox(
                    width: 44,
                    height: 44,
                    child: Center(child: Icon(Icons.person)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            character.name.capitalizeFirst(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.appBarForeground,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _statusDotColor(context),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      character.species,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: baseColor.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _subtitleLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: baseColor.withValues(alpha: 0.55),
                      ),
                    ),
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

  String get _subtitleLine {
    final parts = <String>[];
    if (character.originName != null &&
        character.originName!.trim().isNotEmpty) {
      parts.add(character.originName!);
    }
    if (character.locationName != null &&
        character.locationName!.trim().isNotEmpty) {
      parts.add(character.locationName!);
    }
    return parts.isEmpty ? character.status : parts.join(' · ');
  }
}
