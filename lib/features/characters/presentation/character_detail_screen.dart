import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import '../domain/entities/character.dart';
import 'cubit/selected_character_cubit.dart';
import 'widgets/character_detail_body.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCharacterCubit, Character?>(
      builder: (context, character) {
        if (character == null) {
          return AppScaffold(
            appBar: CommonAppBar(
              title: 'Character',
              automaticallyImplyLeading: true,
            ),
            body: const Center(child: Text('Character not found')),
          );
        }
        return CharacterDetailBody(character: character);
      },
    );
  }
}
