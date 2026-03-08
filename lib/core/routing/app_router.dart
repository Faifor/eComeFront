import 'package:flutter/material.dart';

import '../../shared/widgets/app_home_screen.dart';

class AppRouter {
  late final RouterConfig<Object> config = RouterConfig<Object>(
    routerDelegate: _delegate,
    routeInformationParser: _parser,
  );

  final _delegate = _SimpleRouterDelegate();
  final _parser = _SimpleRouteParser();
}

class _SimpleRouteParser extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return Object();
  }
}

class _SimpleRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: const [
        MaterialPage<void>(child: AppHomeScreen()),
      ],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {}
}
