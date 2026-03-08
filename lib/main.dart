import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/bootstrap/app_bootstrap.dart';
import 'core/config/app_dependencies.dart';
import 'core/config/env_config.dart';
import 'core/di/providers.dart';
import 'core/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envConfig = await EnvConfig.load();
  final dependencies = AppDependencies.fromEnv(envConfig);
  final appRouter = AppRouter();

  runApp(
    ProviderScope(
      overrides: [
        envConfigProvider.overrideWithValue(envConfig),
      ],
      child: AppBootstrap(
        dependencies: dependencies,
        router: appRouter,
      ),
    ),
  );
}
