import 'package:ecom_front/core/di/providers.dart';
import 'package:ecom_front/features/catalog/domain/catalog_entity.dart';
import 'package:ecom_front/features/catalog/presentation/catalog_controller.dart';
import 'package:ecom_front/features/catalog/presentation/catalog_screen.dart';
import 'package:ecom_front/features/orders/domain/orders_entity.dart';
import 'package:ecom_front/features/orders/presentation/orders_controller.dart';
import 'package:ecom_front/features/orders/presentation/orders_screen.dart';
import 'package:ecom_front/features/pricing/presentation/pricing_controller.dart';
import 'package:ecom_front/features/pricing/presentation/pricing_screen.dart';
import 'package:ecom_front/features/reports/domain/reports_entity.dart';
import 'package:ecom_front/features/reports/presentation/reports_controller.dart';
import 'package:ecom_front/features/reports/presentation/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('catalog screen renders data and supports reload', (tester) async {
    final controller = _TestCatalogController(const [CatalogEntity(id: 'cat-1')]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [catalogStateProvider.overrideWith((ref) => controller)],
        child: const MaterialApp(home: CatalogScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('catalog_list')), findsOneWidget);
    expect(find.text('Catalog item cat-1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('catalog_reload')));
    await tester.pump();

    expect(controller.reloads, 2);
  });

  testWidgets('orders screen renders error state and retry', (tester) async {
    final controller = _TestOrdersController()..state = AsyncValue.error('boom', StackTrace.current);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersStateProvider.overrideWith((ref) => controller)],
        child: const MaterialApp(home: OrdersScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('orders_error')), findsOneWidget);

    await tester.tap(find.byKey(const Key('orders_retry')));
    await tester.pump();

    expect(controller.reloads, 1);
  });

  testWidgets('pricing screen renders loading state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pricingStateProvider.overrideWith((ref) => _TestPricingController()..state = const AsyncLoading()),
        ],
        child: const MaterialApp(home: PricingScreen()),
      ),
    );

    expect(find.byKey(const Key('pricing_loading')), findsOneWidget);
  });

  testWidgets('reports screen renders data list', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          reportsStateProvider.overrideWith(
            (ref) => _TestReportsController(const [ReportsEntity(id: 'report-1')]),
          ),
        ],
        child: const MaterialApp(home: ReportsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('reports_list')), findsOneWidget);
    expect(find.text('Report report-1'), findsOneWidget);
  });
}

class _TestCatalogController extends CatalogController {
  _TestCatalogController(List<CatalogEntity> items) : _items = items, super(() async => items);

  final List<CatalogEntity> _items;
  int reloads = 0;

  @override
  Future<void> load() async {
    reloads += 1;
    state = AsyncValue.data(_items);
  }
}

class _TestOrdersController extends OrdersController {
  _TestOrdersController() : super(() async => const []);

  int reloads = 0;

  @override
  Future<void> load() async {
    reloads += 1;
  }
}

class _TestPricingController extends PricingController {
  _TestPricingController() : super(() async => const []);

  @override
  Future<void> load() async {}
}

class _TestReportsController extends ReportsController {
  _TestReportsController(List<ReportsEntity> items) : _items = items, super(() async => items);

  final List<ReportsEntity> _items;

  @override
  Future<void> load() async {
    state = AsyncValue.data(_items);
  }
}
