// purchase_history_screen.dart

import 'package:flutter/material.dart';
import 'package:spikeguard/screens/cart_screen.dart'; // Import the CartItem model

class PurchaseHistoryScreen extends StatelessWidget {
  final List<List<CartItem>> purchaseHistory;

  const PurchaseHistoryScreen({Key? key, required this.purchaseHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
      ),
      body: ListView.builder(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          return _buildPurchaseHistoryCard(purchaseHistory[index]);
        },
      ),
    );
  }

  Widget _buildPurchaseHistoryCard(List<CartItem> purchaseItems) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Purchase Date: ${DateTime.now().toString()}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DataTable(
              columns: const [
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Price')),
              ],
              rows: purchaseItems.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item.productName)),
                  DataCell(Text(item.quantity.toString())),
                  DataCell(Text(item.productPrice)),
                ]);
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Amount: ${_calculateTotalAmount(purchaseItems)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTotalAmount(List<CartItem> items) {
    double total = 0;
    for (var item in items) {
      total += double.parse(item.productPrice) * item.quantity;
    }
    return total.toStringAsFixed(2);
  }
}
