import 'package:flutter/material.dart';

class EmptyCartIllustration extends StatelessWidget {
  const EmptyCartIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/add/Open Vault.png',
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
