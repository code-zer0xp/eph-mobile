import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../subcategory/subcategory_detail_screen.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  final List<String> subcategories =
      CategoryConstants.subcategories['Services'] ?? [];

  // Featured services
  final List<Map<String, dynamic>> featuredServices = [
    {
      'name': 'Island Hopper Tours',
      'description': 'Premium island hopping experiences',
      'image':
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=600',
      'rating': 4.9,
      'reviews': 1234,
      'category': 'Travel and Tour Agency',
      'verified': true,
    },
    {
      'name': 'Cebu Pacific',
      'description': 'Affordable flights nationwide',
      'image':
          'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=600',
      'rating': 4.5,
      'reviews': 8765,
      'category': 'Air Tourist Transport',
      'verified': true,
    },
    {
      'name': 'Juan Tours',
      'description': 'Local expert guides',
      'image':
          'https://images.unsplash.com/photo-1527631746610-bca00a040d60?w=600',
      'rating': 4.8,
      'reviews': 567,
      'category': 'Regional Tour Guide',
      'verified': true,
    },
    {
      'name': 'Ferry Express PH',
      'description': 'Fast & safe ferry services',
      'image':
          'https://images.unsplash.com/photo-1544551763-77ef2d0cfc6c?w=600',
      'rating': 4.6,
      'reviews': 2341,
      'category': 'Water Tourist Transport',
      'verified': false,
    },
    {
      'name': 'Victory Liner',
      'description': 'Comfortable bus travel',
      'image':
          'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=600',
      'rating': 4.4,
      'reviews': 5678,
      'category': 'Land Tourist Transport',
      'verified': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Services',
                style: AppTextStyles.headline4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800',
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
                          AppColors.primary.withOpacity(0.9),
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
            ],
          ),

          // Service Categories Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you need?',
                    style: AppTextStyles.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: subcategories.length,
                    itemBuilder: (context, index) {
                      return _buildServiceCategory(subcategories[index]);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Featured Services
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Services',
                    style: AppTextStyles.headline4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
          ),

          // Services List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = featuredServices[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildServiceCard(service),
                  );
                },
                childCount: featuredServices.length,
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

  Widget _buildServiceCategory(String name) {
    final icons = {
      'Travel and Tour Agency': FontAwesomeIcons.earthAsia,
      'Travel Agency': FontAwesomeIcons.plane,
      'Land Tourist Transport': FontAwesomeIcons.bus,
      'Water Tourist Transport': FontAwesomeIcons.ship,
      'Air Tourist Transport': FontAwesomeIcons.planeDeparture,
      'MICE Organizer': FontAwesomeIcons.calendarCheck,
      'Regional Tour Guide': FontAwesomeIcons.personWalkingLuggage,
      'Community Guide': FontAwesomeIcons.peopleGroup,
    };

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryDetailScreen(
              categoryName: 'Services',
              subcategoryName: name,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icons[name] ?? FontAwesomeIcons.bellConcierge,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryDetailScreen(
              categoryName: 'Services',
              subcategoryName: service['category'],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    service['image'],
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 140,
                      color: AppColors.primary.withOpacity(0.3),
                      child: const Icon(Icons.business,
                          color: Colors.white54, size: 48),
                    ),
                  ),
                ),
                if (service['verified'])
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.circleCheck,
                              color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => _showShareDialog(service['name']),
                      child: FaIcon(
                        FontAwesomeIcons.shareNodes,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          service['name'],
                          style: AppTextStyles.headline4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.solidStar,
                              size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${service['rating']}',
                            style: AppTextStyles.bodyText2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service['description'],
                    style: AppTextStyles.bodyText2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          service['category'],
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${service['reviews']} reviews',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
