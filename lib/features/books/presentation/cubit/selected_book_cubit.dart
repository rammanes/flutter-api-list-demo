import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/book.dart';

/// Holds the currently selected book (e.g. for the book detail screen).
class SelectedBookCubit extends Cubit<Book?> {
  SelectedBookCubit() : super(null);

  void select(Book? book) => emit(book);
}
