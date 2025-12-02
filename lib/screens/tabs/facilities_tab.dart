import 'package:exploreph/utils/images/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../subcategory/subcategory_detail_screen.dart';

class FacilitiesTab extends StatefulWidget {
  const FacilitiesTab({super.key});

  @override
  State<FacilitiesTab> createState() => _FacilitiesTabState();
}

class _FacilitiesTabState extends State<FacilitiesTab> {
  String? selectedSubcategory;

  final List<String> subcategories =
      CategoryConstants.subcategories['Facilities'] ?? [];

  // Featured facilities with images
  final List<Map<String, dynamic>> featuredFacilities = [
    {
      'name': 'Makati Shangri-La',
      'location': 'Makati City',
      'image':
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=600',
      'rating': 4.9,
      'reviews': 3421,
      'category': 'Hotel',
      'price': '₱12,500/night',
    },
    {
      'name': 'Boracay Regency',
      'location': 'Boracay, Aklan',
      'image':
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=600',
      'rating': 4.7,
      'reviews': 2156,
      'category': 'Resorts',
      'price': '₱8,900/night',
    },
    {
      'name': 'Casa San Pablo',
      'location': 'Laguna',
      'image':
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=600',
      'rating': 4.8,
      'reviews': 892,
      'category': 'Bread and Breakfast',
      'price': '₱3,500/night',
    },
    {
      'name': 'Gallery by Chele',
      'location': 'Taguig City',
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600',
      'rating': 4.9,
      'reviews': 1234,
      'category': 'Restaurant',
      'price': '₱₱₱',
    },
    {
      'name': 'Z Hostel',
      'location': 'Makati City',
      'image':
          'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=600',
      'rating': 4.5,
      'reviews': 567,
      'category': 'Hostels',
      'price': '₱850/night',
    },
    {
      'name': 'The Peninsula Manila',
      'location': 'Makati City',
      'image':
          'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=600',
      'rating': 4.9,
      'reviews': 4567,
      'category': 'Hotel',
      'price': '₱15,000/night',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverAppBar(
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'ExplorePH',
                style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Bold',
                    fontSize: 18),
              ),
            ),
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.primary.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(ImageHelper.profilePlaceholder),
                ),
              ),
            ],
          ),

          // Subcategory Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  final isSelected = selectedSubcategory == subcategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(subcategory),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSubcategory = selected ? subcategory : null;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Featured Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Rated',
                    style: AppTextStyles.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 12),
                    label: const Text('View All'),
                  ),
                ],
              ),
            ),
          ),

          // Facilities List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final filteredFacilities = selectedSubcategory == null
                      ? featuredFacilities
                      : featuredFacilities
                          .where((f) => f['category'] == selectedSubcategory)
                          .toList();

                  if (index >= filteredFacilities.length) return null;
                  final facility = filteredFacilities[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildFacilityCard(facility),
                  );
                },
                childCount: selectedSubcategory == null
                    ? featuredFacilities.length
                    : featuredFacilities
                        .where((f) => f['category'] == selectedSubcategory)
                        .length,
              ),
            ),
          ),

          // Categories Grid Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text(
                'Browse by Type',
                style: AppTextStyles.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= subcategories.length) return null;
                  final subcategory = subcategories[index];
                  return _buildCategoryItem(subcategory);
                },
                childCount: subcategories.length > 8 ? 8 : subcategories.length,
              ),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          FaIcon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard(Map<String, dynamic> facility) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryDetailScreen(
              categoryName: 'Facilities',
              subcategoryName: facility['category'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(
                facility['image'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 120,
                  color: AppColors.primary.withOpacity(0.3),
                  child:
                      const Icon(Icons.hotel, color: Colors.white54, size: 40),
                ),
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            facility['name'],
                            style: AppTextStyles.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.shareNodes,
                              size: 16),
                          onPressed: () => _showShareDialog(facility['name']),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.locationDot,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          facility['location'],
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.solidStar,
                            size: 12, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${facility['rating']}',
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (${facility['reviews']} reviews)',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            facility['category'],
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          facility['price'],
                          style: AppTextStyles.bodyText2.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String name) {
    final imageUrl = CategoryConstants.subcategoryImages[name] ??
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryDetailScreen(
              categoryName: 'Facilities',
              subcategoryName: name,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primary.withOpacity(0.3),
                  child:
                      const Icon(Icons.hotel, color: Colors.white54, size: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showShareDialog(String name) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text('Share $name', style: AppTextStyles.headline4),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(FontAwesomeIcons.facebook, 'Facebook',
                    const Color(0xFF1877F2)),
                _buildShareOption(FontAwesomeIcons.twitter, 'Twitter',
                    const Color(0xFF1DA1F2)),
                _buildShareOption(FontAwesomeIcons.whatsapp, 'WhatsApp',
                    const Color(0xFF25D366)),
                _buildShareOption(
                    FontAwesomeIcons.link, 'Copy', AppColors.primary),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: FaIcon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
