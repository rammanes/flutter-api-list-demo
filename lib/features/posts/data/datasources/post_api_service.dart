import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vsi_assessment/core/constants/api_constants.dart';
import '../models/post_model.dart';

class PostApiService {
  PostApiService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  static const Map<String, String> _headers = {
    'User-Agent': 'VsiAssessment/1.0',
    'Accept': 'application/json',
  };

  Future<List<PostModel>> fetchPosts() async {
    final uri = Uri.parse(
      '${ApiConstants.jsonPlaceholderBase}${ApiConstants.postsEndpoint}',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
    return PostModel.listFromJson(response.body);
  }

  Future<PostModel?> fetchPostById(int id) async {
    final uri = Uri.parse(
      '${ApiConstants.jsonPlaceholderBase}${ApiConstants.postsEndpoint}/$id',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw Exception('Failed to load post: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PostModel.fromJson(json);
  }
}
