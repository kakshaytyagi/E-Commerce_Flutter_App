import 'package:flutter/material.dart';
import 'package:spikeguard/screens/cartsummary_screen.dart';
import 'package:spikeguard/screens/product_screen.dart';
import 'package:spikeguard/shared/globals.dart';

class CartItem {
  final String productName;
  final String productPrice;
  final AssetImage imageUrl;
  final String productInfo;
  int quantity;

  CartItem({
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.productInfo,
    this.quantity = 1,
  });
}

class ShoppingCart {
  bool isProductInCart(CartItem item) {
    return cartItems
        .any((cartItem) => cartItem.productName == item.productName);
  }

  void addItem(CartItem item) {
    cartItems.add(item);
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
  }

  double calculateTotalAmount() {
    double totalAmount = 0.00;

    for (var item in cartItems) {
      try {
        double price = double.tryParse(item.productPrice) ?? 0.0;
        totalAmount += price * item.quantity;
      } catch (e) {
        return 0; // Handle the exception gracefully
      }
    }
    return totalAmount;
  }
}

class ProductListingScreen extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const ProductListingScreen({Key? key, required this.shoppingCart})
      : super(key: key);

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartItemCard(
                    cartItem: cartItems[index],
                    onQuantityChanged: () {
                      // Trigger a rebuild of the widget when quantity changes
                      setState(() {});
                    },
                    onRemove: () {
                      setState(() {});
                      widget.shoppingCart.removeItem(cartItems[index]);
                    },
                  ),
                );
              },
            ),
          ),
          // Total Amount section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${widget.shoppingCart.calculateTotalAmount().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // You can customize the color
                  ),
                ),
              ],
            ),
          ),
          // Proceed to Buy button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: widget.shoppingCart.calculateTotalAmount() > 0.00
                  ? () {
                      // Navigate to the cart summary screen with the current items in the cart
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartSummaryScreen(cartItems: cartItems),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF5DA96F),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                elevation: 4.0,
              ),
              child: const Text(
                'Proceed to Buy',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String truncateProductName(String name, int maxWords) {
  List<String> words = name.split(' ');
  if (words.length > maxWords) {
    return '${words.take(maxWords).join(' ')}...';
  }
  return name;
}

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  final Function()? onQuantityChanged; // Callback for quantity change
  final Function()? onRemove; // Callback for item removal

  const CartItemCard({
    Key? key,
    required this.cartItem,
    this.onQuantityChanged,
    this.onRemove,
  }) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to ProductScreen when the card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                productName: widget.cartItem.productName,
                productImage: widget.cartItem.imageUrl,
                productInfo: widget.cartItem.productInfo,
                productPrice: widget.cartItem.productPrice,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: widget.cartItem.imageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          truncateProductName(widget.cartItem.productName, 4),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Price: ${widget.cartItem.productPrice}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.cartItem.quantity > 1) {
                              widget.cartItem.quantity--;
                              widget.onQuantityChanged
                                  ?.call(); // Trigger callback
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.cartItem.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.cartItem.quantity++;
                            widget.onQuantityChanged
                                ?.call(); // Trigger callback
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        widget.onRemove!.call(); // Trigger callback
                      });
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text('Remove'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
