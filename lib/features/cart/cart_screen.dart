import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/checkout/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final void Function(Map<String, dynamic>) onRemoveItem;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    final total = cartItems.fold(0, (sum, item) => sum + item['price'] as int);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          leading: Image.asset(item['image'], width: 50, fit: BoxFit.cover),
                          title: Text(item['name']),
                          subtitle: Text(item['qty']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => onRemoveItem(item),
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
                              fontWeight: FontWeight.bold, color: AppTheme.textPrimary, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:AppTheme.primary,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CheckoutScreen(cartItems: [],),
                  ));
                    },
                    child: const Text("Checkout",style: TextStyle(color: AppTheme.background,),),
                  ),
                ],
              ),
            ),
    );
  }
}
