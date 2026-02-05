import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/network/network_error_notifier.dart';

import '../../domain/repositories/characters_repository.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this._repository) : super(const CharactersInitial());

  final CharactersRepository _repository;

  Future<void> loadCharacters() async {
    emit(const CharactersLoading());
    try {
      final characters = await _repository.getCharacters();
      networkErrorNotifier.value = false;
      emit(CharactersLoaded(characters));
    } catch (e) {
      if (isNetworkError(e)) {
        networkErrorNotifier.value = true;
        emit(CharactersError(NetworkException.from(e).message));
      } else {
        emit(CharactersError(e.toString()));
      }
    }
  }
}
