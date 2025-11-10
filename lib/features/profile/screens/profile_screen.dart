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
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 45,
              backgroundColor: AppTheme.primary.withOpacity(0.1),
              child: const Icon(Icons.person, size: 50, color: AppTheme.primary),
            ),
            const SizedBox(height: 12),
            const Text(
              "Silpa Silpa",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "silpa@example.com",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showEditProfileBottomSheet(context);
              },
              icon: const Icon(Icons.edit, size: 18, color: Colors.white),
              label:  Text("Edit Profile",style: TextStyle(color:AppTheme.background ),),
              
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),

            const SizedBox(height: 30),

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
            buildMenuCard(
              context,
              title: "My Wishlist",
              icon: Icons.favorite_outline,
              onTap: () {},
            ),
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
            buildMenuCard(
              context,
              title: "Payment Methods",
              icon: Icons.payment_outlined,
              onTap: () {},
            ),
            buildMenuCard(
              context,
              title: "Help & Support",
              icon: Icons.help_outline,
              onTap: () {},
            ),
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

 
}
