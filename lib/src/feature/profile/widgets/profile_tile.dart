import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool showArrow;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon),
          title: Text(title),
          trailing:
              showArrow ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
        ),
        const Divider(height: 0),
      ],
    );
  }
}
