import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/listing/listing_card_v2.dart';

class SearchPage extends StatefulWidget {
  final String? initialQuery;

  const SearchPage({super.key, this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _selectedCategory = 'All';
  String _selectedTag = 'All';
  String _selectedLocation = 'All';
  RangeValues _priceRange = const RangeValues(0, 50000);
  String _sortBy = 'Recommended';
  bool _showFilters = false;

  // Categories for filter
  final List<String> _categories = [
    'All',
    'Destinations',
    'Hotels',
    'Restaurants',
    'Tours',
    'Activities',
  ];

  // Tags for filter
  final List<String> _tags = [
    'All',
    'Featured',
    'Recommended',
    'New',
    'Promos',
    'Open for Joiners',
  ];

  // Locations
  final List<String> _locations = [
    'All',
    'Luzon',
    'Visayas',
    'Mindanao',
    'NCR',
    'Palawan',
  ];

  // Sample search results
  final List<Map<String, dynamic>> _allResults = [
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
      'hashtags': ['beach', 'island', 'resort', 'featured'],
      'category': 'Hotels',
      'tag': 'Featured',
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
      'hashtags': ['nature', 'landmark', 'adventure', 'recommended'],
      'category': 'Destinations',
      'tag': 'Recommended',
    },
    {
      'name': 'Boracay Island Hopping',
      'location': 'Malay, Aklan',
      'city': 'Malay',
      'province': 'Aklan',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
      'priceRange': '₱1,200 - ₱2,500',
      'highlight': 'Explore 3 beautiful islands in one day',
      'rating': 4.7,
      'reviews': 3456,
      'hashtags': ['beach', 'tour', 'island', 'new'],
      'category': 'Tours',
      'tag': 'New',
    },
    {
      'name': 'Mayon Volcano View Deck',
      'location': 'Legazpi, Albay',
      'city': 'Legazpi',
      'province': 'Albay',
      'image':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=600',
      'priceRange': '₱200 - ₱500',
      'highlight': 'Perfect cone volcano view',
      'rating': 4.9,
      'reviews': 2890,
      'hashtags': ['volcano', 'nature', 'landmark', 'featured'],
      'category': 'Destinations',
      'tag': 'Featured',
    },
    {
      'name': 'Cebu Lechon Festival Tour',
      'location': 'Cebu City, Cebu',
      'city': 'Cebu City',
      'province': 'Cebu',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600',
      'priceRange': '₱800 - ₱1,500',
      'highlight': 'Taste the best lechon in the Philippines',
      'rating': 4.6,
      'reviews': 1234,
      'hashtags': ['food', 'culture', 'tour', 'promos'],
      'category': 'Tours',
      'tag': 'Promos',
    },
    {
      'name': 'Siargao Surf Camp',
      'location': 'General Luna, Siargao',
      'city': 'General Luna',
      'province': 'Siargao',
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=600',
      'priceRange': '₱2,000 - ₱5,000',
      'highlight': 'Learn to surf at Cloud 9',
      'rating': 4.8,
      'reviews': 1567,
      'hashtags': ['surfing', 'beach', 'adventure', 'openforjoiners'],
      'category': 'Activities',
      'tag': 'Open for Joiners',
    },
    {
      'name': 'Intramuros Heritage Walk',
      'location': 'Manila',
      'city': 'Manila',
      'province': 'Metro Manila',
      'image':
          'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=600',
      'priceRange': '₱300 - ₱800',
      'highlight': 'Explore Spanish colonial history',
      'rating': 4.5,
      'reviews': 2100,
      'hashtags': ['history', 'culture', 'walking', 'recommended'],
      'category': 'Tours',
      'tag': 'Recommended',
    },
    {
      'name': 'Banaue Rice Terraces Trek',
      'location': 'Banaue, Ifugao',
      'city': 'Banaue',
      'province': 'Ifugao',
      'image':
          'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=600',
      'priceRange': '₱1,500 - ₱3,500',
      'highlight': '8th Wonder of the World',
      'rating': 4.9,
      'reviews': 1890,
      'hashtags': ['trekking', 'nature', 'heritage', 'featured'],
      'category': 'Activities',
      'tag': 'Featured',
    },
  ];

  List<Map<String, dynamic>> get _filteredResults {
    return _allResults.where((item) {
      // Search query filter
      final query = _searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        final name = item['name'].toString().toLowerCase();
        final location = item['location'].toString().toLowerCase();
        final hashtags = (item['hashtags'] as List).join(' ').toLowerCase();
        if (!name.contains(query) &&
            !location.contains(query) &&
            !hashtags.contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != 'All' && item['category'] != _selectedCategory) {
        return false;
      }

      // Tag filter
      if (_selectedTag != 'All' && item['tag'] != _selectedTag) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _searchController.text = widget.initialQuery!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Search Bar
            _buildSearchBar(),
            // Filter Chips
            _buildFilterChips(),
            // Expanded Filters Panel
            if (_showFilters) _buildExpandedFilters(),
            // Results Section
            Expanded(
              child: _filteredResults.isEmpty
                  ? _buildEmptyState()
                  : _buildResultsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(FontAwesomeIcons.arrowLeft,
                  size: 16, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 12),
          // Search input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.magnifyingGlass,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search destinations, hotels, tours...',
                        hintStyle: AppTextStyles.bodyText2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      child: FaIcon(FontAwesomeIcons.xmark,
                          size: 14, color: AppColors.textSecondary),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter button
          GestureDetector(
            onTap: () => setState(() => _showFilters = !_showFilters),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _showFilters
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(
                FontAwesomeIcons.sliders,
                size: 16,
                color: _showFilters ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip('All', _selectedTag == 'All', () {
            setState(() => _selectedTag = 'All');
          }),
          _buildChip('Featured', _selectedTag == 'Featured', () {
            setState(() => _selectedTag = 'Featured');
          }, icon: FontAwesomeIcons.star),
          _buildChip('Recommended', _selectedTag == 'Recommended', () {
            setState(() => _selectedTag = 'Recommended');
          }, icon: FontAwesomeIcons.thumbsUp),
          _buildChip('New', _selectedTag == 'New', () {
            setState(() => _selectedTag = 'New');
          }, icon: FontAwesomeIcons.bolt),
          _buildChip('Promos', _selectedTag == 'Promos', () {
            setState(() => _selectedTag = 'Promos');
          }, icon: FontAwesomeIcons.percent),
          _buildChip('Open for Joiners', _selectedTag == 'Open for Joiners',
              () {
            setState(() => _selectedTag = 'Open for Joiners');
          }, icon: FontAwesomeIcons.userGroup),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap,
      {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondary.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                FaIcon(
                  icon,
                  size: 12,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Filter
          Text(
            'Category',
            style: AppTextStyles.bodyText2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((cat) {
              final isSelected = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedCategory = cat),
                selectedColor: AppColors.primary,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Location Filter
          Text(
            'Location',
            style: AppTextStyles.bodyText2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _locations.map((loc) {
              final isSelected = _selectedLocation == loc;
              return ChoiceChip(
                label: Text(loc),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedLocation = loc),
                selectedColor: AppColors.primary,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Price Range
          Row(
            children: [
              Text(
                'Price Range',
                style: AppTextStyles.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '₱${_priceRange.start.toInt()} - ₱${_priceRange.end.toInt()}',
                style: AppTextStyles.bodyText2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 50000,
            divisions: 100,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.lightGrey,
            onChanged: (values) => setState(() => _priceRange = values),
          ),
          const SizedBox(height: 8),
          // Sort By
          Row(
            children: [
              Text(
                'Sort by:',
                style: AppTextStyles.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSortChip('Recommended'),
                      _buildSortChip('Price: Low to High'),
                      _buildSortChip('Price: High to Low'),
                      _buildSortChip('Rating'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(String label) {
    final isSelected = _sortBy == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _sortBy = label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondary.withOpacity(0.3),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Results count and Call to Action banner
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Results count
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      '${_filteredResults.length} Results',
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Showing $_selectedTag',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Call to Action Banner
              _buildCTABanner(),
            ],
          ),
        ),
        // Results Grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _filteredResults[index];
                return ListingCardV2(
                  name: item['name'],
                  location: item['location'],
                  city: item['city'],
                  province: item['province'],
                  imageUrl: item['image'],
                  priceRange: item['priceRange'],
                  highlight: item['highlight'],
                  rating: item['rating'],
                  reviews: item['reviews'],
                  hashtags: List<String>.from(item['hashtags']),
                  onAddToItinerary: () => _handleAddToItinerary(item),
                  onAddToBucketList: () => _handleAddToBucketList(item),
                  onShare: () => _handleShare(item),
                );
              },
              childCount: _filteredResults.length,
            ),
          ),
        ),
        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _buildCTABanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan Your Trip',
                  style: AppTextStyles.headline4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Add destinations to your itinerary and start exploring!',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(FontAwesomeIcons.route,
                color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.magnifyingGlass,
              size: 64, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: AppTextStyles.headline4.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: AppTextStyles.bodyText2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
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
            Text('${item['name']} added to Itinerary'),
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
            Text('${item['name']} added to Bucket List'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleShare(Map<String, dynamic> item) {
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
              'Share ${item['name']}',
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
