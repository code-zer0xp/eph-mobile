import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../utils/toast/toast_helper.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/loading/loading_widget.dart';

class DestinationDetailScreen extends StatefulWidget {
  final String destinationName;
  final String subcategoryName;

  const DestinationDetailScreen({
    super.key,
    required this.destinationName,
    required this.subcategoryName,
  });

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _heartController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _heartAnimation;
  bool _isFavorite = false;
  int _selectedImageIndex = 0;
  bool _isExpanded = false;
  bool _isLoadingReviews = false;
  bool _showFullDescription = false;
  final List<Map<String, dynamic>> _reviews = [];
  final ScrollController _scrollController = ScrollController();

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
    _heartController = AnimationController(
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
    _heartAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _heartController,
      curve: Curves.elasticOut,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _heartController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero Image Section with Parallax Effect
          SliverAppBar(
            expandedHeight: 350,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final collapsedHeight =
                    kToolbarHeight + MediaQuery.of(context).padding.top;
                final expandRatio =
                    ((top - collapsedHeight) / (350 - collapsedHeight))
                        .clamp(0.0, 1.0);

                return FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image Gallery with Parallax
                      PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            _selectedImageIndex = index;
                          });
                        },
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            transform: Matrix4.translationValues(
                                0, (1 - expandRatio) * 50, 0),
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
                                      Icons.landscape,
                                      color: Colors.white.withOpacity(0.3),
                                      size: 100 + (expandRatio * 50),
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
                          );
                        },
                      ),
                      // Dynamic Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black
                                  .withOpacity(0.2 + (0.2 * (1 - expandRatio))),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                      // Enhanced Image Indicators
                      Positioned(
                        bottom: 20 + (20 * (1 - expandRatio)),
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: expandRatio.clamp(0.0, 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _selectedImageIndex == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _selectedImageIndex == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: _selectedImageIndex == index
                                      ? [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              AnimatedBuilder(
                animation: _heartAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartAnimation.value,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        _heartController.forward().then((_) {
                          _heartController.reverse();
                        });
                        ToastHelper.showSuccessToast(
                          message: _isFavorite
                              ? 'Added to favorites!'
                              : 'Removed from favorites',
                        );
                      },
                    ),
                  );
                },
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
                      // Title and Rating
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.destinationName,
                                  style: AppTextStyles.headline3,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.primary,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.subcategoryName,
                                      style: AppTextStyles.bodyText2.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '4.8',
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Quick Info
                      _buildQuickInfo(),
                      const SizedBox(height: 24),

                      // Description
                      _buildSectionTitle('Description'),
                      _buildDescriptionCard(),
                      const SizedBox(height: 24),

                      // Highlights
                      _buildSectionTitle('Highlights'),
                      _buildHighlights(),
                      const SizedBox(height: 24),

                      // Amenities
                      _buildSectionTitle('Amenities'),
                      _buildAmenities(),
                      const SizedBox(height: 24),

                      // Weather Information
                      _buildSectionTitle('Weather'),
                      _buildWeatherCard(),
                      const SizedBox(height: 24),

                      // Reviews Section
                      _buildSectionTitle('Reviews'),
                      _buildReviewsSection(),
                      const SizedBox(height: 24),

                      // Nearby Attractions
                      _buildSectionTitle('Nearby Attractions'),
                      _buildNearbyAttractions(),
                      const SizedBox(height: 24),

                      // Visiting Tips
                      _buildSectionTitle('Visiting Tips'),
                      _buildVisitingTips(),
                      const SizedBox(height: 24),

                      // Location
                      _buildSectionTitle('Location'),
                      _buildLocationCard(),
                      const SizedBox(height: 24),

                      // Action Buttons
                      _buildActionButtons(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ToastHelper.showInfoToast(
            message: 'Booking feature coming soon!',
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.calendar_today),
        label: Text(
          'Book Now',
          style: AppTextStyles.button.copyWith(
            color: Colors.white,
          ),
        ),
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

  Widget _buildQuickInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            Icons.access_time,
            'Open Now',
            'Until 6 PM',
            AppColors.success,
          ),
          _buildInfoItem(
            Icons.phone,
            'Contact',
            '+123 456 789',
            AppColors.info,
          ),
          _buildInfoItem(
            Icons.directions_car,
            'Distance',
            '25 km',
            AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionCard() {
    final fullDescription =
        'Experience the beauty and wonder of ${widget.destinationName}, one of the most spectacular destinations in the Philippines. This amazing place offers breathtaking views, exciting activities, and unforgettable memories that will last a lifetime. Perfect for adventurers, families, and solo travelers alike. The destination features world-class facilities, professional guides, and a variety of activities suitable for all age groups. From thrilling adventures to peaceful relaxation, this place has something special for every visitor. The rich cultural heritage combined with natural beauty creates an unparalleled experience that will leave you wanting to return again and again.';

    final shortDescription =
        'Experience the beauty and wonder of ${widget.destinationName}, one of the most spectacular destinations in the Philippines. This amazing place offers breathtaking views, exciting activities, and unforgettable memories that will last a lifetime.';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
          Text(
            _showFullDescription ? fullDescription : shortDescription,
            style: AppTextStyles.bodyText2.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _showFullDescription = !_showFullDescription;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _showFullDescription ? 'Show less' : 'Read more',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedRotation(
                  turns: _showFullDescription ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights() {
    final highlights = [
      {'text': 'Breathtaking natural scenery', 'icon': Icons.landscape},
      {'text': 'Perfect for photography', 'icon': Icons.camera_alt},
      {'text': 'Family-friendly activities', 'icon': Icons.family_restroom},
      {'text': 'Professional guides available', 'icon': Icons.person},
      {'text': 'Accessible location', 'icon': Icons.accessible},
      {'text': 'Eco-friendly destination', 'icon': Icons.eco},
      {'text': 'Cultural experiences', 'icon': Icons.museum},
      {'text': 'Adventure activities', 'icon': Icons.hiking},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: highlights.asMap().entries.map((entry) {
        final index = entry.key;
        final highlight = entry.value;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeOutBack,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                highlight['icon'] as IconData,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                highlight['text'] as String,
                style: AppTextStyles.bodyText2.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmenities() {
    final amenities = [
      {'icon': Icons.wifi, 'label': 'Free WiFi', 'available': true},
      {'icon': Icons.local_parking, 'label': 'Parking', 'available': true},
      {'icon': Icons.restaurant, 'label': 'Restaurant', 'available': true},
      {'icon': Icons.local_bar, 'label': 'Bar', 'available': false},
      {'icon': Icons.pool, 'label': 'Swimming Pool', 'available': true},
      {
        'icon': Icons.fitness_center,
        'label': 'Fitness Center',
        'available': false
      },
      {'icon': Icons.spa, 'label': 'Spa', 'available': true},
      {
        'icon': Icons.local_hospital,
        'label': 'Medical Support',
        'available': true
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: amenities.length,
      itemBuilder: (context, index) {
        final amenity = amenities[index];
        final isAvailable = amenity['available'] as bool;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            border: isAvailable
                ? Border.all(color: AppColors.primary.withOpacity(0.2))
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                ToastHelper.showInfoToast(
                  message: isAvailable
                      ? '${amenity['label']} is available'
                      : '${amenity['label']} is currently unavailable',
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      amenity['icon'] as IconData,
                      color: isAvailable ? AppColors.primary : Colors.grey,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    amenity['label'] as String,
                    style: AppTextStyles.caption.copyWith(
                      color: isAvailable ? null : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationCard() {
    return Container(
      height: 200,
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
      child: Stack(
        children: [
          // Map placeholder
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primaryLight.withOpacity(0.05),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    color: AppColors.primary.withOpacity(0.5),
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Interactive Map',
                    style: AppTextStyles.bodyText1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Get Directions button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: () {
                ToastHelper.showInfoToast(
                  message: 'Directions coming soon!',
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.directions,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Primary Actions
        Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: CustomButton(
                  text: 'Call Now',
                  onPressed: () {
                    ToastHelper.showInfoToast(
                      message: 'Calling feature coming soon!',
                    );
                  },
                  icon: const Icon(
                    Icons.phone,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: CustomButton(
                  text: 'Save Trip',
                  type: ButtonType.outlined,
                  onPressed: () {
                    ToastHelper.showSuccessToast(
                      message: 'Trip saved successfully!',
                    );
                  },
                  icon: const Icon(Icons.bookmark, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Secondary Actions
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      ToastHelper.showInfoToast(
                        message: 'Website coming soon!',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.language,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Website',
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      ToastHelper.showInfoToast(
                        message: 'Directions coming soon!',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Directions',
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherCard() {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildWeatherItem(
            Icons.wb_sunny,
            'Today',
            '28°C',
            'Sunny',
            AppColors.warning,
          ),
          _buildWeatherItem(
            Icons.cloud,
            'Tomorrow',
            '26°C',
            'Cloudy',
            AppColors.info,
          ),
          _buildWeatherItem(
            Icons.wb_cloudy,
            'Wednesday',
            '24°C',
            'Partly Cloudy',
            AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherItem(
    IconData icon,
    String day,
    String temperature,
    String condition,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          day,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          temperature,
          style: AppTextStyles.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          condition,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      children: [
        // Overall Rating
        Container(
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
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    '4.8',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_half,
                        color: AppColors.warning,
                        size: 16,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '324 Reviews',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(5, 0.85),
                    _buildRatingBar(4, 0.10),
                    _buildRatingBar(3, 0.03),
                    _buildRatingBar(2, 0.01),
                    _buildRatingBar(1, 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Individual Reviews
        if (_isLoadingReviews)
          const Center(child: LoadingWidget())
        else
          Column(
            children: _reviews.isEmpty
                ? [
                    Container(
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
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.rate_review,
                              color: AppColors.primary.withOpacity(0.5),
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No reviews yet',
                              style: AppTextStyles.bodyText1.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Be the first to review this destination!',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
                : _reviews.map((review) => _buildReviewCard(review)).toList(),
          ),
        const SizedBox(height: 16),
        // Load More Reviews Button
        if (!_isLoadingReviews && _reviews.isNotEmpty)
          CustomButton(
            text: 'Load More Reviews',
            type: ButtonType.outlined,
            onPressed: _loadMoreReviews,
          ),
      ],
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: AppTextStyles.caption,
          ),
          const SizedBox(width: 8),
          const Icon(Icons.star, color: AppColors.warning, size: 12),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'] ?? 'Anonymous',
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < (review['rating'] as int)
                                ? Icons.star
                                : Icons.star_border,
                            color: AppColors.warning,
                            size: 12,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          review['date'] ?? '2 days ago',
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
          const SizedBox(height: 12),
          Text(
            review['comment'] ?? 'Great experience!',
            style: AppTextStyles.bodyText2.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          if (review['images'] != null && (review['images'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (review['images'] as List).length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.background,
                      ),
                      child: Icon(
                        Icons.image,
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNearbyAttractions() {
    final attractions = [
      {
        'name': 'Beautiful Beach',
        'distance': '2.5 km',
        'type': 'Beach',
        'rating': 4.6,
      },
      {
        'name': 'Mountain View Point',
        'distance': '5.8 km',
        'type': 'Nature',
        'rating': 4.9,
      },
      {
        'name': 'Historical Museum',
        'distance': '3.2 km',
        'type': 'Culture',
        'rating': 4.4,
      },
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attractions.length,
        itemBuilder: (context, index) {
          final attraction = attractions[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.place,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attraction['name'] as String,
                              style: AppTextStyles.bodyText2.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              attraction['type'] as String,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            attraction['distance'] as String,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            (attraction['rating'] as double).toString(),
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVisitingTips() {
    final tips = [
      {
        'icon': Icons.access_time,
        'title': 'Best Time to Visit',
        'description':
            'Early morning (6-8 AM) for fewer crowds and better lighting',
      },
      {
        'icon': Icons.camera_alt,
        'title': 'Photography Tips',
        'description':
            'Golden hour is perfect for stunning photos. Bring extra batteries.',
      },
      {
        'icon': Icons.local_offer,
        'title': 'What to Bring',
        'description':
            'Comfortable shoes, water, sunscreen, and a camera are essential.',
      },
      {
        'icon': Icons.payment,
        'title': 'Entrance Fees',
        'description':
            'Adults: ₱100, Children: ₱50, Students: ₱75 (with valid ID)',
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
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tip['icon'] as IconData,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip['title'] as String,
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tip['description'] as String,
                      style: AppTextStyles.bodyText2.copyWith(
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

  void _loadMoreReviews() {
    setState(() {
      _isLoadingReviews = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoadingReviews = false;
        _reviews.addAll([
          {
            'name': 'John Doe',
            'rating': 5,
            'comment':
                'Amazing experience! The views were breathtaking and the staff was very helpful. Would definitely recommend to anyone visiting the area.',
            'date': '1 week ago',
            'images': ['image1.jpg', 'image2.jpg'],
          },
          {
            'name': 'Jane Smith',
            'rating': 4,
            'comment':
                'Beautiful place with lots to see. The only downside was that it was quite crowded during peak hours.',
            'date': '2 weeks ago',
          },
          {
            'name': 'Mike Johnson',
            'rating': 5,
            'comment':
                'Perfect for families! Kids loved it and there were plenty of activities for everyone.',
            'date': '3 weeks ago',
          },
        ]);
      });
    });
  }
}
