import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/listing/listing_card.dart';
import '../subcategory/subcategory_detail_screen.dart';

class DestinationsTab extends StatefulWidget {
  const DestinationsTab({super.key});

  @override
  State<DestinationsTab> createState() => _DestinationsTabState();
}

class _DestinationsTabState extends State<DestinationsTab> {
  String? selectedSubcategory;
  final ScrollController _scrollController = ScrollController();

  final List<String> subcategories =
      CategoryConstants.subcategories['Destinations'] ?? [];

  // Featured destinations with images
  final List<Map<String, dynamic>> featuredDestinations = [
    {
      'name': 'Palawan Paradise',
      'location': 'El Nido, Palawan',
      'image':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=600',
      'rating': 4.9,
      'reviews': 2341,
      'category': 'Islands',
    },
    {
      'name': 'Chocolate Hills',
      'location': 'Bohol',
      'image':
          'https://images.unsplash.com/photo-1570789210967-2cac24634872?w=600',
      'rating': 4.8,
      'reviews': 1892,
      'category': 'Mountain',
    },
    {
      'name': 'Mayon Volcano',
      'location': 'Albay, Bicol',
      'image':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=600',
      'rating': 4.9,
      'reviews': 3102,
      'category': 'Mountain',
    },
    {
      'name': 'Boracay White Beach',
      'location': 'Aklan',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
      'rating': 4.7,
      'reviews': 5234,
      'category': 'Beach',
    },
    {
      'name': 'Kawasan Falls',
      'location': 'Cebu',
      'image':
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600',
      'rating': 4.8,
      'reviews': 2156,
      'category': 'Falls',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Hero Header
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Destinations',
                style: AppTextStyles.headline4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=800',
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
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass,
                    color: Colors.white, size: 18),
                onPressed: () {},
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.filter,
                    color: Colors.white, size: 18),
                onPressed: () {},
              ),
            ],
          ),

          // Subcategory Chips
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  final isSelected = selectedSubcategory == subcategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(subcategory),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSubcategory = selected ? subcategory : null;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primary.withOpacity(0.2),
                      checkmarkColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.lightGrey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Featured Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Destinations',
                    style: AppTextStyles.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Featured Destinations Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final destination = featuredDestinations[index];
                  final filteredDestinations = selectedSubcategory == null
                      ? featuredDestinations
                      : featuredDestinations
                          .where((d) => d['category'] == selectedSubcategory)
                          .toList();

                  if (index >= filteredDestinations.length) return null;
                  final item = filteredDestinations[index];

                  return ListingCard(
                    name: item['name'],
                    location: item['location'],
                    imageUrl: item['image'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubcategoryDetailScreen(
                            categoryName: 'Destinations',
                            subcategoryName: item['category'],
                          ),
                        ),
                      );
                    },
                    onShare: () => _showShareDialog(item['name']),
                  );
                },
                childCount: selectedSubcategory == null
                    ? featuredDestinations.length
                    : featuredDestinations
                        .where((d) => d['category'] == selectedSubcategory)
                        .length,
              ),
            ),
          ),

          // Popular Categories
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                'Explore by Category',
                style: AppTextStyles.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= subcategories.length) return null;
                  final subcategory = subcategories[index];
                  final imageUrl = CategoryConstants
                          .subcategoryImages[subcategory] ??
                      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400';

                  return _buildCategoryCard(subcategory, imageUrl);
                },
                childCount: subcategories.length > 9 ? 9 : subcategories.length,
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

  Widget _buildCategoryCard(String name, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryDetailScreen(
              categoryName: 'Destinations',
              subcategoryName: name,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primary.withOpacity(0.3),
                  child: const Icon(Icons.image, color: Colors.white54),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
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
            Text(
              'Share $name',
              style: AppTextStyles.headline4,
            ),
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
                    FontAwesomeIcons.link, 'Copy Link', AppColors.primary),
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: FaIcon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
