import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/orders/widgets/order_cards.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        "id": "#ORD1024",
        "image": "assets/images/tomato.jpeg",
        "item": "Fresh Tomatoes",
        "date": "10 Nov 2025",
        "amount": 120,
        "status": "Delivered",
      },
      {
        "id": "#ORD1023",
        "image": "assets/images/onion.jpg",
        "item": "Organic Onions",
        "date": "08 Nov 2025",
        "amount": 80,
        "status": "In Progress",
      },
      {
        "id": "#ORD1022",
        "image": "assets/images/cabage.jpeg",
        "item": "Cabbage (1kg)",
        "date": "05 Nov 2025",
        "amount": 45,
        "status": "Cancelled",
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: orders.isEmpty
            ? const Center(
                child: Text(
                  "No orders yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return CustomOrderCard(
                    order: order,
                    onTap: () {
                      // print("Tapped on ${order["id"]}");
                    },
                  );
                },
              ),
      ),
    );
  }
}
