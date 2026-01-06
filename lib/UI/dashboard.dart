import 'package:flutter/material.dart';
import 'profile.dart'; 
import 'reports.dart';
import 'citizenrequest.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final Color themeBlue = const Color(0xFF274C77);

  // --- POPUP MENU FOR THE ADD BUTTON ---
  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.red),
              title: const Text("Incident Report", style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsPage()));
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(Icons.people, color: themeBlue),
              title: const Text("Citizen's Request", style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CitizenRequestPage()));
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // --- CHATBOT CONVERSATION POPUP ---
  void _showChatBot(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 5, width: 40,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Buso-Buso Assistant", 
                style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const Divider(),
            const Expanded(child: Center(child: Text("How can I help you today?", style: TextStyle(color: Colors.grey)))),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
                left: 20, right: 20
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  suffixIcon: Icon(Icons.send, color: themeBlue),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: _currentIndex == 0 ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/busobuso_logo.png'),
        ),
        title: Text("Dashboard", style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold, fontSize: 22)),
        actions: [
          IconButton(icon: Icon(Icons.search, color: themeBlue), onPressed: () {}),
        ],
      ) : null,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              _buildHomeContent(), 
              const ProfilePage(), 
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => _showChatBot(context),
              child: SizedBox(
                width: 65, height: 65,
                child: Image.asset('assets/pyro_logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeBlue,
        shape: const CircleBorder(),
        onPressed: () => _showActionMenu(context),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Emergency News & Updates", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeBlue)),
          const SizedBox(height: 12),
          _buildNewsCard(tag: "CRITICAL ADVISORY", tagColor: Colors.red, title: "Taal Volcano: SO2 levels rising...", time: "5 mins ago"),
          const SizedBox(height: 12),
          _buildNewsCard(tag: "EMERGENCY ADVISORY", tagColor: Colors.orange, title: "Heavy Rainfall: Flood Warning...", time: "11 hr ago"),
          const SizedBox(height: 25),
          Text("Hazard Map", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeBlue)),
          const SizedBox(height: 12),
          _buildMapSection(),
          const SizedBox(height: 25),
          Text("Nearby Evacuation Centers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeBlue)),
          const SizedBox(height: 12),
          _buildEvacuationCard("1. Barangay Hall", "0.5 km away"),
          _buildEvacuationCard("2. Buso-Buso Elementary School", "1.0 km away"),
          const SizedBox(height: 100), 
        ],
      ),
    );
  }

  // --- REUSED UI COMPONENTS ---
  Widget _buildNewsCard({required String tag, required Color tagColor, required String title, required String time}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(5)),
            child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: themeBlue)),
          const SizedBox(height: 8),
          Align(alignment: Alignment.centerRight, child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11))),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset('assets/hazard_map.png', width: double.infinity, height: 160, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map_outlined, size: 18, color: themeBlue),
              label: Text("View Full Hazard Map", style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvacuationCard(String name, String distance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: themeBlue)),
          Row(
            children: [
              const Icon(Icons.directions_walk, color: Colors.green, size: 18),
              const SizedBox(width: 4),
              Text(distance, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      height: 70, color: themeBlue,
      shape: const CircularNotchedRectangle(), notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, color: _currentIndex == 0 ? Colors.white : Colors.white54, size: 30),
            onPressed: () => setState(() => _currentIndex = 0),
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: Icon(Icons.person_outline, color: _currentIndex == 1 ? Colors.white : Colors.white54, size: 30),
            onPressed: () => setState(() => _currentIndex = 1),
          ),
        ],
      ),
    );
  }
}