import 'package:flutter/material.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Characters',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
