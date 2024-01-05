import 'package:flutter/material.dart';

class EmptyCartIllustration extends StatelessWidget {
  const EmptyCartIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Illustrations%20Icons%2FOpen%20Vault.png?alt=media&token=745a7f73-83c9-41f2-b5d4-04cd81fd0afe",
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 1),
        const Text(
          'Your cart is empty!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Explore our products and add items to your cart to proceed.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

