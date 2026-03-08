import 'package:flutter/widgets.dart';

import '../auth/session_manager.dart';
import '../network/app_http_client.dart';
import 'env_config.dart';

class AppDependencies {
  const AppDependencies({
    required this.envConfig,
    required this.httpClient,
    required this.sessionManager,
  });

  final EnvConfig envConfig;
  final AppHttpClient httpClient;
  final SessionManager sessionManager;

  factory AppDependencies.fromEnv(EnvConfig envConfig) {
    final sessionManager = SessionManager();

    return AppDependencies(
      envConfig: envConfig,
      httpClient: AppHttpClient(baseUrl: envConfig.apiBaseUrl),
      sessionManager: sessionManager,
    );
  }
}

class AppDependenciesScope extends InheritedWidget {
  const AppDependenciesScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  final AppDependencies dependencies;

  static AppDependencies of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppDependenciesScope>();
    assert(scope != null, 'AppDependenciesScope is not found in widget tree');
    return scope!.dependencies;
  }

  @override
  bool updateShouldNotify(AppDependenciesScope oldWidget) => false;
}
