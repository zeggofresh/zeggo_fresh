import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class CustomPaymentMethod extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String?> onChanged;

  const CustomPaymentMethod({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          RadioListTile<String>(
            activeColor: AppTheme.primary,
            title: const Text("Cash on Delivery"),
            value: "cod",
            groupValue: selectedMethod,
            onChanged: onChanged,
          ),
          const Divider(height: 1),
          RadioListTile<String>(
            activeColor: AppTheme.primary,
            title: const Text("UPI / Wallets"),
            value: "upi",
            groupValue: selectedMethod,
            onChanged: onChanged,
          ),
          const Divider(height: 1),
          RadioListTile<String>(
            activeColor: AppTheme.primary,
            title: const Text("Credit / Debit Card"),
            value: "card",
            groupValue: selectedMethod,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
