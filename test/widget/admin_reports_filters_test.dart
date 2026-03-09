import 'package:ecom_front/features/admin/presentation/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('admin reports filters validate and load data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AdminScreen(
          onApplyFilters: (_) async => const ['Revenue: 1000', 'Orders: 15'],
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('filter_date_from')), '2024-02-01');
    await tester.enterText(find.byKey(const Key('filter_date_to')), '2024-01-01');
    await tester.tap(find.byKey(const Key('apply_filters')));
    await tester.pump();
    expect(find.byKey(const Key('filters_error')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('filter_date_from')), '2024-01-01');
    await tester.enterText(find.byKey(const Key('filter_date_to')), '2024-02-01');
    await tester.tap(find.byKey(const Key('apply_filters')));
    await tester.pumpAndSettle();

    expect(find.text('Revenue: 1000'), findsOneWidget);
    expect(find.text('Orders: 15'), findsOneWidget);
  });
}
