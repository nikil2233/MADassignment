import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/features/shop/screens/shop_screen.dart';
import 'package:pet_care_app/features/vets/screens/vets_screen.dart';
import 'package:pet_care_app/features/education/screens/education_screen.dart';
import 'package:pet_care_app/features/home/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onShopTap: () => setState(() => _currentIndex = 1),
        onVetTap: () => setState(() => _currentIndex = 2),
        onEducationTap: () => setState(() => _currentIndex = 3),
      ),
      const ShopScreen(),
      const VetsScreen(),
      const EducationScreen(),
    ];

    return Scaffold(
      extendBody: true, // Important for transparent/floating nav bar
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),
              labelTextStyle: MaterialStateProperty.all(
                GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            child: NavigationBar(
              height: 70,
              elevation: 0,
              selectedIndex: _currentIndex,
              backgroundColor: Colors.white,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_bag_outlined),
                  selectedIcon: Icon(Icons.shopping_bag),
                  label: 'Shop',
                ),
                NavigationDestination(
                  icon: Icon(Icons.medical_services_outlined),
                  selectedIcon: Icon(Icons.medical_services),
                  label: 'Vets',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Learn',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
