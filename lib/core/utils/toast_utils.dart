import 'package:flutter/material.dart';

class ToastUtils {
  static void showSuccessToast(BuildContext context, String message) {
    _showToast(context, message, Colors.green);
  }

  static void showErrorToast(BuildContext context, String message) {
    _showToast(context, message, Colors.red);
  }

  static void showInfoToast(BuildContext context, String message) {
    _showToast(context, message, Colors.blue);
  }

  static void showWarningToast(BuildContext context, String message) {
    _showToast(context, message, Colors.orange);
  }
  
  // Test method to verify toast functionality
  static void testToast(BuildContext context) {
    showInfoToast(context, "Toast is working!");
  }

  static void _showToast(BuildContext context, String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
    
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      // Fallback to a simple print if we can't show the SnackBar
      debugPrint("Toast error: $e");
      debugPrint("Toast message: $message");
    }
  }
}