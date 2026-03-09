import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_dependencies.dart';
import 'core/config/env_config.dart';
import 'core/di/providers.dart';
import 'core/routing/app_router.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envConfig = await EnvConfig.load();
  final dependencies = AppDependencies.fromEnv(envConfig);

  debugPrint('Running build flavor: ${envConfig.flavor.name}');

  runApp(
    ProviderScope(
      overrides: [
        envConfigProvider.overrideWithValue(envConfig),
        authAccessStateProvider.overrideWithValue(dependencies.authState),
      ],
      child: App(
        dependencies: dependencies,
        router: AppRouter(authState: dependencies.authState),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.dependencies,
    required this.router,
  });

  final AppDependencies dependencies;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return AppDependenciesScope(
      dependencies: dependencies,
      child: MaterialApp.router(
        title: 'eComeFront',
        theme: AppTheme.light(),
        routerConfig: router.config,
      ),
    );
  }
}
