import 'package:ecom_front/features/cart/presentation/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cart qty changes and total recalculates', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartScreen(unitPrice: 25)));

    expect(find.text('Total: \$25'), findsOneWidget);

    await tester.tap(find.byKey(const Key('qty_increment')));
    await tester.pump();

    expect(find.byKey(const Key('qty_value')), findsOneWidget);
    expect(find.text('Total: \$50'), findsOneWidget);
  });
}
