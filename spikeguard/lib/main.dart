import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spikeguard/shared/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, // Set default text direction to LTR
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
