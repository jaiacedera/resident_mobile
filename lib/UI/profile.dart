import 'package:flutter/material.dart';
import 'tracker.dart'; 
import 'login.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Function to show the logout loading dialog
  void _showLogoutLoading(BuildContext context) {
    const Color themeBlue = Color(0xFF274C77);

    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss the loading screen
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: themeBlue,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 20),
                Text(
                  "Logging out...",
                  style: TextStyle(
                    color: themeBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a short delay (e.g., 2 seconds) for the logout process
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color themeBlue = Color(0xFF274C77);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Column(
        children: [
          // 1. TOP SECTION
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile_bg_doodle.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: const Icon(Icons.settings, color: themeBlue),
                ),
              ),
              Positioned(
                bottom: -60,
                child: CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.white,
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 70),

          // 2. NAME
          const Text(
            "Juan Dela Cruz",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: themeBlue,
            ),
          ),

          const SizedBox(height: 20),

          // 3. MENU LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildProfileItem(context, Icons.person, "Personal Information"),
                _buildProfileItem(context, Icons.notifications, "Notification"),
                _buildProfileItem(context, Icons.location_on, "Address"),
                _buildProfileItem(context, Icons.track_changes, "Tracker"),
                _buildProfileItem(context, Icons.edit, "Customize"),
                _buildProfileItem(context, Icons.logout, "Log Out", isLogout: true),
                const SizedBox(height: 100), 
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String title, {bool isLogout = false}) {
    const Color themeBlue = Color(0xFF274C77);
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      leading: CircleAvatar(
        backgroundColor: themeBlue,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: themeBlue,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: () {
        if (title == "Tracker") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TrackerPage()),
          );
        } else if (isLogout) {
          // Trigger the loading screen instead of immediate navigation
          _showLogoutLoading(context);
        } else {
          print("Tapped on $title");
        }
      },
    );
  }
}