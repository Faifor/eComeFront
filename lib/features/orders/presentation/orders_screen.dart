import 'package:ecom_front/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  Future<void> _reload(WidgetRef ref) {
    return ref.read(ordersStateProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ordersStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            key: const Key('orders_reload'),
            onPressed: () => _reload(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(key: Key('orders_loading')),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load orders: $error', key: const Key('orders_error')),
                const SizedBox(height: 12),
                ElevatedButton(
                  key: const Key('orders_retry'),
                  onPressed: () => _reload(ref),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (items) => RefreshIndicator(
          key: const Key('orders_refresh'),
          onRefresh: () => _reload(ref),
          child: ListView.builder(
            key: const Key('orders_list'),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  key: Key('orders_item_$index'),
                  title: Text('Order ${item.id}'),
                  subtitle: Text('ID: ${item.id}'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
