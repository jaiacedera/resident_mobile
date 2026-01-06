import 'package:flutter/material.dart';
import 'dashboard.dart'; // After finishing info, go to dashboard

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();
  final Color themeBlue = const Color(0xFF274C77);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Personal Information",
          style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: themeBlue),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey, // Form key is used here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Complete your Profile",
                style: TextStyle(color: themeBlue, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "This information helps emergency responders locate and assist you faster.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 30),

              _buildInputLabel("Full Name"),
              _buildTextFormField("Enter your full name", label: "Full Name"),

              const SizedBox(height: 20),
              _buildInputLabel("Complete Address"),
              _buildTextFormField("Street, House No., Purok", label: "Address"),

              const SizedBox(height: 20),
              _buildInputLabel("Contact Number"),
              _buildTextFormField("09XXXXXXXXX", isNumber: true, label: "Contact Number"),

              const SizedBox(height: 20),
              _buildInputLabel("Emergency Contact Person"),
              _buildTextFormField("Name of person to contact", label: "Emergency Contact"),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // FIX: Check if the form is valid before navigating
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const DashboardPage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("SAVE AND CONTINUE", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: TextStyle(color: themeBlue, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextFormField(String hint, {bool isNumber = false, required String label}) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      // FIX: Added validation logic
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $label';
        }
        if (isNumber && value.length < 11) {
          return 'Please enter a valid 11-digit number';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
        filled: true,
        fillColor: themeBlue,
        errorStyle: const TextStyle(color: Colors.redAccent), // Style for the error message
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}