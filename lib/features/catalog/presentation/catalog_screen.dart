import 'package:ecom_front/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  Future<void> _reload(WidgetRef ref) {
    return ref.read(catalogStateProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(catalogStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
            key: const Key('catalog_reload'),
            onPressed: () => _reload(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(key: Key('catalog_loading')),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load catalog: $error', key: const Key('catalog_error')),
                const SizedBox(height: 12),
                ElevatedButton(
                  key: const Key('catalog_retry'),
                  onPressed: () => _reload(ref),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (items) => RefreshIndicator(
          key: const Key('catalog_refresh'),
          onRefresh: () => _reload(ref),
          child: ListView.builder(
            key: const Key('catalog_list'),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  key: Key('catalog_item_$index'),
                  title: Text('Catalog item ${item.id}'),
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
