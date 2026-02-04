import 'package:vsi_assessment/features/characters/domain/entities/character.dart';
import 'package:vsi_assessment/features/characters/domain/repositories/characters_repository.dart';

import '../datasources/character_api_service.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl({CharacterApiService? apiService})
      : _apiService = apiService ?? CharacterApiService();

  final CharacterApiService _apiService;

  @override
  Future<List<Character>> getCharacters() => _apiService.fetchCharacters();

  @override
  Future<Character?> getCharacterById(int id) =>
      _apiService.fetchCharacterById(id);
}
