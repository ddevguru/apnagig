import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation_bloc.dart';
import 'package:apnagig_users/features/dashboard/presentation/HomeScreen.dart';
import 'package:apnagig_users/features/dashboard/presentation/SearchScreen.dart';
import 'package:apnagig_users/features/booking/presentation/ActiveBookingDetailsScreen.dart';
import 'package:apnagig_users/features/booking/presentation/MyBookingsScreen.dart';
import '../../../core/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const SearchScreen(),
      const MessagesPlaceholderScreen(),
      const MyBookingsScreen(),
      const ProfilePlaceholderScreen(),
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.selectedIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _buildBottomNavigationBar(context, state.selectedIndex),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int selectedIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, Icons.home_filled, 0, selectedIndex),
          _buildNavItem(context, Icons.search_rounded, 1, selectedIndex),
          _buildNavItem(context, Icons.chat_bubble_outline_rounded, 2, selectedIndex),
          _buildNavItem(context, Icons.calendar_month_outlined, 3, selectedIndex),
          _buildNavItem(context, Icons.person_outline_rounded, 4, selectedIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, int selectedIndex) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        context.read<NavigationBloc>().add(TabChangedEvent(index));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryBlue : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.textMuted,
          size: 24,
        ),
      ),
    );
  }
}

// Messages Placeholder
class MessagesPlaceholderScreen extends StatelessWidget {
  const MessagesPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Messages'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.chat_bubble_outline_rounded, size: 64, color: AppColors.textMuted),
            SizedBox(height: 16),
            Text(
              'No Messages Yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Chat history with your pros will appear here.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Placeholder
class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile1.png'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jane Doe',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const Text(
              'jane.doe@example.com',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(Icons.person_outline, 'Account Information'),
            _buildProfileItem(Icons.payment_outlined, 'Payment Methods'),
            _buildProfileItem(Icons.history_rounded, 'Service History'),
            _buildProfileItem(Icons.settings_outlined, 'Settings'),
            _buildProfileItem(Icons.logout_rounded, 'Log Out', isDanger: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, {bool isDanger = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDanger ? AppColors.danger : AppColors.secondaryBlue),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDanger ? AppColors.danger : AppColors.textDark,
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isDanger ? AppColors.danger : AppColors.textMuted),
        ],
      ),
    );
  }
}
