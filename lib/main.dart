import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_fresh/core/auth/auth_provider.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/splash/splash_screen.dart';

void main() {
  runApp(const ZeggoApp());
}

class ZeggoApp extends StatelessWidget {
  const ZeggoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Zeggo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}