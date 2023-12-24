import 'package:flutter/material.dart';
import 'package:spikeguard/screens/cart_screen.dart';

ShoppingCart shoppingCart = ShoppingCart();

List<CartItem> cartItems = [];

final List<Map<String, dynamic>> productData = [
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "AC",
    'productInfo': "Digital & Intelligent Time Delay System",
    'productPrice': "8500.01",
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "1.5 ton VOLTAGE STABILIZER Inverter AC",
    'productInfo': "Digital & Intelligent Time Delay System",
    'productPrice': "8500.01",
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "Basic HTML for Dummies",
    'productInfo': "Estimated 6 weeks",
    'productPrice': "4.89",
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "Introduction to Bitcoin",
    'productInfo': "Estimated 11 weeks",
    'productPrice': "6.49",
  },
  {
    'productImage': const AssetImage('assets/product/stabilizer.png'),
    'productName': "The Internet of Things",
    'productInfo': "Estimated 10 weeks",
    'productPrice': "6.49",
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