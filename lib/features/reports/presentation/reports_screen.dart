import 'package:ecom_front/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  Future<void> _reload(WidgetRef ref) {
    return ref.read(reportsStateProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            key: const Key('reports_reload'),
            onPressed: () => _reload(ref),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(key: Key('reports_loading')),
        ),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load reports: $error', key: const Key('reports_error')),
                const SizedBox(height: 12),
                ElevatedButton(
                  key: const Key('reports_retry'),
                  onPressed: () => _reload(ref),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (items) => RefreshIndicator(
          key: const Key('reports_refresh'),
          onRefresh: () => _reload(ref),
          child: ListView.builder(
            key: const Key('reports_list'),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  key: Key('reports_item_$index'),
                  title: Text('Report ${item.id}'),
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
