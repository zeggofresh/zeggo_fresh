import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_fresh/core/auth/auth_provider.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/auth/screens/login_screen.dart';
import 'package:zeggo_fresh/features/bottomnav/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the navigation to allow the auth provider to initialize
    Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  void _checkLoginStatus() {
    // Use WidgetsBinding to ensure the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()), // Changed to BottomNavScreen
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🔥 WHITE BACKGROUND
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            AnimatedContainer(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.elasticOut,
              child: Image.asset(
                "assets/images/logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 30),

            // App name


            const SizedBox(height: 10),

            const Text(
              "Fresh Vegetables & Fruits",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // dark grey
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 50),

            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}