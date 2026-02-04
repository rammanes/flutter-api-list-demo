import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Books',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
