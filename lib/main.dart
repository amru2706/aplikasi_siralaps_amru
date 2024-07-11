import 'package:flutter/material.dart';
import 'package:iguana_taman_wisata/screens/auth_screen.dart';
import 'package:iguana_taman_wisata/screens/home_screen.dart';
import 'package:iguana_taman_wisata/screens/emergency.dart';
import 'package:iguana_taman_wisata/models/kenzo.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iguana Taman Wisata',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
        '/emergency': (context) => EmergencyScreen(kenzo: ModalRoute.of(context)!.settings.arguments as Kenzo),
      },
    );
  }
}
