import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'styles/app_theme.dart';

void main() {
  runApp(const VsiAssessment());
}

class VsiAssessment extends StatelessWidget {
  const VsiAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VsiAssessment',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}

