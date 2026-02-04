import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vsi_assessment/core/constants/api_constants.dart';
import '../models/character_model.dart';

class CharacterApiService {
  CharacterApiService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<CharacterModel>> fetchCharacters() async {
    final uri = Uri.parse(
      '${ApiConstants.rickAndMortyBase}${ApiConstants.charactersEndpoint}',
    );
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load characters: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final results = json['results'] as List<dynamic>? ?? [];
    return CharacterModel.listFromJson(results);
  }

  Future<CharacterModel?> fetchCharacterById(int id) async {
    final uri = Uri.parse(
      '${ApiConstants.rickAndMortyBase}${ApiConstants.charactersEndpoint}/$id',
    );
    final response = await _client.get(uri);
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw Exception('Failed to load character: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return CharacterModel.fromJson(json);
  }
}
