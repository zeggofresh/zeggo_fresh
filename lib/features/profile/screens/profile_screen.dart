import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';
import 'package:zeggo_fresh/features/address/screens/address_screen.dart';
import 'package:zeggo_fresh/features/orders/screens/myorders_screen.dart';
import 'package:zeggo_fresh/features/profile/widgets/edit_bottomsheet.dart';
import 'package:zeggo_fresh/features/profile/widgets/profile_cards.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Profile picture with edit option
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  child: const Icon(Icons.person, size: 50, color: AppTheme.primary),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Silpa Silpa",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "silpa@example.com",
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Premium Member",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard("Orders", "12"),
                _buildStatCard("Wishlist", "8"),
                _buildStatCard("Coupons", "3"),
              ],
            ),

            const SizedBox(height: 30),

            // Menu Items
            buildMenuCard(
              context,
              title: "My Orders",
              icon: Icons.shopping_bag_outlined,
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyOrdersScreen(),
                  ));
              },
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              context,
              title: "My Wishlist",
              icon: Icons.favorite_outline,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              context,
              title: "My Addresses",
              icon: Icons.location_on_outlined,
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressScreen(),
                  ));
              },
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              context,
              title: "Payment Methods",
              icon: Icons.payment_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              context,
              title: "Notifications",
              icon: Icons.notifications_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            buildMenuCard(
              context,
              title: "Help & Support",
              icon: Icons.help_outline,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            buildMenuCard(
             context,
              title: "Logout",
              icon: Icons.logout,
              onTap: () {
                showLogoutDialog(context);
              },
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}