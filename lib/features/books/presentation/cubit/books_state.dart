import 'package:equatable/equatable.dart';

import '../../domain/entities/book.dart';

sealed class BooksState extends Equatable {
  const BooksState();

  @override
  List<Object?> get props => [];
}

final class BooksInitial extends BooksState {
  const BooksInitial();
}

final class BooksLoading extends BooksState {
  const BooksLoading();
}

final class BooksLoaded extends BooksState {
  const BooksLoaded(this.books);

  final List<Book> books;

  @override
  List<Object?> get props => [books];
}

final class BooksError extends BooksState {
  const BooksError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
