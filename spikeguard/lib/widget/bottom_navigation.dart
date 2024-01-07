import 'package:flutter/material.dart';

class BottomNavBarCurvedFb1 extends StatefulWidget {
  const BottomNavBarCurvedFb1({Key? key}) : super(key: key);

  @override
  _BottomNavBarCurvedFb1State createState() => _BottomNavBarCurvedFb1State();
}

class _BottomNavBarCurvedFb1State extends State<BottomNavBarCurvedFb1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    const primaryColor = Color(0xFF5DA96F);
    const secondaryColor = Colors.black54;
    const backgroundColor = Color.fromARGB(255, 255, 255, 255);

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height + 6),
            painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              elevation: 0.1,
              onPressed: () {
                // Get the current route name
                String? currentRoute = ModalRoute.of(context)?.settings.name;

                if (currentRoute == '/') {
                } else {
                  Navigator.pushNamed(context, '/');
                }
              },
              child: const Icon(Icons.home_outlined),
            ),
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Company Profile",
                  icon: Icons.business,
                  onPressed: () {
                    Navigator.pushNamed(context, 'company_info_screen');
                  },
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                ),
                NavBarIcon(
                  text: "Search",
                  icon: Icons.search_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, 'search_screen');
                  },
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                ),
                const SizedBox(width: 56),
                NavBarIcon(
                  text: "Cart",
                  icon: Icons.local_grocery_store_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, 'cart_screen');
                  },
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                ),
                NavBarIcon(
                  text: "Calendar",
                  icon: Icons.date_range_outlined,
                  onPressed: () {},
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter({
    this.backgroundColor = Colors.white,
    this.insetRadius = 38,
  });

  Color backgroundColor;
  double insetRadius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 12);

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;
    double transitionToInsetCurveWidth = size.width * .05;
    path.quadraticBezierTo(size.width * 0.20, 0,
        insetCurveBeginnningX - transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(
        insetCurveBeginnningX, 0, insetCurveBeginnningX, insetRadius / 2);

    path.arcToPoint(
      Offset(insetCurveEndX, insetRadius / 2),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );

    path.quadraticBezierTo(
        insetCurveEndX, 0, insetCurveEndX + transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 12);
    path.lineTo(size.width, size.height + 56);
    path.lineTo(
        0,
        size.height +
            56); //+56 here extends the navbar below app bar to include extra space on some screens (iphone 11)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = Colors.black54,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            icon,
            size: 25,
            color: defaultColor,
          ),
        ),
      ],
    );
  }
}
