import 'dart:async';

import 'package:ecom_front/features/auth/presentation/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login screen validates and shows submit state', (tester) async {
    final completer = Completer<void>();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthScreen(
          onSubmit: (_, __) async {
            await completer.future;
          },
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('login_submit')));
    await tester.pump();
    expect(find.text('Enter valid email'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('login_email')), 'user@test.com');
    await tester.enterText(find.byKey(const Key('login_password')), 'secret1');
    await tester.tap(find.byKey(const Key('login_submit')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete();
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
