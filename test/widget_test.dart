import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vsi_assessment/main.dart';

void main() {
  testWidgets('App builds and shows shell', (tester) async {
    await tester.pumpWidget(const VsiAssessment());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
