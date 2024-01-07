import 'package:flutter/material.dart';
import 'package:spikeguard/screens/cart_screen.dart';

ShoppingCart shoppingCart = ShoppingCart();

List<CartItem> cartItems = [];

List<CartItem> buyItems = [];

final List<Map<String, dynamic>> productData = [
  {
    "productImage": AssetImage('assets/product/stabilizer.png'),
    "productName": "1.5-ton VOLTAGE STABILIZER",
    "productInfo": "Inverter AC | Digital & Intelligent Time Delay System",
    "productPrice": "8500.00",
    "productDetails": '''
  \u2022 1 PHASE VOLTAGE STABILIZER
  \u2022 100% COPPER
  \u2022 WIDE WORKING RANGE: 90V - 280V
  \u2022 HIGH VOLTAGE CUT OFF
  \u2022 LOW VOLTAGE CUT OFF
  \u2022 INITIAL TIME DELAY
  \u2022 FULLY AUTOMATIC
''',
    "customerReviews": [
      {"rating": 4, "comment": "Great product! Works as expected."},
      {"rating": 5, "comment": "Excellent build quality."},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/phaseServo.png'),
    'productName': "5KVA SERVO STABILIZER (1 PHASE)",
    'productInfo': "Digital & Intelligent Time Delay System",
    'productPrice': "8500.00",
    'productDetails':
        "Designed for inverter AC units, providing stable voltage for optimal performance.",
    'customerReviews': [
      {'rating': 5, 'comment': 'Perfect for my inverter AC.'},
      {'rating': 4, 'comment': 'Easy to install and use.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/mainline.png'),
    'productName': "5KVA MAIN LINE STABILIZER",
    'productInfo': "Estimated 6 weeks",
    'productPrice': "4.89",
    'productDetails': "A beginner-friendly guide to HTML programming.",
    'customerReviews': [
      {'rating': 4, 'comment': 'Helped me understand HTML basics.'},
      {'rating': 5, 'comment': 'Well-written and easy to follow.'},
    ],
  },
  {
    'productImage': const AssetImage('assets/product/wall-mount.png'),
    'productName': "10KVA WALL MOUNT ( NEW MODEL)",
    'productInfo': "Estimated 11 weeks",
    'productPrice': "6.49",
    'productDetails': "Learn the fundamentals of Bitcoin and cryptocurrency.",
    'customerReviews': [
      {'rating': 5, 'comment': 'Informative and well-researched.'},
      {'rating': 4, 'comment': 'Great introduction to the world of Bitcoin.'},
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
