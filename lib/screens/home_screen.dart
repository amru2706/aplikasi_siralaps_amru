// home_screen.dart
import 'package:flutter/material.dart';
import 'package:iguana_taman_wisata/screens/menu_screen.dart'; // Import the new MenuScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Text in the Top Left
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2, // Place text in the middle vertically
            left: 20,
            right: 20, // Add right margin to prevent text from touching the edge
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SIRALAPS\n-IN JAKARTA", // Use '\n' to split text into two lines
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Aplikasi ini merupakan aplikasi mobile\nuntuk pelaporan kejadian dijalan.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis, // Add overflow
                  maxLines: null, // Allow text to wrap to multiple lines if necessary
                ),
                SizedBox(height: 20), // Space between text and button
                Align(
                  alignment: Alignment.centerRight, // Move button to the right
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to MenuScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 52, vertical: 16),
                      backgroundColor: Colors.pink, // Change button color as desired
                    ),
                    child: Text(
                      "Mulai!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image in the Bottom Right
          Positioned(
            bottom: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
                child: Image.asset(
                  'assets/images/emergency.png', // Adjust image path as needed
                  fit: BoxFit.cover, // Make the image cover the container
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
