import 'package:ecom_front/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PricingScreen extends ConsumerWidget {
  const PricingScreen({super.key});

  Future<void> _reload(WidgetRef ref) {
    return ref.read(pricingStateProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pricingStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing'),
        actions: [
          IconButton(
            key: const Key('pricing_reload'),
            onPressed: () => _reload(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(key: Key('pricing_loading')),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load pricing: $error', key: const Key('pricing_error')),
                const SizedBox(height: 12),
                ElevatedButton(
                  key: const Key('pricing_retry'),
                  onPressed: () => _reload(ref),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (items) => RefreshIndicator(
          key: const Key('pricing_refresh'),
          onRefresh: () => _reload(ref),
          child: ListView.builder(
            key: const Key('pricing_list'),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  key: Key('pricing_item_$index'),
                  title: Text('Pricing item ${item.id}'),
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
