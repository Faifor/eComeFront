import 'package:ecom_front/core/config/app_dependencies.dart';
import 'package:ecom_front/core/config/env_config.dart';
import 'package:ecom_front/core/di/providers.dart';
import 'package:ecom_front/core/routing/app_router.dart';
import 'package:ecom_front/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App starts with login route', (WidgetTester tester) async {
    const envConfig = EnvConfig(
      apiBaseUrl: 'http://localhost:8000',
      environment: 'dev',
      flavor: BuildFlavor.dev,
    );

    final dependencies = AppDependencies.fromEnv(envConfig);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          envConfigProvider.overrideWithValue(envConfig),
        ],
        child: App(
          dependencies: dependencies,
          router: AppRouter(authState: dependencies.authState),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login screen'), findsOneWidget);
  });
}
