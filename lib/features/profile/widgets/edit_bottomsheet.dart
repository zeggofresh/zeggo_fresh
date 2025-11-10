import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_textformfiled.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

void showEditProfileBottomSheet(BuildContext context) {
  final TextEditingController nameController =
      TextEditingController(text: "Silpa Silpa");
  final TextEditingController emailController =
      TextEditingController(text: "silpa@example.com");
  final TextEditingController phoneController =
      TextEditingController(text: "+91 9876543210");

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppTheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              CircleAvatar(
                radius: 40,
                backgroundColor: AppTheme.primary.withOpacity(0.15),
                child: const Icon(Icons.person, size: 45, color: AppTheme.primary),
              ),
              const SizedBox(height: 16),

              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: nameController,
                label: "Full Name",
                icon: Icons.person_outline,
                validatorMsg: "Please enter your name",
              ),
              CustomTextField(
                controller: phoneController,
                label: "Phone Number",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                validatorMsg: "Please enter your phone number",
              ),
              CustomTextField(
                controller: emailController,
                label: "Email Address",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validatorMsg: "Please enter your email",
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated successfully!")),
                    );
                  },
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: AppTheme.background,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      );
    },
  );
}
