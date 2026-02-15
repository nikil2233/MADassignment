import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/features/vets/models/vet.dart';
import 'package:pet_care_app/features/profile/screens/profile_screen.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care_app/features/education/screens/create_article_screen.dart';

import 'package:pet_care_app/features/shop/screens/add_product_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onShopTap;
  final VoidCallback onVetTap;
  final VoidCallback onEducationTap;
  final String? userRole;

  const HomeScreen({
    super.key,
    required this.onShopTap,
    required this.onVetTap,
    required this.onEducationTap,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    bool isVet = userRole == 'vet';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom App Bar with Greeting
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: GoogleFonts.dmSans(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          isVet ? 'Vet 👋' : 'Pet Lover 👋',
                          style: GoogleFonts.dmSans(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar (Floating)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2D3047).withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for pets, vets, food...',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Hero Banner
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D3047), Color(0xFF45496E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2D3047).withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(
                            Icons.pets,
                            size: 200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isVet)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE07A5F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'PROMO 20% OFF',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            if (!isVet) const Spacer(),
                            Text(
                              isVet
                                  ? 'Expand Your\nBusiness'
                                  : 'Premium Food\nFor Your Pet',
                              style: GoogleFonts.dmSans(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: isVet
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddProductScreen(),
                                        ),
                                      );
                                    }
                                  : onShopTap,
                              child: Row(
                                children: [
                                  Text(
                                    isVet ? 'List a Product' : 'Shop Now',
                                    style: GoogleFonts.dmSans(
                                      color: const Color(0xFF81B29A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xFF81B29A),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 0,
                        child: Image.network(
                          'https://ouch-cdn2.icons8.com/6k2-1rGZ_2x2_2x2/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNDUy/Lzc0ZDI4ZDM4LTc0/ODMtNDQ2Ni1hNTQ4/LTQzMzQyZGM2M2Mx/NS5wbmc.png',
                          height: 160,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Categories Section
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildCategoryPill(
                      context,
                      isVet ? 'List Product' : 'Shopping',
                      isVet
                          ? Icons.add_business_outlined
                          : Icons.shopping_bag_outlined,
                      const Color(0xFFE07A5F),
                      isVet
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddProductScreen(),
                                ),
                              );
                            }
                          : onShopTap,
                    ),
                    if (userRole != 'vet')
                      _buildCategoryPill(
                        context,
                        'Vets',
                        Icons.medical_services_outlined,
                        const Color(0xFF81B29A),
                        onVetTap,
                      ),
                    _buildCategoryPill(
                      context,
                      isVet ? 'Post Article' : 'Learn',
                      isVet ? Icons.post_add_outlined : Icons.school_outlined,
                      const Color(0xFFF2CC8F),
                      isVet
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateArticleScreen(),
                                ),
                              );
                            }
                          : onEducationTap,
                    ),
                    if (!isVet)
                      _buildCategoryPill(
                        context,
                        'Grooming',
                        Icons.content_cut_outlined,
                        const Color(0xFF3D405B),
                        () {},
                      ),
                  ],
                ),
              ),
            ),

            // Featured Vets
            if (userRole != 'vet') ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Vets',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: onVetTap,
                        child: Text(
                          'See All',
                          style: GoogleFonts.dmSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('role', isEqualTo: 'vet')
                    .limit(3)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }

                  final vets = snapshot.data!.docs;

                  if (vets.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text("No vets registered yet."),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final data = vets[index].data() as Map<String, dynamic>;
                        final vet = Vet(
                          id: vets[index].id,
                          name: data['name'] ?? 'Unknown',
                          clinicName: data['clinicName'] ?? 'Clinic',
                          specialty: data['specialty'] ?? 'General',
                          rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
                          distance:
                              (data['distance'] as num?)?.toDouble() ?? 0.0,
                          imageUrl:
                              data['imageUrl'] ?? 'https://placehold.co/150',
                          profileBase64: data['profileBase64'],
                          reviews: data['reviews'] ?? 0,
                          acceptedAnimals: List<String>.from(
                            data['acceptedAnimals'] ?? [],
                          ),
                        );

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Builder(
                                  builder: (context) {
                                    if (vet.profileBase64 != null) {
                                      try {
                                        return Image.memory(
                                          base64Decode(vet.profileBase64!),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.person,
                                                    ),
                                                  ),
                                        );
                                      } catch (e) {
                                        // fallthrough
                                      }
                                    }
                                    return Image.network(
                                      vet.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.person),
                                              ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vet.name,
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      vet.specialty,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: const Color(0xFFF2CC8F),
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          vet.rating.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(${vet.reviews} reviews)',
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: vets.length),
                    ),
                  );
                },
              ),
            ],
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 80,
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
