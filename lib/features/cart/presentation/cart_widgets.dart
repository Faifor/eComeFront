import 'package:flutter/material.dart';

class CartPlaceholderTile extends StatelessWidget {
  const CartPlaceholderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(title: Text('Cart item'));
  }
}
