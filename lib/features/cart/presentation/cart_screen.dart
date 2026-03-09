import 'package:ecom_front/core/validation/input_validators.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.unitPrice = 25});

  final int unitPrice;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final total = _quantity * widget.unitPrice;
    final validationMessage = InputValidators.validateQuantity(_quantity);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  key: const Key('qty_decrement'),
                  onPressed: () {
                    setState(() => _quantity = (_quantity - 1).clamp(0, 999));
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('Qty: $_quantity', key: const Key('qty_value')),
                IconButton(
                  key: const Key('qty_increment'),
                  onPressed: () {
                    setState(() => _quantity = (_quantity + 1).clamp(0, 999));
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            if (validationMessage != null)
              Text(validationMessage, key: const Key('qty_error')),
            const SizedBox(height: 12),
            Text('Total: \$${total.toStringAsFixed(0)}', key: const Key('cart_total')),
          ],
        ),
      ),
    );
  }
}
