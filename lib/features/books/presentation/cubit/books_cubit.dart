import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/network/network_error_notifier.dart';

import '../../domain/repositories/books_repository.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit(this._repository) : super(const BooksInitial());

  final BooksRepository _repository;

  /// Open Library search returns 422 for very short queries; require at least 3 characters.
  static const int _minSearchLength = 3;

  Future<void> searchBooks(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty || trimmed.length < _minSearchLength) {
      networkErrorNotifier.value = false;
      emit(const BooksLoaded([]));
      return;
    }
    emit(const BooksLoading());
    try {
      final books = await _repository.searchBooks(trimmed);
      networkErrorNotifier.value = false;
      emit(BooksLoaded(books));
    } catch (e) {
      if (isNetworkError(e)) {
        networkErrorNotifier.value = true;
        emit(BooksError(NetworkException.from(e).message));
      } else {
        emit(BooksError(e.toString()));
      }
    }
  }

  void clear() {
    emit(const BooksInitial());
  }
}
