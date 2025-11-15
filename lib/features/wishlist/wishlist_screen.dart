import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/app_bar_widget.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_dialogs.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems;
  final void Function(Map<String, dynamic>)? onRemoveItem;

  const WishlistScreen({super.key, required this.wishlistItems, this.onRemoveItem});

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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("₹${item['price']}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            CustomDialogs.showDeleteDialog(
                              context,
                              title: "Remove from Wishlist",
                              message: "Are you sure you want to remove this item from your wishlist?",
                              onConfirm: () {
                                if (onRemoveItem != null) {
                                } else {
                                  // Show a message if no remove function is provided
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Unable to remove item")),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}