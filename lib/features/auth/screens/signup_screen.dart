import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_fresh/core/auth/auth_provider.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_textformfiled.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/auth/screens/login_screen.dart';
import 'package:zeggo_fresh/features/bottomnav/bottom_navigation.dart';
import 'package:zeggo_fresh/core/utils/toast_utils.dart';
import 'package:zeggo_fresh/core/api/api_service.dart';
import 'package:zeggo_fresh/core/api/api_exception.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_clearNameError);
    _emailController.addListener(_clearEmailError);
    _phoneController.addListener(_clearPhoneError);
    _passwordController.addListener(_clearPasswordError);
  }

  void _clearNameError() {
    if (_nameError != null && _nameController.text.isNotEmpty) {
      setState(() {
        _nameError = null;
      });
    }
  }

  void _clearEmailError() {
    if (_emailError != null && _emailController.text.isNotEmpty) {
      setState(() {
        _emailError = null;
      });
    }
  }

  void _clearPhoneError() {
    if (_phoneError != null && _phoneController.text.isNotEmpty) {
      setState(() {
        _phoneError = null;
      });
    }
  }

  void _clearPasswordError() {
    if (_passwordError != null && _passwordController.text.isNotEmpty) {
      setState(() {
        _passwordError = null;
      });
    }
  }

  Future<void> _registerUser() async {
    setState(() {
      _nameError = null;
      _emailError = null;
      _phoneError = null;
      _passwordError = null;
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await ApiService().registerUser(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text.trim(),
        );

        setState(() {
          _isLoading = false;
        });

        // Success - parse response if needed
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        // For now, we'll use dummy user data similar to login screen
        // In a real app, you would parse this from the API response
        authProvider.login(_nameController.text.trim(), _emailController.text.trim(), "user_id_123");
        
        ToastUtils.showSuccessToast(context, "Account created successfully!");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
          (route) => false,
        );
      } on ApiException catch (e) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showErrorToast(context, e.message);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showErrorToast(context, "Network error. Please try again.");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ToastUtils.showErrorToast(context, "Please fill all fields correctly!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🛒 Logo / Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/logo.png', height: 80),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Sign up to start your shopping journey",
                        style: TextStyle(
                          color: Colors.grey, 
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Name Field with Error Handling
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? "Please enter your name" : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline, color: AppTheme.primary),
                      labelText: "Full Name",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _nameError != null ? Colors.redAccent : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _nameError != null ? Colors.redAccent : AppTheme.primary,
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      errorText: _nameError,
                    ),
                  ),
                ),

                // Email Field with Error Handling
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? "Please enter your email" : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primary),
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _emailError != null ? Colors.redAccent : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _emailError != null ? Colors.redAccent : AppTheme.primary,
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      errorText: _emailError,
                    ),
                  ),
                ),

                // Phone Field with Error Handling
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? "Please enter your phone number" : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android, color: AppTheme.primary),
                      labelText: "Phone Number",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _phoneError != null ? Colors.redAccent : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _phoneError != null ? Colors.redAccent : AppTheme.primary,
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      errorText: _phoneError,
                    ),
                  ),
                ),

                // Password Field with Error Handling
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? "Please enter password" : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primary),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _passwordError != null ? Colors.redAccent : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _passwordError != null ? Colors.redAccent : AppTheme.primary,
                          width: 1.2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      errorText: _passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Sign Up"),
                  ),
                ),

                const SizedBox(height: 30),

                // Social Login Options
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or continue with",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                const SizedBox(height: 20),

                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Google signup
                        ToastUtils.showInfoToast(context, "Google signup selected");
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Facebook signup
                        ToastUtils.showInfoToast(context, "Facebook signup selected");
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Twitter signup
                        ToastUtils.showInfoToast(context, "Twitter signup selected");
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.lightBlue,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ➕ Login Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.removeListener(_clearNameError);
    _emailController.removeListener(_clearEmailError);
    _phoneController.removeListener(_clearPhoneError);
    _passwordController.removeListener(_clearPasswordError);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}