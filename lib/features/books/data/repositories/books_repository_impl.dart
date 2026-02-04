import 'package:vsi_assessment/features/books/domain/entities/book.dart';
import 'package:vsi_assessment/features/books/domain/repositories/books_repository.dart';

import '../datasources/book_api_service.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl({BookApiService? apiService})
      : _apiService = apiService ?? BookApiService();

  final BookApiService _apiService;

  @override
  Future<List<Book>> searchBooks(String query) =>
      _apiService.searchBooks(query);
}
