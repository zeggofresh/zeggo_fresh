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
    {
      'name': 'Tomatoes',
      'image': 'assets/images/tomato.jpeg',
      'qty': '1kg',
      'price': 40,
    },
    {
      'name': 'Cabbage',
      'image': 'assets/images/cabage.jpeg',
      'qty': '1kg',
      'price': 30,
    },
    {
      'name': 'Onion',
      'image': 'assets/images/onion.jpg',
      'qty': '1kg',
      'price': 50,
    },
    {
      'name': 'Cucumber',
      'image': 'assets/images/cucumbar.png',
      'qty': '500g',
      'price': 25,
    },
  ];

  final Map<int, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < vegetables.length; i++) {
      _quantities[i] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vegetables"),
        backgroundColor: AppTheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: vegetables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final item = vegetables[index];
            final isFavorite = widget.wishlistItems.contains(item);
            final quantity = _quantities[index] ?? 1;

            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
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
                              backgroundColor: Colors.white,
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
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
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item['qty'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹${item['price']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 108,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove, size: 15),
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(
                                            () => _quantities[index] =
                                                quantity - 1,
                                          );
                                        }
                                      },
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add, size: 18),
                                      onPressed: () {
                                        setState(
                                          () =>
                                              _quantities[index] = quantity + 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  onPressed: () {
                                    final product = {
                                      ...item,
                                      'quantity': quantity,
                                    };
                                    widget.onAddToCart(product);
                                  },
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppTheme.primary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                  onPressed: () {
                                    // final product = {...item, 'quantity': quantity};
                                  },
                                  child: const Text(
                                    "Buy",
                                    style: TextStyle(
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
