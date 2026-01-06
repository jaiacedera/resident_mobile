import 'package:flutter/material.dart';

class CitizenRequestPage extends StatefulWidget {
  const CitizenRequestPage({super.key});

  @override
  State<CitizenRequestPage> createState() => _CitizenRequestPageState();
}

class _CitizenRequestPageState extends State<CitizenRequestPage> {
  // State variables
  bool _isSubmitted = false;
  String? selectedRequest;
  
  // Use final instead of const to avoid evaluation errors inside the state
  final Color themeBlue = const Color(0xFF274C77);

  final List<String> requestOptions = [
    "Barangay Clearance",
    "Indigency",
    "Barangay Certificate",
    "Residency"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: themeBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Citizen's Request",
          style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold),
        ),
      ),
      // Switch view based on submission status
      body: _isSubmitted ? _buildSuccessScreen() : _buildRequestForm(),
    );
  }

  // --- VIEW 1: THE REQUEST FORM ---
  Widget _buildRequestForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Progress (Step 2)
            Center(child: _buildProgressBar(progressWidth: 100)),
            const SizedBox(height: 30),

            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF274C77)),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: const Text("Copy Profile", style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              "Request",
              style: TextStyle(color: Color(0xFF274C77), fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedRequest,
              hint: const Text("Select Request", style: TextStyle(color: Colors.grey, fontSize: 13)),
              decoration: _inputDecoration(),
              items: requestOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: themeBlue, fontSize: 14)),
                );
              }).toList(),
              onChanged: (newValue) => setState(() => selectedRequest = newValue),
              icon: Icon(Icons.keyboard_arrow_down, color: themeBlue),
            ),
            
            const SizedBox(height: 20),

            const Text(
              "Note",
              style: TextStyle(color: Color(0xFF274C77), fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: _inputDecoration(hint: "Enter your note here..."),
            ),

            const SizedBox(height: 15),

            // SUBMIT BUTTON
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => setState(() => _isSubmitted = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- VIEW 2: THE SUCCESS SCREEN ---
  Widget _buildSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Bar (Completed Step 3)
            _buildProgressBar(progressWidth: 200),
            const SizedBox(height: 50),
            
            // Checkmark Circle with Ripple effect
            Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 180, height: 180, decoration: BoxDecoration(color: themeBlue.withOpacity(0.1), shape: BoxShape.circle)),
                Container(width: 140, height: 140, decoration: BoxDecoration(color: themeBlue.withOpacity(0.2), shape: BoxShape.circle)),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, color: Color(0xFF274C77), size: 60),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text("Request Successful", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: themeBlue)),
            const SizedBox(height: 10),
            Text("Your request has\nsuccessfully submitted.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: themeBlue)),
            const SizedBox(height: 40),
            
            // Request ID Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: themeBlue, borderRadius: BorderRadius.circular(30)),
              child: const Text("Request ID: #20-6146", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  // REUSABLE COMPONENTS
  Widget _buildProgressBar({required double progressWidth}) {
    return Container(
      width: 200, height: 4,
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(width: progressWidth, decoration: BoxDecoration(color: themeBlue, borderRadius: BorderRadius.circular(10))),
          Positioned(left: 0, top: -3, child: CircleAvatar(radius: 5, backgroundColor: themeBlue)),
          Positioned(left: 95, top: -3, child: CircleAvatar(radius: 5, backgroundColor: themeBlue)),
          Positioned(right: 0, top: -3, child: CircleAvatar(radius: 5, backgroundColor: progressWidth >= 200 ? themeBlue : Colors.grey[300])),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: themeBlue, width: 1)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: themeBlue, width: 2)),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: themeBlue, fontSize: 14),
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: themeBlue, width: 1)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: themeBlue, width: 2)),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
        ),
      ),
    );
  }
}