import 'package:flutter/material.dart';

import '../core/layout/app_page_frame.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPageFrame(
        child: Center(
          child: Text(
            'Hello World',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
