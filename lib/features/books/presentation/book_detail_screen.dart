import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import '../domain/entities/book.dart';
import 'cubit/selected_book_cubit.dart';
import 'widgets/book_detail_body.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedBookCubit, Book?>(
      builder: (context, book) {
        if (book == null) {
          return AppScaffold(
            appBar: CommonAppBar(
              title: 'Book',
              automaticallyImplyLeading: true,
            ),
            body: const Center(child: Text('Book not found')),
          );
        }
        return BookDetailBody(book: book);
      },
    );
  }
}
