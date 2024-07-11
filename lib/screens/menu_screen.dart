// menu_screen.dart
import 'package:flutter/material.dart';
import 'package:iguana_taman_wisata/screens/profile_screen.dart';
import 'damkar_screen.dart';
import 'polisi_screen.dart';
import 'ambulance_screen.dart';
import 'lapor_screen.dart';
import 'history_screen.dart';
import 'callcenter_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Welcome Text
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Selamat datang di aplikasi SIRALAPS, ada kejadian apa hari ini? Silahkan melapor, identitas Anda dijamin terlindungi',
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 18),

            // Fixed height for the Image Containers Grid
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                children: [
                  _buildImageContainer(context, 'assets/images/damkar.png', 'Pemadam Kebakaran', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DamkarScreen()),
                    );
                  }),
                  _buildImageContainer(context, 'assets/images/ambulance.png', 'Ambulance', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmbulanceScreen()),
                    );
                  }),
                  _buildImageContainer(context, 'assets/images/polisi.png', 'Polisi', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PolisiScreen()),
                    );
                  }),
                  _buildImageContainer(context, 'assets/images/call.png', 'Call Center', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CallCenterScreen()),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Menu List
            Expanded(
              child: ListView(
                children: [
                  _buildMenuTile(context, 'CRUD Instansi', Icons.support_agent, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }),
                  _buildMenuTile(context, 'Lapor', Icons.report, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LaporScreen()),
                    );
                  }),
                  _buildMenuTile(context, 'History', Icons.history, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 2),

            // Logout Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout berhasil')),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageContainer(BuildContext context, String imagePath, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 30),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: onPressed,
        trailing: Icon(Icons.arrow_forward, color: Colors.blueAccent),
      ),
    );
  }
}
