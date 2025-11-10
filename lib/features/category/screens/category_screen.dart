import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class CategoryScreen extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAddToCart;
  final void Function(Map<String, dynamic>) onToggleWishlist;
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> wishlistItems;

  const CategoryScreen({
    super.key,
    required this.onAddToCart,
    required this.onToggleWishlist,
    required this.cartItems,
    required this.wishlistItems,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> vegetables = [
    {'name': 'Tomatoes', 'image': 'assets/images/tomato.jpeg', 'qty': '1kg', 'price': 40},
    {'name': 'Cabbage', 'image': 'assets/images/cabage.jpeg', 'qty': '1kg', 'price': 30},
    {'name': 'Onion', 'image': 'assets/images/onion.jpg', 'qty': '1kg', 'price': 50},
    {'name': 'Cucumber', 'image': 'assets/images/cucumbar.png', 'qty': '500g', 'price': 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vegetables")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: vegetables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = vegetables[index];
            final isFavorite = widget.wishlistItems.contains(item);

            return Container(
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          item['image'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: GestureDetector(
                          onTap: () {
                            widget.onToggleWishlist(item);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: AppTheme.background,
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        Text(item['qty'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${item['price']}",
                              style: const TextStyle(fontWeight: FontWeight.bold, color:AppTheme.primary,),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:AppTheme.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                              ),
                              onPressed: () => widget.onAddToCart(item),
                              child: const Text("Add",style: TextStyle(color: AppTheme.background,),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
