import 'package:flutter/material.dart';

import '../../shared/ui-kit/app_theme.dart';
import '../config/app_dependencies.dart';
import '../routing/app_router.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({
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
