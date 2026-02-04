import 'package:flutter/material.dart';

import 'package:vsi_assessment/router/app_router.dart';
import 'package:vsi_assessment/styles/app_theme.dart';

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

