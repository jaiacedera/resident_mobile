import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // State variable to track if report is submitted
  bool _isSubmitted = false;
  static const Color themeBlue = Color(0xFF274C77);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: themeBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Incident Reports",
          style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold),
        ),
      ),
      // Toggle between the Form and the Success Screen
      body: _isSubmitted ? _buildSuccessScreen() : _buildReportForm(),
    );
  }

  // --- VIEW 1: THE REPORT FORM ---
  Widget _buildReportForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator (Step 2 of 3)
            Center(
              child: _buildProgressBar(progressWidth: 133), // Middle position
            ),
            const SizedBox(height: 30),
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themeBlue),
            ),
            const SizedBox(height: 20),
            
            _buildTextField("Full Name", "Enter your full name"),
            _buildTextField("Address", "Enter your address"),
            _buildTextField("Contact Number", "Enter your contact number"),
            
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text("Copy Profile", style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
            
            const SizedBox(height: 10),
            _buildTextField("Report", "Enter your report", maxLines: 6),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Mic Button
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: themeBlue,
                  mini: true,
                  heroTag: "micBtn",
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSubmitted = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text(
                    "Submit", 
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- VIEW 2: THE SUCCESS SCREEN (From your image) ---
  Widget _buildSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Bar (Completed Step 3 of 3)
            _buildProgressBar(progressWidth: 200),
            const SizedBox(height: 50),
            
            // Success Icon with Ripple Effect
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180, height: 180,
                  decoration: BoxDecoration(
                    color: themeBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 140, height: 140,
                  decoration: BoxDecoration(
                    color: themeBlue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, color: themeBlue, size: 60),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Report Successful",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: themeBlue),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your incident report has\nsuccessfully submitted.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: themeBlue, height: 1.5),
            ),
            const SizedBox(height: 40),
            
            // Report ID Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: themeBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Report ID: #25-6146",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Progress Bar
  Widget _buildProgressBar({required double progressWidth}) {
    return Container(
      width: 200,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: progressWidth,
            decoration: BoxDecoration(
              color: themeBlue,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Circle Markers
          const Positioned(left: 0, top: -3, child: CircleAvatar(radius: 5, backgroundColor: themeBlue)),
          Positioned(left: 95, top: -3, child: CircleAvatar(radius: 5, backgroundColor: themeBlue)),
          Positioned(right: 0, top: -3, child: CircleAvatar(radius: 5, backgroundColor: progressWidth >= 200 ? themeBlue : Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: themeBlue, fontSize: 14),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: themeBlue, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: themeBlue, width: 2),
          ),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
        ),
      ),
    );
  }
}