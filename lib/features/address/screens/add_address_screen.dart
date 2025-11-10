import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_textformfiled.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  String _addressType = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text(
          "Add New Address",
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _nameController,
                label: "Full Name",
                icon: Icons.person_outline,
                validatorMsg: "Please enter your name",
              ),
              CustomTextField(
                controller: _phoneController,
                label: "Phone Number",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                validatorMsg: "Please enter a valid phone number",
              ),
              CustomTextField(
                controller: _houseController,
                label: "House / Flat No.",
                icon: Icons.home_outlined,
                validatorMsg: "Please enter your house number",
              ),
              CustomTextField(
                controller: _streetController,
                label: "Street / Area / Landmark",
                icon: Icons.map_outlined,
                validatorMsg: "Please enter your street or landmark",
              ),
              CustomTextField(
                controller: _cityController,
                label: "City",
                icon: Icons.location_city_outlined,
                validatorMsg: "Please enter your city",
              ),
              CustomTextField(
                controller: _pincodeController,
                label: "Pincode",
                icon: Icons.pin_drop_outlined,
                keyboardType: TextInputType.number,
                validatorMsg: "Please enter a valid pincode",
              ),
              const SizedBox(height: 16),

              const Text(
                "Address Type",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildAddressTypeChip("Home"),
                  const SizedBox(width: 10),
                  _buildAddressTypeChip("Work"),
                  const SizedBox(width: 10),
                  _buildAddressTypeChip("Other"),
                ],
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Address Saved Successfully!")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildAddressTypeChip(String type) {
    final isSelected = _addressType == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      selectedColor: AppTheme.primary,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (value) {
        if (value) {
          setState(() => _addressType = type);
        }
      },
    );
  }
}
