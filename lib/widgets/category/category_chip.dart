import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppTextStyles.bodyText2.copyWith(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubcategoryCard extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback? onTap;
  final int index;

  const SubcategoryCard({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.lightGrey.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconData(icon),
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore ${title.toLowerCase()} destinations',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textLight,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      // Cultural
      case 'church':
        return Icons.church;
      case 'museum':
        return Icons.museum;
      case 'account_balance':
        return Icons.account_balance;
      case 'celebration':
        return Icons.celebration;
      case 'home':
        return Icons.home;
      // Natural
      case 'beach_access':
        return Icons.beach_access;
      case 'terrain':
        return Icons.terrain;
      case 'water':
        return Icons.water;
      case 'landscape':
        return Icons.landscape;
      case 'sailing':
        return Icons.sailing;
      // Adventure
      case 'cable':
        return Icons.cable;
      case 'rafting':
        return Icons.waves;
      case 'hiking':
        return Icons.hiking;
      case 'surfing':
        return Icons.surfing;
      case 'scuba_diving':
        return Icons.scuba_diving;
      // Man-made
      case 'apartment':
        return Icons.apartment;
      // Shopping
      case 'shopping_bag':
        return Icons.shopping_bag;
      // Resorts
      case 'pool':
        return Icons.pool;
      // Agri-Tourism
      case 'agriculture':
        return Icons.agriculture;
      // Facilities
      case 'hotel':
        return Icons.hotel;
      case 'bed':
        return Icons.bed;
      case 'restaurant':
        return Icons.restaurant;
      case 'store':
        return Icons.store;
      case 'business_center':
        return Icons.business_center;
      case 'night_shelter':
        return Icons.night_shelter;
      case 'free_breakfast':
        return Icons.free_breakfast;
      case 'cottage':
        return Icons.cottage;
      case 'garage':
        return Icons.garage;
      case 'villa':
        return Icons.villa;
      // Services
      case 'travel_explore':
        return Icons.travel_explore;
      case 'flight':
        return Icons.flight;
      case 'directions_bus':
        return Icons.directions_bus;
      case 'directions_boat':
        return Icons.directions_boat;
      case 'flight_takeoff':
        return Icons.flight_takeoff;
      case 'event':
        return Icons.event;
      case 'tour':
        return Icons.tour;
      case 'groups':
        return Icons.groups;
      default:
        return Icons.category;
    }
  }
}
