import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/loading/loading_widget.dart';
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
                  Text(
                    'Welcome to',
                    style:
                        AppTextStyles.bodyText1.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ExplorePH',
                    style:
                        AppTextStyles.headline2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover the beauty of the Philippines',
                    style: AppTextStyles.bodyText2
                        .copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Features section
            Text(
              'Features',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            // Feature cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.explore,
                  title: 'Explore',
                  description: 'Find amazing destinations',
                  color: AppColors.primary,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.favorite,
                  title: 'Favorites',
                  description: 'Save your favorite places',
                  color: AppColors.accent,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.map,
                  title: 'Maps',
                  description: 'Navigate with ease',
                  color: AppColors.secondary,
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.camera_alt,
                  title: 'Gallery',
                  description: 'View beautiful photos',
                  color: AppColors.info,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action buttons
            Text(
              'Quick Actions',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Start Exploring',
                    onPressed: () {
                      ToastHelper.showSuccessToast(
                        message: 'Exploration feature coming soon!',
                      );
                    },
                    icon: const Icon(Icons.explore, size: 18),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Learn More',
                    type: ButtonType.outlined,
                    onPressed: () {
                      ToastHelper.showInfoToast(
                        message: 'Discover more about ExplorePH',
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Loading demo section
            Text(
              'Loading Indicators',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            const LoadingWidget(size: 40),

            const SizedBox(height: 24),

            // Theme showcase
            Text(
              'Theme Showcase',
              style: AppTextStyles.headline4,
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Urbanist Font Family',
                    style: AppTextStyles.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This app uses the Urbanist font family throughout the interface for a modern, clean look.',
                    style: AppTextStyles.bodyText2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Color Palette',
                    style: AppTextStyles.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColorChip(AppColors.primary, 'Primary'),
                      const SizedBox(width: 8),
                      _buildColorChip(AppColors.secondary, 'Secondary'),
                      const SizedBox(width: 8),
                      _buildColorChip(AppColors.accent, 'Accent'),
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

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.subtitle1,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              description,
              style: AppTextStyles.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorChip(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
