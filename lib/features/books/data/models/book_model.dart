import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.key,
    required super.title,
    super.authorNames,
    super.coverId,
    super.firstPublishYear,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final authorNames = json['author_name'];
    return BookModel(
      key: (json['key'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      authorNames: authorNames is List<dynamic>
          ? authorNames.map((e) => e.toString()).toList()
          : const [],
      coverId: json['cover_i'] as int?,
      firstPublishYear: json['first_publish_year'] as int?,
    );
  }

  static List<BookModel> listFromDocs(List<dynamic> docs) {
    return docs
        .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
