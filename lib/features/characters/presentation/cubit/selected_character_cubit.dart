import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/character.dart';

/// Holds the currently selected character (e.g. for the character detail screen).

class SelectedCharacterCubit extends Cubit<Character?> {
  SelectedCharacterCubit() : super(null);

  void select(Character? character) => emit(character);
}
