import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../utils/images/image_helper.dart';
import '../../widgets/listing/listing_card_v2.dart';
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

  // Featured destinations with images (v2 format)
  final List<Map<String, dynamic>> featuredDestinations = [
    {
      'name': 'Palawan Paradise Resort',
      'location': 'El Nido, Palawan',
      'city': 'El Nido',
      'province': 'Palawan',
      'image':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=600',
      'priceRange': '₱3,500 - ₱8,000',
      'highlight': 'Beachfront with stunning sunset views',
      'rating': 4.9,
      'reviews': 2341,
      'category': 'Islands',
      'hashtags': ['beach', 'island', 'resort', 'featured'],
    },
    {
      'name': 'Chocolate Hills Adventure',
      'location': 'Carmen, Bohol',
      'city': 'Carmen',
      'province': 'Bohol',
      'image':
          'https://images.unsplash.com/photo-1570789210967-2cac24634872?w=600',
      'priceRange': '₱500 - ₱1,500',
      'highlight': 'UNESCO World Heritage Site',
      'rating': 4.8,
      'reviews': 1892,
      'category': 'Mountain',
      'hashtags': ['nature', 'landmark', 'adventure'],
    },
    {
      'name': 'Mayon Volcano View',
      'location': 'Legazpi, Albay',
      'city': 'Legazpi',
      'province': 'Albay',
      'image':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=600',
      'priceRange': '₱200 - ₱800',
      'highlight': 'Perfect cone volcano view',
      'rating': 4.9,
      'reviews': 3102,
      'category': 'Mountain',
      'hashtags': ['volcano', 'nature', 'scenic'],
    },
    {
      'name': 'Boracay White Beach',
      'location': 'Malay, Aklan',
      'city': 'Malay',
      'province': 'Aklan',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
      'priceRange': '₱2,000 - ₱15,000',
      'highlight': 'World-famous white sand beach',
      'rating': 4.7,
      'reviews': 5234,
      'category': 'Beach',
      'hashtags': ['beach', 'nightlife', 'watersports'],
    },
    {
      'name': 'Kawasan Falls',
      'location': 'Badian, Cebu',
      'city': 'Badian',
      'province': 'Cebu',
      'image':
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600',
      'priceRange': '₱300 - ₱1,200',
      'highlight': 'Turquoise blue waterfalls',
      'rating': 4.8,
      'reviews': 2156,
      'category': 'Falls',
      'hashtags': ['waterfall', 'canyoneering', 'adventure'],
    },
    {
      'name': 'Banaue Rice Terraces',
      'location': 'Banaue, Ifugao',
      'city': 'Banaue',
      'province': 'Ifugao',
      'image':
          'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=600',
      'priceRange': '₱1,500 - ₱3,500',
      'highlight': '8th Wonder of the World',
      'rating': 4.9,
      'reviews': 1890,
      'category': 'Mountain',
      'hashtags': ['heritage', 'trekking', 'culture'],
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
                    selectedSubcategory == null
                        ? 'Featured Destinations'
                        : 'Featured ${selectedSubcategory!}',
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

          // Featured Destinations Grid (v2)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final filteredDestinations = selectedSubcategory == null
                      ? featuredDestinations
                      : featuredDestinations
                          .where((d) => d['category'] == selectedSubcategory)
                          .toList();

                  if (index >= filteredDestinations.length) return null;
                  final item = filteredDestinations[index];

                  return ListingCardV2(
                    name: item['name'],
                    location: item['location'],
                    city: item['city'] ?? '',
                    province: item['province'] ?? '',
                    imageUrl: item['image'],
                    priceRange: item['priceRange'],
                    highlight: item['highlight'],
                    rating: item['rating'],
                    reviews: item['reviews'],
                    hashtags: List<String>.from(item['hashtags'] ?? []),
                    onAddToItinerary: () => _handleAddToItinerary(item),
                    onAddToBucketList: () => _handleAddToBucketList(item),
                    onShare: () => _showShareDialog(item['name']),
                    onViewDetails: () {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.primary.withOpacity(0.3),
                    child: const FaIcon(
                      FontAwesomeIcons.image,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddToItinerary(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const FaIcon(FontAwesomeIcons.circleCheck,
                color: Colors.white, size: 16),
            const SizedBox(width: 10),
            Expanded(child: Text('${item['name']} added to Itinerary')),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleAddToBucketList(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const FaIcon(FontAwesomeIcons.circleCheck,
                color: Colors.white, size: 16),
            const SizedBox(width: 10),
            Expanded(child: Text('${item['name']} added to Bucket List')),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
