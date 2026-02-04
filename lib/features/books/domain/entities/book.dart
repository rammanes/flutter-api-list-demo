import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.key,
    required this.title,
    this.authorNames = const [],
    this.coverId,
    this.firstPublishYear,
  });

  final String key;
  final String title;
  final List<String> authorNames;
  final int? coverId;
  final int? firstPublishYear;

  @override
  List<Object?> get props => [key, title, authorNames, coverId, firstPublishYear];
}
