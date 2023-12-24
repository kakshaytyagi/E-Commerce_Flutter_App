import 'dart:async';
import 'package:flutter/material.dart';

class CatalogSlider extends StatefulWidget {
  const CatalogSlider({Key? key}) : super(key: key);

  @override
  _CatalogSliderState createState() => _CatalogSliderState();
}

class _CatalogSliderState extends State<CatalogSlider> {
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
    return PageView(
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
          imagePath: 'assets/product/vmsd-500.png',
        ),
        buildSliderPage(
          title: "Check out our \nspecial deals",
          buttonText: "View Deals",
          imagePath: 'assets/product/stabilizer.png',
        ),
      ],
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
  static Color get catalogueCardColor =>
      const Color(0xFFBAE5D4).withOpacity(0.5);
}
