import 'package:flutter/material.dart';
import 'package:quicklens/item_grid.dart';
import 'package:quicklens/low_stock.dart';
import 'package:quicklens/scan_page.dart';
import 'package:quicklens/src/feature/profile/profile_page.dart';
import 'package:quicklens/src/feature/profile/screens/reports_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ScanPage(),
    ProfilePage(),
  ];
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.pink[100],
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/scan.png',
              width: 30,
              height: 30,
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: '',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset('assets/images/image 41.png', fit: BoxFit.cover),
        ),
        // Overlay with content
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.2), // Optional: overlay tint
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Quicklens",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'serif',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  buildHomeButton("Goods", Icons.inventory, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ItemGridScreen()),
                    ); // Navigate to goods screen
                  }),
                  const SizedBox(height: 16),
                  buildHomeButton("Low Stock Products", Icons.check_circle, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LowStockScreen()),
                    ); // Navigate to low stock screen
                  }),
                  const SizedBox(height: 16),
                  buildHomeButton("Reports", Icons.insert_chart, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportsPage()),
                    ); // Navigate to reports screen
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHomeButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        minimumSize: const Size(double.infinity, 60),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, color: Colors.black),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      onPressed: onPressed,
    );
  }
}
