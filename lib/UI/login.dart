import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'personal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _clearFormFields();
        setState(() {});
      }
    });

    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  void _clearFormFields() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  void _handleLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );
  }

  void _handleSignup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Account Created", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Thank you for signing up! Please log in with your new account to complete your profile."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _tabController.animateTo(0);
            },
            child: const Text("PROCEED TO LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoadingPage()),
        );
      }
    } catch (error) {
      debugPrint("Google Sign-In Error: $error");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignup = _tabController.index == 1;
    bool passwordsMatch = _passwordController.text == _confirmPasswordController.text;
    bool showPassError = isSignup && _confirmPasswordController.text.isNotEmpty && !passwordsMatch;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackgroundDesign(),

          Positioned(
            left: 0, right: 0, top: 110,
            child: Center(
              child: Container(
                width: 110, height: 110,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/busobuso_logo.png'),
                ),
              ),
            ),
          ),

          Positioned(
            top: 240, left: 0, right: 0,
            child: const Text(
              "Barangay Buso-Buso\nResident EOC App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 18,
                letterSpacing: 1.2, color: Color(0xFFF2EFEF)
              ),
            ),
          ),

          Positioned(
            top: 335, left: 60, right: 60,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              dividerColor: Colors.transparent,
              tabs: [
                _buildCustomTab("Login", 0),
                _buildCustomTab("Signup", 1),
              ],
            ),
          ),

          Positioned(
            top: 400, left: 53, right: 53, bottom: 80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("Email address", controller: _emailController),
                  const SizedBox(height: 10),
                  _buildTextField("Password", isPassword: true, controller: _passwordController),

                  if (!isSignup)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?",
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ),
                    ),

                  if (isSignup) ...[
                    const SizedBox(height: 10),
                    _buildTextField("Confirm password", isPassword: true, isConfirmField: true, controller: _confirmPasswordController),
                    if (showPassError)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text("Passwords do not match", style: TextStyle(color: Colors.redAccent, fontSize: 11)),
                      ),
                  ],

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: isSignup
                          ? (passwordsMatch && _emailController.text.isNotEmpty ? _handleSignup : null)
                          : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF274C77),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
                      ),
                      child: Text(isSignup ? "SIGN UP" : "LOGIN", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: _handleGoogleSignIn,
                      icon: const Icon(Icons.g_mobiledata, size: 30),
                      label: const Text("Continue with Google", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF274C77),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(41)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Stay informed. Stay safe. © 2025 All rights reserved.",
                style: TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTab(String label, int index) {
    bool isActive = _tabController.index == index;
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w400,
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false, bool isConfirmField = false, TextEditingController? controller}) {
    bool obscure = isConfirmField ? _obscureConfirmPassword : _obscurePassword;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.67), fontSize: 11)),
        TextField(
          controller: controller,
          cursorColor: Colors.white, // FIX: Set the typing line (cursor) color to white
          obscureText: isPassword ? obscure : false,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
            suffixIcon: isPassword ? IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white, size: 18),
              onPressed: () => setState(() {
                if (isConfirmField) _obscureConfirmPassword = !_obscureConfirmPassword;
                else _obscurePassword = !_obscurePassword;
              }),
            ) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundDesign() {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/getstarted_background.jpg', fit: BoxFit.cover)),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xFF274C77)],
              stops: [0.1, 0.9],
            ),
          ),
        ),
        Positioned(
          top: 0, left: 0, right: 0, height: 380,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF274C77),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))],
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PersonalPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF274C77),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text("Setting up your profile...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}