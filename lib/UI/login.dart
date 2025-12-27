import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSignup = _tabController.index == 1;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundDesign(),

          // 2. CIRCULAR LOGO (Top shifted up slightly)
          Positioned(
            left: 0,
            right: 0,
            top: 130, 
            child: Center(
              child: Container(
                width: 120, // Smaller logo
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4, offset: Offset(0, 4))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/busobuso_logo.png'),
                ),
              ),
            ),
          ),

          // 3. TITLE TEXT (Reduced top spacing)
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: const Text(
              "Barangay Buso-Buso\nResident EOC App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
                fontSize: 18, // Slightly smaller font
                letterSpacing: 2.4,
                color: Color(0xFFF2EFEF),
              ),
            ),
          ),

          // 4. DYNAMIC TAB BAR
          Positioned(
            top: 365, // Shifted up
            left: 60,
            right: 60,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              dividerColor: Colors.transparent,
              tabs: [
                _buildCustomTab("Login", 0),
                _buildCustomTab("Signup", 1),
              ],
            ),
          ),

          // 5. INPUT FORM (Compacted spacing)
          Positioned(
            top: 420, // Shifted up
            left: 53,
            right: 53,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Email address"),
                const SizedBox(height: 12), // Smaller gap
                
                _buildTextField("Password", isPassword: true, isConfirmField: false),
                
                if (isSignup) ...[
                  const SizedBox(height: 12),
                  _buildTextField("Confirm password", isPassword: true, isConfirmField: true),
                ],

                if (!isSignup)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 30, // Tighter text button
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white.withOpacity(0.67), fontSize: 12),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 15),

                // ACTION BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF274C77),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
                      elevation: 0,
                    ),
                    child: Text(
                      isSignup ? "CREATE ACCOUNT" : "LOGIN", 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // OR Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text("or", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
                  ],
                ),

                const SizedBox(height: 15),

                // GOOGLE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 28), 
                    label: const Text("Continue with Google", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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

          // 6. FOOTER
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: const Text(
              "Stay informed. Stay safe. © 2025 All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Lato', fontSize: 11, color: Color(0xFFF2EFEF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTab(String label, int index) {
    bool isActive = _tabController.index == index;
    return Tab(
      height: 35, // Smaller tab height
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w900 : FontWeight.w400,
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false, bool isConfirmField = false}) {
    bool obscure = isConfirmField ? _obscureConfirmPassword : _obscurePassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(color: Colors.white.withOpacity(0.67), fontSize: 11)),
        SizedBox(
          height: 30, // Constrains the height of the input area
          child: TextField(
            obscureText: isPassword ? obscure : false,
            cursorColor: Colors.white,
            cursorHeight: 18,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              isDense: true, // Reduces internal padding
              contentPadding: const EdgeInsets.symmetric(vertical: 8), 
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.8)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
              suffixIcon: isPassword
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white.withOpacity(0.67),
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isConfirmField) {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          } else {
                            _obscurePassword = !_obscurePassword;
                          }
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundDesign() {
    return Stack(
      children: [
        Positioned(left: -1078, top: 0, width: 1536, height: 864, child: Image.asset('assets/getstarted_background.jpg', fit: BoxFit.cover)),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(72, 141, 221, 0), Color.fromRGBO(56, 109, 170, 0.5), Color.fromRGBO(39, 76, 119, 0.96)],
              stops: [0.0, 0.0001, 0.5385],
            ),
          ),
        ),
        Positioned(
          top: -38,
          left: 0,
          right: 0,
          height: 440, // Slightly shorter header panel
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(38), bottomRight: Radius.circular(38)),
              boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.23), blurRadius: 4, offset: Offset(0, 4))],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(72, 141, 221, 0), Color.fromRGBO(56, 109, 170, 0.5), Color.fromRGBO(39, 76, 119, 0.96)],
                stops: [0.0, 0.0001, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}