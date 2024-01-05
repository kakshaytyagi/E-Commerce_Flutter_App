import 'package:flutter/material.dart';
import 'package:spikeguard/screens/cart_screen.dart';

ShoppingCart shoppingCart = ShoppingCart();

List<CartItem> cartItems = [];

final List<Map<String, dynamic>> productData = [
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "VOLTAGE STABILIZER",
    'productInfo': "Digital & Intelligent Time Delay System",
    'productPrice': "8500.01",
    'productDetails':
        "High-quality voltage stabilizer suitable for home appliances.",
    'customerReviews': [
      {'rating': 4, 'comment': 'Great product! Works as expected.'},
      {'rating': 5, 'comment': 'Excellent build quality.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "1.5 ton VOLTAGE STABILIZER Inverter AC",
    'productInfo': "Digital & Intelligent Time Delay System",
    'productPrice': "8500.01",
    'productDetails':
        "Designed for inverter AC units, providing stable voltage for optimal performance.",
    'customerReviews': [
      {'rating': 5, 'comment': 'Perfect for my inverter AC.'},
      {'rating': 4, 'comment': 'Easy to install and use.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "Basic HTML for Dummies",
    'productInfo': "Estimated 6 weeks",
    'productPrice': "4.89",
    'productDetails': "A beginner-friendly guide to HTML programming.",
    'customerReviews': [
      {'rating': 4, 'comment': 'Helped me understand HTML basics.'},
      {'rating': 5, 'comment': 'Well-written and easy to follow.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "Introduction to Bitcoin",
    'productInfo': "Estimated 11 weeks",
    'productPrice': "6.49",
    'productDetails': "Learn the fundamentals of Bitcoin and cryptocurrency.",
    'customerReviews': [
      {'rating': 5, 'comment': 'Informative and well-researched.'},
      {'rating': 4, 'comment': 'Great introduction to the world of Bitcoin.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "The Internet of Things",
    'productInfo': "Estimated 10 weeks",
    'productPrice': "6.49",
    'productDetails':
        "Explore the concept and applications of the Internet of Things (IoT).",
    'customerReviews': [
      {'rating': 4, 'comment': 'Fascinating insights into IoT technology.'},
      {'rating': 5, 'comment': 'Must-read for anyone interested in IoT.'},
    ],
  },
];

class Address {
  String fullName;
  String mobileNumber;
  String flatHouseBuilding;
  String areaStreetVillage;
  String landmark;
  String pincode;
  String townCity;
  String selectedState;
  bool makeDefaultAddress;
  String deliveryInstructions;

  Address({
    required this.fullName,
    required this.mobileNumber,
    required this.flatHouseBuilding,
    required this.areaStreetVillage,
    required this.landmark,
    required this.pincode,
    required this.townCity,
    required this.selectedState,
    required this.makeDefaultAddress,
    required this.deliveryInstructions,
  });

  // Method to generate a formatted string of the complete address
  String getFormattedAddress() {
    return "$fullName\n$mobileNumber\n$flatHouseBuilding, $areaStreetVillage,\n $landmark, $townCity,\n $selectedState - $pincode";
  }
}
