import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/app_bar_widget.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistScreen({super.key, required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Zeggo"),
      backgroundColor: AppTheme.background,
      body: wishlistItems.isEmpty
          ? const Center(child: Text("No items in wishlist."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Image.asset(item['image'], width: 60, fit: BoxFit.cover),
                    title: Text(item['name']),
                    subtitle: Text(item['qty']),
                    trailing: Text("₹${item['price']}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ),
                );
              },
            ),
    );
  }
}