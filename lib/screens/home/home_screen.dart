import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../utils/toast/toast_helper.dart';
import '../../widgets/category/category_chip.dart';
import '../subcategory/subcategory_detail_screen.dart';
import '../search/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String? selectedCategory;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Floating Search Bar Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Floating Search Bar
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _openSearchPage(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Search destinations, hotels...',
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.sliders,
                                  size: 12,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Notification Button
                    GestureDetector(
                      onTap: () {
                        ToastHelper.showInfoToast(
                          message: 'Notifications coming soon!',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bell,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Welcome Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
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
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: AppTextStyles.bodyText1.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ExplorePH',
                      style: AppTextStyles.headline2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your gateway to Philippine tourism',
                      style: AppTextStyles.bodyText2.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Categories Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Main Categories',
                      style: AppTextStyles.headline4,
                    ),
                    const SizedBox(height: 16),
                    // Category Chips
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children:
                          CategoryConstants.mainCategories.map((category) {
                        return CategoryChip(
                          label: category,
                          isSelected: selectedCategory == category,
                          onTap: () => _onCategorySelected(category),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Subcategories Section
            if (selectedCategory != null &&
                CategoryConstants.subcategories.containsKey(selectedCategory))
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedCategory!,
                                      style: AppTextStyles.headline4,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: _clearSelection,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (CategoryConstants.categoryDescriptions
                                  .containsKey(selectedCategory))
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Text(
                                    CategoryConstants.categoryDescriptions[
                                        selectedCategory]!,
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              // Subcategory Cards
                              ...CategoryConstants
                                  .subcategories[selectedCategory]!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final subcategory = entry.value;
                                return SubcategoryCard(
                                  title: subcategory,
                                  icon: CategoryConstants
                                      .subcategoryIcons[subcategory],
                                  index: index,
                                  onTap: () =>
                                      _onSubcategoryTapped(subcategory),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      if (selectedCategory == category) {
        _clearSelection();
      } else {
        selectedCategory = category;
        _slideController.forward();
        _fadeController.forward();
      }
    });
  }

  void _clearSelection() {
    _slideController.reverse();
    _fadeController.reverse().then((_) {
      setState(() {
        selectedCategory = null;
      });
    });
  }

  void _onSubcategoryTapped(String subcategory) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SubcategoryDetailScreen(
          categoryName: selectedCategory!,
          subcategoryName: subcategory,
        ),
      ),
    );
  }

  void _openSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
      ),
    );
  }
}
