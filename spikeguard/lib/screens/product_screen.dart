import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spikeguard/screens/cart_screen.dart';
import 'package:spikeguard/shared/globals.dart';

class ProductScreen extends StatefulWidget {
  final String productName;
  final AssetImage productImage;
  final String productInfo;
  final String productPrice;
  final String? productDetails;
  final List<Map<String, dynamic>>? customerReviews;

  const ProductScreen({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productInfo,
    required this.productPrice,
    this.productDetails,
    this.customerReviews,
  }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListingScreen(
                    shoppingCart: shoppingCart,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              showShareDialog();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 35,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: widget.productImage,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 65,
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.productInfo,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            widget.productPrice,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Learn the basics of lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (!shoppingCart.isProductInCart(CartItem(
                                  imageUrl: widget.productImage,
                                  productName: widget.productName,
                                  productPrice: widget.productPrice,
                                  productInfo: widget.productInfo,
                                ))) {
                                  setState(() {
                                    shoppingCart.addItem(CartItem(
                                      imageUrl: widget.productImage,
                                      productName: widget.productName,
                                      productPrice: widget.productPrice,
                                      productInfo: widget.productInfo,
                                    ));
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Item added to cart'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Item is already in the cart'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text("Add to Cart"),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement other actions or navigate to other screens
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text("Buy Now"),
                            ),
                          ),
                        ],
                      ),
const SizedBox(height: 16),
                      if (widget.productDetails != null)
                        buildSection(
                          "Product Details",
                          widget.productDetails!,
                        ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      const SizedBox(height: 16),
                      if (widget.customerReviews != null)
                        buildSection(
                          "Customer Reviews",
                          buildReviewsList(widget.customerReviews!),
                        ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
  ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

Widget buildSection(String title, dynamic content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (content is String)
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        if (content is Widget) content,
      ],
    );
  }

Widget buildReviewItem(int rating, String reviewText) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Row(
          children: [
            RatingBar.builder(
              initialRating: rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double value) {
                // You can handle rating updates if needed
              },
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            reviewText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black, // Set the appropriate text color
            ),
          ),
        ),
      ),
    );
  }

Widget buildReviewsList(List<Map<String, dynamic>> reviews) {
    return Column(
      children: reviews.map((review) {
        return buildReviewItem(
          review['rating'] ??
              0, 
          review['comment'] ?? '',
        );
      }).toList(),
    );
  }

  Future<void> showShareDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share this product',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Display the image in the share dialog
              Image(image: widget.productImage, height: 100, width: 100),

              const SizedBox(height: 16),
              Text(
                widget.productName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.productInfo,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _shareProduct();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _shareProduct() async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final List<String> textToShare = [
      'Check out this product:',
      'Name: ${widget.productName}',
      'Details: ${widget.productInfo}',
      'Price: ${widget.productPrice}',
    ];

    await Share.share(
      textToShare.join('\n'),
      subject: widget.productName,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}