import '../entities/character.dart';

abstract class CharactersRepository {
  Future<List<Character>> getCharacters();
  Future<Character?> getCharacterById(int id);
}
