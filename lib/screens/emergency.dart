import 'package:flutter/material.dart';
import 'package:iguana_taman_wisata/models/kenzo.dart';

class EmergencyScreen extends StatelessWidget {
  final Kenzo kenzo;

  EmergencyScreen({required this.kenzo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kenzo.nama.isNotEmpty ? kenzo.nama : 'Unknown kenzo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              kenzo.nama.isNotEmpty ? kenzo.nama : 'Unknown kenzo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              kenzo.description.isNotEmpty ? kenzo.description : 'No description available',
            ),
            SizedBox(height: 10),
            kenzo.imageUrl.isNotEmpty
                ? Image.network(kenzo.imageUrl)
                : Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity),
          ],
        ),
      ),
    );
  }
}
