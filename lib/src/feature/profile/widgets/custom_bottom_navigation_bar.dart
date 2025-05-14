import 'package:flutter/material.dart';
import 'custom_bottom_bar_painter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Paint background
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 70),
          painter: CustomBottomBarPainter(),
        ),

        // Bottom nav icons
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.black : Colors.black45,
                ),
                onPressed: () => onItemTapped(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: selectedIndex == 1 ? Colors.black : Colors.black45,
                ),
                onPressed: () => onItemTapped(1),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: selectedIndex == 2 ? Colors.black : Colors.black45,
                ),
                onPressed: () => onItemTapped(2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
