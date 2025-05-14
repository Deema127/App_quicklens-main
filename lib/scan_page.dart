import 'package:flutter/material.dart';
import 'package:quicklens/camera_screen.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/image 41.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.2),
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
                  buildScanButton("Add a new item", Icons.add, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  }),
                  const SizedBox(height: 16),
                  buildScanButton("Flag a damage item", Icons.flag, () {
                    // Navigate to reports screen
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildScanButton(String text, IconData icon, VoidCallback onPressed) {
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
