import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/book.dart';

const String _key = 'book_search_history';
const int _maxHistory = 5;

class BookHistoryService {
  BookHistoryService({SharedPreferences? prefs}) : _prefs = prefs;

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Map<String, dynamic> _bookToMap(Book book) => {
        'key': book.key,
        'title': book.title,
        'authorNames': book.authorNames,
        'coverId': book.coverId,
        'firstPublishYear': book.firstPublishYear,
      };

  static Book _mapToBook(Map<String, dynamic> map) => Book(
        key: (map['key'] as String?) ?? '',
        title: (map['title'] as String?) ?? '',
        authorNames: map['authorNames'] is List<dynamic>
            ? (map['authorNames'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
            : const [],
        coverId: map['coverId'] as int?,
        firstPublishYear: map['firstPublishYear'] as int?,
      );

  /// Inserts [book] at the front of history. Removes any existing entry with the same key (no duplicates).
  /// Keeps at most [_maxHistory] items; oldest are removed.
  Future<void> addBook(Book book) async {
    final prefs = await _instance;
    final raw = prefs.getString(_key);
    final List<Map<String, dynamic>> list = raw != null
        ? (jsonDecode(raw) as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList()
        : [];
    list.removeWhere((m) => m['key'] == book.key);
    list.insert(0, _bookToMap(book));
    final toSave = list.take(_maxHistory).toList();
    await prefs.setString(_key, jsonEncode(toSave));
  }

  /// Returns the last [_maxHistory] books, most recent first.
  Future<List<Book>> getBooks() async {
    final prefs = await _instance;
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>? ?? [];
    return list
        .map((e) => _mapToBook(e as Map<String, dynamic>))
        .where((b) => b.key.isNotEmpty && b.title.isNotEmpty)
        .toList();
  }
}
