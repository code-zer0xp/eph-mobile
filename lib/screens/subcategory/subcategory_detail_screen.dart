import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/category_constants.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../utils/toast/toast_helper.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/loading/loading_widget.dart';
import '../destination/destination_detail_screen.dart';

class SubcategoryDetailScreen extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;

  const SubcategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.subcategoryName,
  });

  @override
  State<SubcategoryDetailScreen> createState() =>
      _SubcategoryDetailScreenState();
}

class _SubcategoryDetailScreenState extends State<SubcategoryDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _searchController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _searchAnimation;
  bool _isLoading = false;
  bool _isSearching = false;
  bool _isFavorite = false;
  final TextEditingController _searchTextController = TextEditingController();
  String _selectedFilter = 'All';
  String _selectedSort = 'Popular';
  final ScrollController _scrollController = ScrollController();
  final List<String> _filters = [
    'All',
    'Popular',
    'Nearby',
    'Top Rated',
    'New'
  ];
  final List<String> _sortOptions = ['Popular', 'Distance', 'Rating', 'Price'];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _searchAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _searchController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    _searchTextController.dispose();
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
          // Enhanced Custom App Bar with Parallax Effect
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final collapsedHeight =
                    kToolbarHeight + MediaQuery.of(context).padding.top;
                final expandRatio =
                    ((top - collapsedHeight) / (280 - collapsedHeight))
                        .clamp(0.0, 1.0);

                return FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Animated Hero Image with Parallax
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.translationValues(
                            0, (1 - expandRatio) * 30, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryDark,
                                AppColors.primaryLight,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  _getSubcategoryIcon(),
                                  size: 80 + (expandRatio * 40),
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              // Animated overlay pattern
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment.center,
                                      radius: expandRatio * 1.5,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(
                                            0.1 * (1 - expandRatio)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Dynamic Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black
                                  .withOpacity(0.2 + (0.1 * (1 - expandRatio))),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            title: AnimatedOpacity(
              opacity: _fadeAnimation.value,
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.subcategoryName,
                style: AppTextStyles.headline5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              AnimatedBuilder(
                animation: _searchAnimation,
                builder: (context, child) {
                  return IconButton(
                    icon: Icon(
                      _isSearching ? Icons.close : Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: _toggleSearch,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  ToastHelper.showInfoToast(
                    message: 'Share feature coming soon!',
                  );
                },
              ),
            ],
          ),

          // Search Bar (appears when search is active)
          if (_isSearching)
            SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchTextController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText:
                              'Search ${widget.subcategoryName.toLowerCase()}...',
                          border: InputBorder.none,
                          hintStyle: AppTextStyles.bodyText2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        style: AppTextStyles.bodyText2,
                        onChanged: (value) {
                          // Implement search logic
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchTextController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),

          // Filter and Sort Section
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Filter Chips
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final isSelected = _selectedFilter == filter;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _selectFilter(filter),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.primary.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  filter,
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sort Options
                  Row(
                    children: [
                      Text(
                        'Sort by:',
                        style: AppTextStyles.bodyText2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSort,
                              isExpanded: true,
                              items: _sortOptions.map((sort) {
                                return DropdownMenuItem<String>(
                                  value: sort,
                                  child: Text(
                                    sort,
                                    style: AppTextStyles.bodyText2,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  _selectSort(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description Section
                      _buildSectionTitle('About ${widget.subcategoryName}'),
                      _buildDescriptionCard(),
                      const SizedBox(height: 24),

                      // Statistics
                      _buildStatisticsSection(),
                      const SizedBox(height: 24),

                      // Featured Destinations
                      _buildSectionTitle('Featured Destinations'),
                      _buildFeaturedDestinations(),
                      const SizedBox(height: 24),

                      // Popular Destinations Grid
                      _buildSectionTitle('Popular Destinations'),
                      _buildPopularDestinationsGrid(),
                      const SizedBox(height: 24),

                      // Quick Actions
                      _buildSectionTitle('Quick Actions'),
                      _buildQuickActions(),
                      const SizedBox(height: 24),

                      // Recent Reviews
                      _buildSectionTitle('Recent Reviews'),
                      _buildRecentReviews(),
                      const SizedBox(height: 24),

                      // Travel Tips
                      _buildSectionTitle('Travel Tips'),
                      _buildTravelTips(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            SliverFillRemaining(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const LoadingWidget(
                  message: 'Loading destinations...',
                ),
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTextStyles.headline4,
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getSubcategoryIcon(),
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subcategoryName,
                      style: AppTextStyles.subtitle1,
                    ),
                    Text(
                      widget.categoryName,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _getSubcategoryDescription(),
            style: AppTextStyles.bodyText2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDestinations() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DestinationDetailScreen(
                    destinationName: 'Destination ${index + 1}',
                    subcategoryName: widget.subcategoryName,
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.3),
                            AppColors.primaryDark.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white.withOpacity(0.5),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination ${index + 1}',
                            style: AppTextStyles.subtitle2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.${8 - index}',
                                style: AppTextStyles.caption,
                              ),
                              const Spacer(),
                              Text(
                                '${(index + 1) * 10} km',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
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
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'View Map',
            onPressed: () {
              ToastHelper.showInfoToast(
                message: 'Map view coming soon!',
              );
            },
            icon: const Icon(
              Icons.map,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'Get Directions',
            type: ButtonType.outlined,
            onPressed: () {
              ToastHelper.showInfoToast(
                message: 'Directions coming soon!',
              );
            },
            icon: const Icon(Icons.directions, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryLight.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('150+', 'Destinations'),
              _buildStatItem('4.8', 'Avg Rating'),
              _buildStatItem('50K+', 'Visitors'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.headline3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  IconData _getSubcategoryIcon() {
    final iconName = CategoryConstants.subcategoryIcons[widget.subcategoryName];
    switch (iconName) {
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
      case 'apartment':
        return Icons.apartment;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'pool':
        return Icons.pool;
      case 'agriculture':
        return Icons.agriculture;
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

  String _getSubcategoryDescription() {
    switch (widget.subcategoryName) {
      case 'Beach':
        return 'Discover the pristine beaches of the Philippines, from the famous white sands of Boracay to the hidden coves of Palawan. Experience world-class snorkeling, diving, and beach activities in tropical paradise.';
      case 'Mountain':
        return 'Explore the majestic mountain ranges of the Philippines, including the iconic Mount Mayon, Mount Pulag, and the Chocolate Hills. Perfect for hiking enthusiasts and nature lovers.';
      case 'Hotel':
        return 'Find the perfect accommodation for your stay, from luxury 5-star hotels to cozy boutique properties. Experience Filipino hospitality at its finest with modern amenities and exceptional service.';
      case 'Restaurant':
        return 'Savor the diverse flavors of Filipino cuisine and international dishes. From street food to fine dining, discover the best culinary experiences across the Philippines.';
      case 'Museum':
        return 'Immerse yourself in the rich cultural heritage of the Philippines through world-class museums. Learn about Filipino history, art, and traditions through interactive exhibits and collections.';
      case 'Historical Sites':
        return 'Step back in time and explore the historical landmarks that shaped the Philippines. From Spanish colonial churches to World War II memorials, discover the stories behind these significant sites.';
      default:
        return 'Explore the best ${widget.subcategoryName.toLowerCase()} destinations across the Philippines. Find amazing places, experiences, and services that showcase the beauty and culture of this beautiful archipelago.';
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _searchController.forward();
      } else {
        _searchController.reverse();
        _searchTextController.clear();
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    ToastHelper.showSuccessToast(
      message: _isFavorite ? 'Added to favorites!' : 'Removed from favorites',
    );
  }

  void _selectFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      _isLoading = true;
    });

    // Simulate filter application
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showSuccessToast(
        message: 'Applied filter: $filter',
      );
    });
  }

  void _selectSort(String sort) {
    setState(() {
      _selectedSort = sort;
      _isLoading = true;
    });

    // Simulate sort application
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showSuccessToast(
        message: 'Sorted by: $sort',
      );
    });
  }

  Widget _buildPopularDestinationsGrid() {
    final destinations = List.generate(
        6,
        (index) => {
              'name': 'Popular Destination ${index + 1}',
              'rating': 4.5 + (index % 3) * 0.3,
              'distance': '${(index + 1) * 5} km',
              'price': '\$${(index + 1) * 20}',
              'type': ['Beach', 'Mountain', 'City', 'Cultural'][index % 4],
            });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DestinationDetailScreen(
                    destinationName: destination['name'] as String,
                    subcategoryName: widget.subcategoryName,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.3),
                            AppColors.primaryDark.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white.withOpacity(0.5),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination['name'] as String,
                            style: AppTextStyles.subtitle2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                (destination['rating'] as double)
                                    .toStringAsFixed(1),
                                style: AppTextStyles.caption,
                              ),
                              const Spacer(),
                              Text(
                                destination['price'] as String,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primary,
                                size: 10,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                destination['distance'] as String,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
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
          ),
        );
      },
    );
  }

  Widget _buildRecentReviews() {
    final reviews = [
      {
        'name': 'Sarah Johnson',
        'rating': 5,
        'comment':
            'Amazing experience! The views were breathtaking and the staff was very helpful.',
        'date': '2 days ago',
        'destination': 'Destination 1',
      },
      {
        'name': 'Mike Chen',
        'rating': 4,
        'comment':
            'Great place to visit. Would definitely recommend to others.',
        'date': '1 week ago',
        'destination': 'Destination 2',
      },
    ];

    return Column(
      children: reviews.map((review) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              review['name'] as String,
                              style: AppTextStyles.bodyText2.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              review['date'] as String,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          review['destination'] as String,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < (review['rating'] as int)
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 12,
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                review['comment'] as String,
                style: AppTextStyles.bodyText2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTravelTips() {
    final tips = [
      {
        'icon': Icons.access_time,
        'title': 'Best Time to Visit',
        'description': 'Early morning or late afternoon for fewer crowds',
      },
      {
        'icon': Icons.camera_alt,
        'title': 'Photo Opportunities',
        'description': 'Golden hour provides the best lighting',
      },
      {
        'icon': Icons.local_offer,
        'title': 'What to Bring',
        'description': 'Comfortable shoes and water are essential',
      },
    ];

    return Column(
      children: tips.map((tip) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  tip['icon'] as IconData,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip['title'] as String,
                      style: AppTextStyles.bodyText2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tip['description'] as String,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _applyFilter(String filter) {
    setState(() {
      _isLoading = true;
    });

    // Simulate filter application
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      ToastHelper.showSuccessToast(
        message: 'Applied filter: $filter',
      );
    });
  }
}
