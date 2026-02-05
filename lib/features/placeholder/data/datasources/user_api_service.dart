import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vsi_assessment/core/constants/api_constants.dart';
import '../models/user_model.dart';

class UserApiService {
  UserApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const Map<String, String> _headers = {
    'User-Agent': 'VsiAssessment/1.0',
    'Accept': 'application/json',
  };

  Future<List<UserModel>> fetchUsers() async {
    final uri = Uri.parse(
      '${ApiConstants.jsonPlaceholderBase}${ApiConstants.usersEndpoint}',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
    return UserModel.listFromJson(response.body);
  }

  Future<UserModel?> fetchUserById(int id) async {
    final uri = Uri.parse(
      '${ApiConstants.jsonPlaceholderBase}${ApiConstants.usersEndpoint}/$id',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return UserModel.fromJson(json);
  }
}
