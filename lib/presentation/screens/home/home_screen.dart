import 'package:currency_rate_calculator/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:currency_rate_calculator/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = const [DashboardScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black26)],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              gap: 8,
              color: Colors.grey[600],
              activeColor: Colors.black,
              tabBackgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              tabs: const [
                GButton(icon: Icons.dashboard, text: 'Dashboard'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
