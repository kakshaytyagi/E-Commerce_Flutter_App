import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseHistory {
  final String? userId; // Change to allow null
  final String? orderId; // Add orderId field
  final List<Map<String, dynamic>> items;
  final double totalAmount;
  final Timestamp purchaseDate;
  final bool orderCompleted;

  PurchaseHistory({
    required this.items,
    required this.totalAmount,
    required this.purchaseDate,
    required this.orderCompleted,
    this.userId,
    this.orderId, // Add orderId to the constructor
  });
}
