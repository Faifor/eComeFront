import 'package:ecom_front/core/validation/input_validators.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key, this.onApplyFilters});

  final Future<List<String>> Function(Map<String, dynamic> filters)? onApplyFilters;

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _dateFromController = TextEditingController(text: '2024-01-01');
  final _dateToController = TextEditingController(text: '2024-01-31');
  final _minTotalController = TextEditingController(text: '0');

  bool _isLoading = false;
  String? _error;
  List<String> _rows = const [];

  @override
  void dispose() {
    _dateFromController.dispose();
    _dateToController.dispose();
    _minTotalController.dispose();
    super.dispose();
  }

  Future<void> _applyFilters() async {
    final filters = <String, dynamic>{
      'dateFrom': _dateFromController.text,
      'dateTo': _dateToController.text,
      'minTotal': _minTotalController.text,
    };

    final validationError = InputValidators.validateFilters(filters);
    if (validationError != null) {
      setState(() {
        _error = validationError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final rows = await widget.onApplyFilters?.call(filters) ?? const <String>[];
    if (!mounted) {
      return;
    }

    setState(() {
      _rows = rows;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin reports')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('filter_date_from'),
              controller: _dateFromController,
              decoration: const InputDecoration(labelText: 'Date from'),
            ),
            TextField(
              key: const Key('filter_date_to'),
              controller: _dateToController,
              decoration: const InputDecoration(labelText: 'Date to'),
            ),
            TextField(
              key: const Key('filter_min_total'),
              controller: _minTotalController,
              decoration: const InputDecoration(labelText: 'Min total'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              key: const Key('apply_filters'),
              onPressed: _isLoading ? null : _applyFilters,
              child: _isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Apply filters'),
            ),
            if (_error != null) Text(_error!, key: const Key('filters_error')),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                key: const Key('reports_list'),
                children: _rows.map((row) => ListTile(title: Text(row))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
