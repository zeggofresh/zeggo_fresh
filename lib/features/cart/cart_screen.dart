import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/app_bar_widget.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_dialogs.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/checkout/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final void Function(Map<String, dynamic>) onRemoveItem;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Map to store quantity for each item
  Map<String, int> _itemQuantities = {};

  @override
  void initState() {
    super.initState();
    // Initialize quantities for all items
    for (var item in widget.cartItems) {
      _itemQuantities[item['name']] = item['quantity'] ?? 1;
    }
  }

  void _incrementQuantity(String itemName, int currentQuantity) {
    setState(() {
      _itemQuantities[itemName] = currentQuantity + 1;
    });
  }

  void _decrementQuantity(String itemName, int currentQuantity) {
    if (currentQuantity > 1) {
      setState(() {
        _itemQuantities[itemName] = currentQuantity - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total with updated quantities
    int total = 0;
    for (var item in widget.cartItems) {
      int quantity = _itemQuantities[item['name']] ?? 1;
      total += (item['price'] as int) * quantity;
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Zeggo"),
      backgroundColor: AppTheme.background,
      body: widget.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        final quantity = _itemQuantities[item['name']] ?? 1;
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['image'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item['qty'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "₹${item['price']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(width: 12),
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                      onPressed: () {
                                        CustomDialogs.showDeleteDialog(
                                          context,
                                          title: "Remove Item",
                                          message: "Are you sure you want to remove this item from your cart?",
                                          onConfirm: () => widget.onRemoveItem(item),
                                        );
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    const SizedBox(height: 8),
                                    
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline, 
                                            color: AppTheme.primary, 
                                            size: 20),
                                          onPressed: () => _decrementQuantity(item['name'], quantity),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                                        ),
                                        
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(
                                            quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline, 
                                            color: AppTheme.primary, 
                                            size: 20),
                                          onPressed: () => _incrementQuantity(item['name'], quantity),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text("₹$total",
                          style:  TextStyle(
                              fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:AppTheme.primary,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CheckoutScreen(cartItems:widget.cartItems,),
                  ));
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
    );
  }
}