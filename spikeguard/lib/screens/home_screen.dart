import 'package:flutter/material.dart';
import 'package:spikeguard/screens/product_screen.dart';
import 'package:spikeguard/shared/globals.dart';
import 'package:spikeguard/widget/advertisment_slider.dart';
import 'package:spikeguard/widget/bottom_navigation.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  double? screenWidth;

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
            "Hi, Daria!",
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
            child: const CatalogSlider(),
          ),
          MyTheme.largeVerticalPadding,
          const Row(
            children: [
              Text(
                "Trending products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.tune)
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
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBarCurvedFb1(),
    );
  }

  Widget productCard({
    required AssetImage productImage,
    required String productName,
    required String productInfo,
    required String productPrice,
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
