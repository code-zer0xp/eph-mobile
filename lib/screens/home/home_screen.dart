import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/common/custom_button.dart';
import '../../utils/images/image_helper.dart';
import '../../utils/toast/toast_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ExplorePH',
          style: AppTextStyles.headline5.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ImageHelper.appLogoWidget(
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, Traveler',
                            style: AppTextStyles.subtitle2
                                .copyWith(color: Colors.white70),
                          ),
                          Text(
                            'Where do you want to go?',
                            style: AppTextStyles.headline5
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover curated stays, hidden gems, and experiences across the Philippines.',
                    style: AppTextStyles.bodyText2
                        .copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Features section
            Text(
              'Search destinations',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for cities, islands, or experiences',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.tune),
              ),
            ),
            const SizedBox(height: 24),

            // Feature cards
            Text(
              'Top categories',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip(context, Icons.hotel, 'Stays'),
                  _buildCategoryChip(
                      context, Icons.directions_walk, 'Experiences'),
                  _buildCategoryChip(context, Icons.tour, 'Tours'),
                  _buildCategoryChip(context, Icons.restaurant, 'Food'),
                  _buildCategoryChip(
                      context, Icons.directions_bus, 'Transport'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Text(
              'Popular destinations',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _popularDestinations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final destination = _popularDestinations[index];
                  return _buildDestinationCard(destination);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Theme showcase
            Text(
              'Quick actions',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Start exploring',
                    onPressed: () {
                      ToastHelper.showSuccessToast(
                        message: 'Destination search coming soon!',
                      );
                    },
                    icon: const Icon(Icons.explore, size: 18),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'View saved trips',
                    type: ButtonType.outlined,
                    onPressed: () {
                      ToastHelper.showInfoToast(
                        message: 'Trip planner coming soon!',
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyles.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: _buildFeatureCard(
        context,
        icon: icon,
        title: label,
        description: '',
        color: AppColors.primary,
      ),
    );
  }

  static final List<_Destination> _popularDestinations = [
    _Destination(
      name: 'Palawan',
      location: 'El Nido • Coron',
      tag: 'Island escape',
    ),
    _Destination(
      name: 'Cebu',
      location: 'Cebu City • Moalboal',
      tag: 'City & sea',
    ),
    _Destination(
      name: 'Baguio',
      location: 'Benguet',
      tag: 'Cool highlands',
    ),
  ];

  Widget _buildDestinationCard(_Destination destination) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: ImageHelper.loadImage(
                ImageHelper.placeholder,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.name,
                    style: AppTextStyles.subtitle1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.location,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      destination.tag,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Destination {
  final String name;
  final String location;
  final String tag;

  const _Destination({
    required this.name,
    required this.location,
    required this.tag,
  });
}
