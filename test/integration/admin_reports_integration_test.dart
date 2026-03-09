import 'dart:convert';
import 'dart:io';

import 'package:ecom_front/features/admin/presentation/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('admin report filters + data loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AdminScreen(
          onApplyFilters: (_) async {
            final raw = await File('test/fixtures/admin_reports.json').readAsString();
            final payload = jsonDecode(raw) as Map<String, dynamic>;
            return (payload['rows'] as List<dynamic>).map((e) => e.toString()).toList();
          },
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('apply_filters')));
    await tester.pumpAndSettle();

    expect(find.text('Revenue: 1000'), findsOneWidget);
    expect(find.text('Orders: 15'), findsOneWidget);
  });
}
