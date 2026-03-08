import 'package:flutter/widgets.dart';

import 'core/bootstrap/app_bootstrap.dart';
import 'core/config/app_dependencies.dart';
import 'core/config/env_config.dart';
import 'core/routing/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envConfig = await EnvConfig.load();
  final dependencies = AppDependencies.fromEnv(envConfig);
  final appRouter = AppRouter();

  runApp(
    AppBootstrap(
      dependencies: dependencies,
      router: appRouter,
    ),
  );
}
