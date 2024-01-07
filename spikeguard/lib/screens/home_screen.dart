import 'package:flutter/material.dart';
import 'package:spikeguard/screens/product_screen.dart';
import 'package:spikeguard/shared/globals.dart';
import 'package:spikeguard/widget/bottom_navigation.dart';
import 'dart:async';

import 'package:spikeguard/widget/contact_info.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  double? screenWidth;

  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _currentPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyTheme.largeVerticalPadding,
          const Text(
            "Hi, there!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          MyTheme.mediumVerticalPadding,
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'search_screen');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search, color: MyTheme.grey),
                    Text(
                      "Search our products",
                      style: TextStyle(color: MyTheme.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth! / 2,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                buildSliderPage(
                  title: "Advance your \ncareer now",
                  buttonText: "Catalog",
                  imagePath: 'assets/product/stabilizer.png',
                ),
                buildSliderPage(
                  title: "Explore new \nproducts",
                  buttonText: "Shop Now",
                  imagePath: 'assets/product/wall-mount.png',
                ),
                buildSliderPage(
                  title: "Check out our \nspecial deals",
                  buttonText: "View Deals",
                  imagePath: 'assets/product/phaseServo.png',
                ),
              ],
            ),
          ),
          MyTheme.largeVerticalPadding,
          Row(
            children: [
              const Text(
                "Our products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ContactInfoDialog();
                    },
                  );
                },
              ),
            ],
          ),
          GridView.count(
            childAspectRatio: 0.75,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            physics: const NeverScrollableScrollPhysics(),
            children: productData.map((product) {
              return productCard(
                productImage: product['productImage'],
                productName: product['productName'],
                productInfo: product['productInfo'],
                productPrice: product['productPrice'],
                productDetails: product['productDetails'],
                customerReview: product['customerReviews'],
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: const BottomNavBarCurvedFb1(),
    );
  }

  Widget productCard({
    required AssetImage productImage,
    required String productName,
    required String productInfo,
    required String productPrice,
    String? productDetails,
    List<Map<String, dynamic>>? customerReview,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              productName: productName,
              productImage: productImage,
              productInfo: productInfo,
              productPrice: productPrice,
              productDetails: productDetails,
              customerReviews: customerReview,
            ),
          ),
        );
      },
      child: Card(
        color: MyTheme.courseCardColor, // Corrected the color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: screenWidth! < 400 ? 3 : 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: productImage,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          productName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      productInfo,
                      style: TextStyle(fontSize: 12, color: MyTheme.grey),
                    ),
                    MyTheme.smallVerticalPadding,
                    Text(
                      productPrice,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSliderPage({
    required String title,
    required String buttonText,
    required String imagePath,
  }) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 3,
              child: Card(
                color: MyTheme.catalogueCardColor,
                child: Container(
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Image(
                alignment: Alignment.topCenter,
                image: AssetImage(imagePath),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyTheme {
  static Color get backgroundColor => const Color(0xFFF7F7F7);
  static Color get grey => const Color(0xFF999999);
  static Color get catalogueCardColor =>
      const Color(0xFFBAE5D4).withOpacity(0.5);
  static Color get catalogueButtonColor => const Color(0xFF29335C);
  static Color get courseCardColor => const Color(0xFFEDF1F1);
  static Color get progressColor => const Color(0xFF36F1CD);

  static Padding get largeVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 32.0));

  static Padding get mediumVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 16.0));

  static Padding get smallVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 8.0));

  static ThemeData get theme => ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
      ).copyWith(
        cardTheme: const CardTheme(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                catalogueButtonColor), // Button color
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Text and icon color
          ),
        ),
      );
}
