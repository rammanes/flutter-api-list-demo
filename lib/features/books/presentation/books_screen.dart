import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import '../data/services/book_history_service.dart';
import '../domain/entities/book.dart';
import 'cubit/books_cubit.dart';
import 'cubit/books_state.dart';
import 'cubit/selected_book_cubit.dart';
import 'widgets/book_card.dart';
import 'widgets/book_suggestion_tile.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final BookHistoryService _historyService = BookHistoryService();
  Timer? _debounceTimer;
  List<Book> _history = [];
  static const _debounceDuration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final list = await _historyService.getBooks();
      if (mounted) setState(() => _history = list);
    } catch (_) {
      if (mounted) setState(() => _history = []);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  static const int _minSearchLength = 3;

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    if (value.trim().length < _minSearchLength) return;
    _debounceTimer = Timer(_debounceDuration, () {
      if (mounted) {
        context.read<BooksCubit>().searchBooks(value);
      }
    });
  }

  Future<void> _openBook(Book book) async {
    try {
      await _historyService.addBook(book);
    } catch (_) {
      // SharedPreferences can fail (e.g. hot restart, channel not ready); still navigate.
    }
    if (!mounted) return;
    context.read<SelectedBookCubit>().select(book);
    await context.push('/books/book/${Uri.encodeComponent(book.key)}');
    if (mounted) {
      try {
        await _loadHistory();
      } catch (_) {}
    }
  }

  void _onSuggestionTap(Book book) {
    _openBook(book);
    _searchFocusNode.unfocus();
    _searchController.clear();
    context.read<BooksCubit>().clear();
  }

  Widget _buildDropdownHint(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          right: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(14),
        ),
      ),
      child: Text(
        'Type at least $_minSearchLength characters to search',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showDropdown = _searchFocusNode.hasFocus &&
        _searchController.text.trim().isNotEmpty;

    return AppScaffold(
      appBar: CommonAppBar(title: 'Books'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CommonSearchField(
              hint: 'Search books...',
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: _onSearchChanged,
              onSubmitted: (query) =>
                  context.read<BooksCubit>().searchBooks(query),
            ),
          ),
          if (showDropdown)
            _searchController.text.trim().length < _minSearchLength
                ? _buildDropdownHint(context)
                : BlocBuilder<BooksCubit, BooksState>(
              builder: (context, state) {
                if (state is BooksLoading) {
                  return const SizedBox(
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is BooksLoaded) {
                  final books = state.books;
                  if (books.isEmpty) {
                    return Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                          right: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(14),
                        ),
                      ),
                      child: Text(
                        'No books found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    );
                  }
                  return Container(
                    constraints: const BoxConstraints(maxHeight: 280),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        right: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return BookSuggestionTile(
                          book: book,
                          onTap: () => _onSuggestionTap(book),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          Expanded(
            child: BlocBuilder<BooksCubit, BooksState>(
              builder: (context, state) {
                if (state is BooksInitial) {
                  if (_history.isEmpty) {
                    return const Center(
                      child: Text('Enter a search term above'),
                    );
                  }
                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          'Recent',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      ...List.generate(
                        _history.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: BookCard(
                            book: _history[index],
                            onTap: () => _openBook(_history[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is BooksLoading && !showDropdown) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BooksLoaded) {
                  final books = state.books;
                  if (books.isEmpty && !showDropdown) {
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
                        onTap: () => _openBook(book),
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
