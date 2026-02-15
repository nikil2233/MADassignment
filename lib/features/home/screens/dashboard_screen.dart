import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/features/shop/screens/shop_screen.dart';
import 'package:pet_care_app/features/vets/screens/vets_screen.dart';
import 'package:pet_care_app/features/education/screens/education_screen.dart';
import 'package:pet_care_app/features/home/screens/home_screen.dart';
import 'package:pet_care_app/features/vets/screens/vet_appointments_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String? _userRole;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (mounted) {
        setState(() {
          _userRole = doc.data()?['role'];
          _isLoading = false;
        });
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isVet = _userRole == 'vet';

    final List<Widget> screens = [
      HomeScreen(
        userRole: _userRole,
        onShopTap: () => setState(() => _currentIndex = 1),
        onVetTap: () => setState(() => _currentIndex = 2), // Normalized
        onEducationTap: () => setState(() => _currentIndex = 3),
      ),
      const ShopScreen(),
      if (isVet) const VetAppointmentsScreen() else const VetsScreen(),
      const EducationScreen(),
    ];

    final destinations = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.shopping_bag_outlined),
        selectedIcon: Icon(Icons.shopping_bag),
        label: 'Shop',
      ),
      if (isVet)
        const NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(Icons.calendar_today),
          label: 'Appointments',
        )
      else
        const NavigationDestination(
          icon: Icon(Icons.medical_services_outlined),
          selectedIcon: Icon(Icons.medical_services),
          label: 'Vets',
        ),
      const NavigationDestination(
        icon: Icon(Icons.school_outlined),
        selectedIcon: Icon(Icons.school),
        label: 'Learn',
      ),
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
              color: Colors.black.withValues(alpha: 0.1),
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
              indicatorColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.1),
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
              destinations: destinations,
            ),
          ),
        ),
      ),
    );
  }
}
