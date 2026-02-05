import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import 'cubit/characters_cubit.dart';
import 'cubit/characters_state.dart';
import 'widgets/character_card.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CommonAppBar(title: 'Characters'),
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersInitial || state is CharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CharactersLoaded) {
            final characters = state.characters;
            return ListView.separated(
              itemCount: characters.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCard(
                  character: character,
                  onTap: () {},
                );
              },
            );
          }
          if (state is CharactersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        context.read<CharactersCubit>().loadCharacters(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

