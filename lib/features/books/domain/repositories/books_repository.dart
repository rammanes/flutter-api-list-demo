import '../entities/book.dart';

abstract class BooksRepository {
  Future<List<Book>> searchBooks(String query);
}
