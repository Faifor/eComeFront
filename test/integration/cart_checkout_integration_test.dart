import 'package:ecom_front/features/cart/presentation/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cart + checkout flow basic interaction', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (_) => const CartScreen(unitPrice: 25),
          '/checkout': (_) => const Scaffold(body: Center(child: Text('Checkout screen'))),
        },
      ),
    );

    await tester.tap(find.byKey(const Key('qty_increment')));
    await tester.pump();
    expect(find.text('Total: \$50'), findsOneWidget);

    Navigator.of(tester.element(find.byType(CartScreen))).pushNamed('/checkout');
    await tester.pumpAndSettle();
    expect(find.text('Checkout screen'), findsOneWidget);
  });
}
