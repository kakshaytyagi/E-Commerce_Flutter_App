import 'package:flutter/material.dart';

class OwnerInfoScreen extends StatelessWidget {
  const OwnerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 1,
      minChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Set your preferred background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Owner Name

                  const SizedBox(height: 16.0),

                  // Owner Image
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage(
                        'assets/add/owner.jpg'), // Replace with the actual image asset path
                  ),

                  const SizedBox(height: 16.0),

                  const Text(
                    'Gaurav Tyagi', // Replace with the actual owner's name
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set your preferred text color
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Words of Wisdom\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text:
                              '"In the journey of life, dedication and passion become the driving forces behind our success. '
                              'Our commitment to excellence is unwavering, ensuring that every product we offer reflects the pinnacle of quality. '
                              'Challenges are not roadblocks; they are opportunities for growth and innovation. In the face of adversity, '
                              'we find pathways to success. Stay inspired, for success is not just a destination; it is a continuous journey. '
                              'Your journey is our journey. As you believe in yourself, together, we achieve greatness. '
                              'Every step you take is a step towards a brighter future. Believe, persist, and conquer."',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Stylish Divider
                  Container(
                    height: 1,
                    color: Colors.grey, // Set your preferred divider color
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),

                  const SizedBox(height: 16.0),

                  // Words of Wisdom from the Owner
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Why Choose Our Products?\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(height: 8.0),
                        ), // Adjust the height based on your preference
                        TextSpan(
                          text:
                              '"India\'s Most Reliable Digital Automatic Voltage Stabilizers for Air Conditioner and Mainline. '
                              'Perfect Partner for Air Conditioner & Other Appliances. Sleek and Wall Mount Model, High Efficiency toroidal Transformer, '
                              'Microcontroller Based Digital Technology. A proven & rigid product to handle voltage fluctuations. '
                              'Experience innovation, quality, and excellence with every use. Choose our stabilizers and join the journey of success!"'
                              '"Dedication and passion drive our success. Our products are meticulously crafted with precision '
                              'to meet your highest expectations. Experience innovation, quality, and excellence with every use. '
                              'Choose our products and join the journey of success!"',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
