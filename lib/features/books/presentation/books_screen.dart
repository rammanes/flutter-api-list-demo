import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import 'cubit/books_cubit.dart';
import 'cubit/books_state.dart';
import 'cubit/selected_book_cubit.dart';
import 'widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CommonAppBar(title: 'Books'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CommonSearchField(
              hint: 'Search books...',
              onSubmitted: (query) =>
                  context.read<BooksCubit>().searchBooks(query),
            ),
          ),
          Expanded(
            child: BlocBuilder<BooksCubit, BooksState>(
              builder: (context, state) {
                if (state is BooksInitial) {
                  return const Center(
                    child: Text('Enter a search term above'),
                  );
                }
                if (state is BooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BooksLoaded) {
                  final books = state.books;
                  if (books.isEmpty) {
                    return const Center(child: Text('No books found'));
                  }
                  return ListView.separated(
                    itemCount: books.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookCard(
                        book: book,
                        onTap: () {
                          context.read<SelectedBookCubit>().select(book);
                          context.push(
                            '/books/book/${Uri.encodeComponent(book.key)}',
                          );
                        },
                      );
                    },
                  );
                }
                if (state is BooksError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () => context.read<BooksCubit>().clear(),
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

