import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/commonwidgets/custom_searchfiled.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/home/widgets/banner_slider.dart';
import 'package:zeggo_fresh/features/home/widgets/home_app_bar.dart';
import 'package:zeggo_fresh/features/home/widgets/product_grid.dart';


import 'package:zeggo_fresh/features/home/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  final void Function(Map<String, dynamic>) onAddToCart;
  final void Function(Map<String, dynamic>) onToggleWishlist;
  final List<Map<String, dynamic>> cartItems;
  final List<Map<String, dynamic>> wishlistItems;

  const HomeScreen({
    super.key,
    required this.onAddToCart,
    required this.onToggleWishlist,
    required this.cartItems,
    required this.wishlistItems,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {'name': 'Fresh Apples', 'image': 'assets/images/cabage.jpeg', 'qty': '1kg', 'price': 120},
      {'name': 'Organic Bananas', 'image': 'assets/images/onion.jpg', 'qty': '1 Dozen', 'price': 60},
      {'name': 'Tomatoes', 'image': 'assets/images/tomato.jpeg', 'qty': '1kg', 'price': 40},
      {'name': 'Broccoli', 'image': 'assets/images/cucumbar.png', 'qty': '500g', 'price': 70},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchField(
              hintText: "Search for vegetables...",
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),
            BannerSlider(banners: const [
              'assets/images/banner1.jpg',
              'assets/images/banner2.jpg',
              'assets/images/banner3.jpg',
            ]),
            const SectionTitle(title: "Popular Products"),
            ProductGrid(
              products: products,
              onAddToCart: onAddToCart,
              onToggleWishlist: onToggleWishlist,
              wishlistItems: wishlistItems,
            ),
          ],
        ),
      ),
    );
  }
}


