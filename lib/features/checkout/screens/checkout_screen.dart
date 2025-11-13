import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/checkout/widgets/address_card_widget.dart';
import 'package:zeggo_fresh/features/checkout/widgets/order_item_widget.dart';
import 'package:zeggo_fresh/features/checkout/widgets/payment_card_widget.dart';
import 'package:zeggo_fresh/features/checkout/widgets/price_details_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = "cod";

  @override
  Widget build(BuildContext context) {
    final double subtotal = widget.cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] as num),
    );

    const double deliveryCharge = 30.0;
    final double total = subtotal + deliveryCharge;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text(
          "Checkout",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            CustomAddressCard(
              name: "Silpa Silpa",
              address: "123, 4th Cross, HSR Layout, Bangalore - 560102",
              phone: "+91 9876543210",
              onEdit: () {},
            ),

            const SizedBox(height: 20),

            const Text(
              "Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            Column(
              children: widget.cartItems.map((item) {
                return CustomOrderItem(
                  image: item['image'],
                  name: item['name'],
                  price: (item['price'] as num).toDouble(),
                );
              }).toList(),
            ),
            const Divider(height: 30),
            const Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            CustomPaymentMethod(
              selectedMethod: _selectedPayment,
              onChanged: (value) {
                setState(() => _selectedPayment = value ?? "cod");
              },
            ),

            const SizedBox(height: 20),

            CustomPriceRow(
              title: "Subtotal",
              value: "₹${subtotal.toStringAsFixed(2)}",
            ),
            CustomPriceRow(
              title: "Delivery Charges",
              value: "₹${deliveryCharge.toStringAsFixed(2)}",
            ),
            const Divider(),
            CustomPriceRow(
              title: "Total",
              value: "₹${total.toStringAsFixed(2)}",
              isBold: true,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 25),
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
                  _showOrderSuccessDialog(context);
                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    color: AppTheme.background,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Order Placed!"),
        content: const Text(
          "Your order has been placed successfully.\nWe'll deliver it soon 🚚",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
