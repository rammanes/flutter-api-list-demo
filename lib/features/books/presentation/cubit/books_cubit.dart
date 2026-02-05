import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/network/network_error_notifier.dart';

import '../../domain/repositories/books_repository.dart';
import 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit(this._repository) : super(const BooksInitial());

  final BooksRepository _repository;

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      networkErrorNotifier.value = false;
      emit(const BooksLoaded([]));
      return;
    }
    emit(const BooksLoading());
    try {
      final books = await _repository.searchBooks(query.trim());
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
