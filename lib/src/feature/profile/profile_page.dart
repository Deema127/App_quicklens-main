import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicklens/src/feature/auth/controller/auth_crl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicklens/src/feature/profile/screens/language_settings_sheet.dart';
import 'package:quicklens/src/feature/profile/widgets/profile_tile.dart';
import 'package:quicklens/src/feature/profile/widgets/custom_bottom_navigation_bar.dart';
import 'package:quicklens/src/feature/profile/screens/account_settings_screen.dart';
import 'package:quicklens/src/feature/profile/screens/reports_page.dart';
import '../../core/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Default to profile tab
  String _selectedLanguage = 'system'; // Default to system language
  String username = '';
  String email = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (doc.exists) {
          setState(() {
            username = doc.data()?['username'] ?? '';
            email = user.email ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username.isNotEmpty ? username : 'No username',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email.isNotEmpty ? email : 'No email',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                ],
              ),
            ),
            const Divider(height: 0),

            ProfileTile(
              icon: Icons.settings,
              title: "Account Settings",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AccountSettingsSheet(),
                );
              },
            ),
            ProfileTile(
              icon: Icons.language,
              title: "Language",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  builder:
                      (context) => LanguageSettingsSheet(
                        selectedLanguage: _selectedLanguage,
                        onLanguageSelected: (language) {
                          setState(() {
                            _selectedLanguage = language;
                          });
                        },
                      ),
                );
              },
            ),
            ProfileTile(
              icon: Icons.business_center,
              title: "Business details",
              onTap: () {
                Navigator.pushNamed(context, '/business-details');
              },
            ),
            ProfileTile(
              icon: Icons.report,
              title: "Reports",
              onTap: () => Get.to(() => const ReportsPage()),
            ),
            ProfileTile(
              icon: Icons.logout,
              title: "Sign out",
              showArrow: false,
              onTap: () async {
                final authCrl = Get.find<AuthCrl>();
                await authCrl.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
