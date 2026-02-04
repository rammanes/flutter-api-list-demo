import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vsi_assessment/core/constants/api_constants.dart';
import '../models/book_model.dart';

class BookApiService {
  BookApiService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<BookModel>> searchBooks(String query) async {
    if (query.trim().isEmpty) return [];
    final uri = Uri.parse(
      '${ApiConstants.openLibraryBase}${ApiConstants.searchEndpoint}',
    ).replace(queryParameters: {'q': query.trim()});
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to search books: ${response.statusCode}');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final docs = json['docs'] as List<dynamic>? ?? [];
    return BookModel.listFromDocs(docs);
  }
}
