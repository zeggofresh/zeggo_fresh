import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/cart/cart_screen.dart';
import 'package:zeggo_fresh/features/category/screens/category_screen.dart';
import 'package:zeggo_fresh/features/home/screens/home_screen.dart';
import 'package:zeggo_fresh/features/wishlist/wishlist_screen.dart';



class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, dynamic>> _wishlistItems = [];

  void _addToCart(Map<String, dynamic> product) {
    if (!_cartItems.contains(product)) {
      setState(() => _cartItems.add(product));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product['name']} added to cart")),
      );
    }
  }

void _toggleWishlist(Map<String, dynamic> product) {
  setState(() {
    final existingIndex = _wishlistItems.indexWhere((item) => item['name'] == product['name']);
    if (existingIndex >= 0) {
      _wishlistItems.removeAt(existingIndex);
    } else {
      _wishlistItems.add(product);
    }
  });
}


  void _removeFromCart(Map<String, dynamic> product) {
    setState(() => _cartItems.remove(product));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(
        onAddToCart: _addToCart,
        onToggleWishlist: _toggleWishlist,
        cartItems: _cartItems,
        wishlistItems: _wishlistItems,
      ),
      CategoryScreen(
        onAddToCart: _addToCart,
        onToggleWishlist: _toggleWishlist,
        cartItems: _cartItems,
        wishlistItems: _wishlistItems,
      ),
      CartScreen(
        cartItems: _cartItems,
        onRemoveItem: _removeFromCart,
      ),
      WishlistScreen(
        wishlistItems: _wishlistItems,
      ),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category_rounded), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Wishlist'),
        ],
      ),
    );
  }
}
