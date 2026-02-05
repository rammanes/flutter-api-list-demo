import 'package:equatable/equatable.dart';

import '../../domain/entities/character.dart';

sealed class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

final class CharactersInitial extends CharactersState {
  const CharactersInitial();
}

final class CharactersLoading extends CharactersState {
  const CharactersLoading();
}

final class CharactersLoaded extends CharactersState {
  const CharactersLoaded(this.characters);

  final List<Character> characters;

  @override
  List<Object?> get props => [characters];
}

final class CharactersError extends CharactersState {
  const CharactersError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
