import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  String _selectedTransactionStatus = 'All';

  // Sample user data
  final Map<String, dynamic> userData = {
    'name': 'Juan dela Cruz',
    'email': 'juan@exploreph.com',
    'avatar':
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    'memberSince': 'January 2024',
    'trips': 12,
    'reviews': 28,
    'photos': 156,
    'badges': 8,
  };

  // Bucket list items
  final List<Map<String, dynamic>> bucketList = [
    {
      'name': 'Chocolate Hills',
      'location': 'Bohol',
      'image':
          'https://images.unsplash.com/photo-1570789210967-2cac24634872?w=400',
      'completed': false,
      'targetDate': '2025-03-15',
      'priority': 'High',
      'notes': 'Best visited during dry season for optimal viewing',
      'estimatedCost': '₱5,000',
      'duration': '3 days',
    },
    {
      'name': 'Underground River',
      'location': 'Palawan',
      'image':
          'https://images.unsplash.com/photo-1500627965408-b5f300c68645?w=400',
      'completed': true,
      'targetDate': '2024-11-20',
      'priority': 'High',
      'notes': 'UNESCO World Heritage Site',
      'estimatedCost': '₱3,500',
      'duration': '2 days',
      'completedDate': '2024-11-18',
    },
    {
      'name': 'Mayon Volcano',
      'location': 'Albay',
      'image':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=400',
      'completed': false,
      'targetDate': '2025-05-20',
      'priority': 'Medium',
      'notes': 'Perfect cone shape, best viewed from Cagsawa Ruins',
      'estimatedCost': '₱4,000',
      'duration': '2 days',
    },
    {
      'name': 'Banaue Rice Terraces',
      'location': 'Ifugao',
      'image':
          'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=400',
      'completed': true,
      'targetDate': '2024-10-15',
      'priority': 'High',
      'notes': '8th Wonder of the Ancient World',
      'estimatedCost': '₱6,000',
      'duration': '4 days',
      'completedDate': '2024-10-12',
    },
  ];

  // Badges
  final List<Map<String, dynamic>> badges = [
    {
      'name': 'Explorer',
      'icon': FontAwesomeIcons.compass,
      'color': Colors.blue,
      'unlocked': true
    },
    {
      'name': 'Beach Lover',
      'icon': FontAwesomeIcons.umbrellaBeach,
      'color': Colors.orange,
      'unlocked': true
    },
    {
      'name': 'Mountain Climber',
      'icon': FontAwesomeIcons.mountain,
      'color': Colors.green,
      'unlocked': true
    },
    {
      'name': 'Foodie',
      'icon': FontAwesomeIcons.utensils,
      'color': Colors.red,
      'unlocked': true
    },
    {
      'name': 'Photographer',
      'icon': FontAwesomeIcons.camera,
      'color': Colors.purple,
      'unlocked': false
    },
    {
      'name': 'Adventurer',
      'icon': FontAwesomeIcons.personHiking,
      'color': Colors.teal,
      'unlocked': false
    },
    {
      'name': 'Island Hopper',
      'icon': FontAwesomeIcons.ship,
      'color': Colors.cyan,
      'unlocked': true
    },
    {
      'name': 'Culture Buff',
      'icon': FontAwesomeIcons.landmark,
      'color': Colors.amber,
      'unlocked': true
    },
  ];

  // Albums with photos and videos
  final List<Map<String, dynamic>> albums = [
    {
      'name': 'Palawan Adventure',
      'coverImage':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
      'type': 'album',
      'itemCount': 24,
      'dateCreated': '2024-11-15',
      'location': 'Palawan',
    },
    {
      'name': 'Boracay Beach',
      'coverImage':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      'type': 'album',
      'itemCount': 36,
      'dateCreated': '2024-10-20',
      'location': 'Boracay',
    },
    {
      'name': 'Siargao Surfing',
      'coverImage':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'type': 'album',
      'itemCount': 18,
      'dateCreated': '2024-09-10',
      'location': 'Siargao',
    },
    {
      'name': 'Mountain Hikes',
      'coverImage':
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400',
      'type': 'album',
      'itemCount': 42,
      'dateCreated': '2024-08-05',
      'location': 'Various',
    },
    {
      'name': 'Food Trips',
      'coverImage':
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=400',
      'type': 'album',
      'itemCount': 56,
      'dateCreated': '2024-07-12',
      'location': 'Various',
    },
  ];

  // Sample photos and videos within albums
  final List<Map<String, dynamic>> albumItems = [
    {
      'url':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
      'type': 'photo',
      'albumId': 0,
      'date': '2024-11-15',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      'type': 'photo',
      'albumId': 1,
      'date': '2024-10-20',
    },
    {
      'url': 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'type': 'video',
      'albumId': 2,
      'date': '2024-09-10',
      'thumbnail':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400',
      'type': 'photo',
      'albumId': 3,
      'date': '2024-08-05',
    },
    {
      'url': 'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=400',
      'type': 'video',
      'albumId': 4,
      'date': '2024-07-12',
      'thumbnail':
          'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=400',
    },
  ];

  // Transactions
  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'TRX001',
      'title': 'El Nido Island Hopping',
      'date': 'Dec 15, 2024',
      'amount': '₱3,500',
      'status': 'Completed',
      'type': 'booking',
      'paymentMethod': 'Credit Card',
      'tags': ['adventure', 'island', 'nature'],
      'breakdown': [
        {'item': 'Boat Rental', 'cost': '₱2,000'},
        {'item': 'Guide Fee', 'cost': '₱800'},
        {'item': 'Equipment', 'cost': '₱500'},
        {'item': 'Lunch', 'cost': '₱200'},
      ],
      'reference': 'ELN-2024-1215',
    },
    {
      'id': 'TRX002',
      'title': 'Makati Shangri-La',
      'date': 'Dec 10, 2024',
      'amount': '₱12,500',
      'status': 'Completed',
      'type': 'hotel',
      'paymentMethod': 'Bank Transfer',
      'tags': ['luxury', 'business', 'city'],
      'breakdown': [
        {'item': 'Deluxe Room (2 nights)', 'cost': '₱10,000'},
        {'item': 'Breakfast', 'cost': '₱1,500'},
        {'item': 'Service Charge', 'cost': '₱1,000'},
      ],
      'reference': 'SHG-2024-1210',
    },
    {
      'id': 'TRX003',
      'title': 'Cebu Pacific Flight',
      'date': 'Dec 05, 2024',
      'amount': '₱2,800',
      'status': 'Upcoming',
      'type': 'flight',
      'paymentMethod': 'E-Wallet',
      'tags': ['travel', 'flight', 'domestic'],
      'breakdown': [
        {'item': 'Base Fare', 'cost': '₱2,000'},
        {'item': 'Baggage Fee', 'cost': '₱500'},
        {'item': 'Seat Selection', 'cost': '₱200'},
        {'item': 'Travel Insurance', 'cost': '₱100'},
      ],
      'reference': 'CEB-2024-1205',
    },
    {
      'id': 'TRX004',
      'title': 'Kawasan Falls Tour',
      'date': 'Nov 28, 2024',
      'amount': '₱1,200',
      'status': 'Completed',
      'type': 'tour',
      'paymentMethod': 'Cash',
      'tags': ['nature', 'adventure', 'waterfall'],
      'breakdown': [
        {'item': 'Entrance Fee', 'cost': '₱500'},
        {'item': 'Guide Service', 'cost': '₱400'},
        {'item': 'Rental Equipment', 'cost': '₱300'},
      ],
      'reference': 'KWS-2024-1128',
    },
    {
      'id': 'TRX005',
      'title': 'Siargao Surfing Lessons',
      'date': 'Jan 10, 2025',
      'amount': '₱3,200',
      'status': 'Pending',
      'type': 'activity',
      'paymentMethod': 'Credit Card',
      'tags': ['surfing', 'beach', 'adventure'],
      'breakdown': [
        {'item': 'Surfboard Rental (3 days)', 'cost': '₱1,500'},
        {'item': 'Instructor Fee', 'cost': '₱1,200'},
        {'item': 'Equipment', 'cost': '₱500'},
      ],
      'reference': 'SGR-2025-0110',
    },
    {
      'id': 'TRX006',
      'title': 'Boracay Hotel Booking',
      'date': 'Jan 15, 2025',
      'amount': '₱8,500',
      'status': 'Processing',
      'type': 'hotel',
      'paymentMethod': 'Bank Transfer',
      'tags': ['beach', 'vacation', 'luxury'],
      'breakdown': [
        {'item': 'Beach Front Room (3 nights)', 'cost': '₱7,500'},
        {'item': 'Resort Fee', 'cost': '₱1,000'},
      ],
      'reference': 'BOR-2025-0115',
    },
  ];

  // Itinerary data
  final List<Map<String, dynamic>> itineraries = [
    {
      'title': 'Palawan Adventure',
      'dateRange': 'Dec 15-20, 2024',
      'status': 'Upcoming',
      'destinations': ['El Nido', 'Coron', 'Puerto Princesa'],
      'totalCost': '₱25,000',
      'image':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
      'activities': [
        {'name': 'Island Hopping', 'time': '9:00 AM', 'location': 'El Nido'},
        {'name': 'Snorkeling', 'time': '2:00 PM', 'location': 'Coron'},
        {
          'name': 'Underground River Tour',
          'time': '8:00 AM',
          'location': 'Puerto Princesa'
        },
      ],
    },
    {
      'title': 'Boracay Weekend Getaway',
      'dateRange': 'Nov 10-12, 2024',
      'status': 'Completed',
      'destinations': ['Boracay'],
      'totalCost': '₱15,000',
      'image':
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      'activities': [
        {
          'name': 'Beach Relaxation',
          'time': '10:00 AM',
          'location': 'White Beach'
        },
        {
          'name': 'Paraw Sailing',
          'time': '4:00 PM',
          'location': 'Boracay Beach'
        },
        {
          'name': 'Sunset Viewing',
          'time': '5:30 PM',
          'location': 'Sunset Beach'
        },
      ],
    },
    {
      'title': 'Siargao Surfing Trip',
      'dateRange': 'Jan 5-10, 2025',
      'status': 'Planning',
      'destinations': ['Siargao', 'General Luna'],
      'totalCost': '₱18,000',
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'activities': [
        {'name': 'Surfing Lessons', 'time': '7:00 AM', 'location': 'Cloud 9'},
        {'name': 'Island Tour', 'time': '1:00 PM', 'location': 'Siargao'},
        {'name': 'Beach Party', 'time': '8:00 PM', 'location': 'General Luna'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 350,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(),
            ),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.gear,
                    color: Colors.white, size: 18),
                onPressed: () => _showSettingsBottomSheet(),
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              Container(
                color: Colors.white,
                height: 56,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTabChip(
                          0, FontAwesomeIcons.listCheck, 'Bucket List'),
                      const SizedBox(width: 8),
                      _buildTabChip(1, FontAwesomeIcons.medal, 'Badges'),
                      const SizedBox(width: 8),
                      _buildTabChip(2, FontAwesomeIcons.images, 'Photos'),
                      const SizedBox(width: 8),
                      _buildTabChip(3, FontAwesomeIcons.route, 'Itinerary'),
                      const SizedBox(width: 8),
                      _buildTabChip(
                          4, FontAwesomeIcons.receipt, 'Transactions'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBucketListTab(),
            _buildBadgesTab(),
            _buildPhotosTab(),
            _buildItineraryTab(),
            _buildTransactionsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.primaryLight,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userData['avatar']),
                ),
              ),
              const SizedBox(height: 16),
              // Name
              Text(
                userData['name'],
                style: AppTextStyles.headline3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Member since ${userData['memberSince']}',
                style: AppTextStyles.bodyText2.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 15),
              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Trips', '${userData['trips']}',
                      FontAwesomeIcons.planeDeparture),
                  _buildStatItem('Reviews', '${userData['reviews']}',
                      FontAwesomeIcons.star),
                  _buildStatItem('Photos', '${userData['photos']}',
                      FontAwesomeIcons.camera),
                  _buildStatItem('Badges', '${userData['badges']}',
                      FontAwesomeIcons.medal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: FaIcon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.headline4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildBucketListTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bucketList.length,
      itemBuilder: (context, index) {
        final item = bucketList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with image and basic info
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(16)),
                    child: Stack(
                      children: [
                        Image.network(
                          item['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 100,
                            height: 100,
                            color: AppColors.lightGrey,
                            child: const Icon(Icons.image),
                          ),
                        ),
                        if (item['completed'])
                          Container(
                            width: 100,
                            height: 100,
                            color: AppColors.success.withOpacity(0.7),
                            child: const Center(
                              child: FaIcon(FontAwesomeIcons.check,
                                  color: Colors.white, size: 32),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item['name'],
                                  style: AppTextStyles.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: item['completed']
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(item['priority'])
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item['priority'],
                                  style: TextStyle(
                                    color: _getPriorityColor(item['priority']),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.locationDot,
                                  size: 12, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                item['location'],
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item['completed']
                                      ? AppColors.success.withOpacity(0.1)
                                      : AppColors.warning.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item['completed'] ? 'Completed' : 'Pending',
                                  style: TextStyle(
                                    color: item['completed']
                                        ? AppColors.success
                                        : AppColors.warning,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['estimatedCost'],
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.shareNodes,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              // Additional details section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Target date and duration
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.calendar,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          'Target: ${_formatDate(item['targetDate'])}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        FaIcon(FontAwesomeIcons.clock,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          item['duration'],
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Notes
                    Text(
                      item['notes'],
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item['completed'] && item['completedDate'] != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.checkCircle,
                              size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'Completed on: ${_formatDate(item['completedDate'])}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildBadgesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: badge['unlocked']
                    ? (badge['color'] as Color).withOpacity(0.1)
                    : AppColors.lightGrey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: badge['unlocked'] ? badge['color'] : AppColors.grey,
                  width: 2,
                ),
              ),
              child: FaIcon(
                badge['icon'],
                color: badge['unlocked'] ? badge['color'] : AppColors.grey,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              badge['name'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color:
                    badge['unlocked'] ? AppColors.textPrimary : AppColors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhotosTab() {
    return Column(
      children: [
        // Add Album Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Albums',
                style: AppTextStyles.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showCreateAlbumDialog(),
                icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
                label: const Text('Create Album'),
              ),
            ],
          ),
        ),
        // Albums Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: albums.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.folderPlus,
                          color: AppColors.primary, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Create Album',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final album = albums[index - 1];
              return GestureDetector(
                onTap: () => _showAlbumDetail(album),
                child: Container(
                  decoration: BoxDecoration(
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
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                album['coverImage'],
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: AppColors.lightGrey,
                                  child: const Icon(Icons.image),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.images,
                                        color: Colors.white, size: 10),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${album['itemCount']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                album['name'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.locationDot,
                                      size: 8, color: AppColors.textSecondary),
                                  const SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      album['location'],
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: AppColors.textSecondary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
        ),
      ],
    );
  }

  void _showCreateAlbumDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Album'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Album Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAlbumDetail(Map<String, dynamic> album) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Album header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          album['name'],
                          style: AppTextStyles.headline3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.locationDot,
                                size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              album['location'],
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Media grid
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: album['itemCount'] + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.plus,
                                color: AppColors.primary, size: 20),
                            SizedBox(height: 4),
                            Text(
                              'Add',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Sample media item
                    final mediaItem =
                        albumItems[(index - 1) % albumItems.length];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            mediaItem['type'] == 'video'
                                ? mediaItem['thumbnail']
                                : mediaItem['url'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: AppColors.lightGrey,
                              child: const Icon(Icons.image),
                            ),
                          ),
                          if (mediaItem['type'] == 'video')
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItineraryTab() {
    return Column(
      children: [
        // Header with add button
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Itineraries',
                style: AppTextStyles.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () => _showCreateItineraryDialog(),
                icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
                label: const Text('Create'),
              ),
            ],
          ),
        ),
        // Itineraries list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = itineraries[index];
              return GestureDetector(
                onTap: () => _showItineraryDetail(itinerary),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with status badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              itinerary['image'],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 120,
                                color: AppColors.lightGrey,
                                child: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(itinerary['status'])
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                itinerary['status'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itinerary['title'],
                                    style: AppTextStyles.bodyText1.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  itinerary['totalCost'],
                                  style: AppTextStyles.bodyText1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.calendar,
                                    size: 12, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  itinerary['dateRange'],
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children:
                                  (itinerary['destinations'] as List<String>)
                                      .map((destination) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              destination,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.blue;
      case 'Completed':
        return AppColors.success;
      case 'Planning':
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  void _showCreateItineraryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Itinerary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Itinerary Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Date Range',
                border: OutlineInputBorder(),
                hintText: 'e.g., Dec 15-20, 2024',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showItineraryDetail(Map<String, dynamic> itinerary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itinerary['title'],
                          style: AppTextStyles.headline3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.calendar,
                                size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              itinerary['dateRange'],
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(itinerary['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      itinerary['status'],
                      style: TextStyle(
                        color: _getStatusColor(itinerary['status']),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Destinations
              Text(
                'Destinations',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (itinerary['destinations'] as List<String>)
                    .map((destination) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            destination,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              // Total Cost
              Row(
                children: [
                  Text(
                    'Total Cost:',
                    style: AppTextStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    itinerary['totalCost'],
                    style: AppTextStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Activities
              Text(
                'Activities',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: itinerary['activities'].length,
                  itemBuilder: (context, index) {
                    final activity = itinerary['activities'][index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                color: AppColors.primary, size: 16),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.clock,
                                        size: 10,
                                        color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Text(
                                      activity['time'],
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    FaIcon(FontAwesomeIcons.locationDot,
                                        size: 10,
                                        color: AppColors.textSecondary),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        activity['location'],
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsTab() {
    final List<Map<String, dynamic>> filteredTransactions =
        transactions.where((transaction) {
      final status = transaction['status'] as String;
      switch (_selectedTransactionStatus) {
        case 'Completed':
          return status == 'Completed';
        case 'Ongoing':
          return status == 'Pending' ||
              status == 'Processing' ||
              status == 'Upcoming';
        case 'Cancelled':
          return status == 'Cancelled';
        case 'All':
        default:
          return true;
      }
    }).toList();

    return Column(
      children: [
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (final label in const [
                'All',
                'Ongoing',
                'Completed',
                'Cancelled'
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: _selectedTransactionStatus == label,
                    onSelected: (_) {
                      setState(() {
                        _selectedTransactionStatus = label;
                      });
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: _selectedTransactionStatus == label
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontWeight: _selectedTransactionStatus == label
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: _selectedTransactionStatus == label
                          ? AppColors.primary
                          : AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = filteredTransactions[index];
              final IconData icon;
              final Color color;

              switch (transaction['type']) {
                case 'booking':
                  icon = FontAwesomeIcons.ship;
                  color = Colors.blue;
                  break;
                case 'hotel':
                  icon = FontAwesomeIcons.hotel;
                  color = Colors.purple;
                  break;
                case 'flight':
                  icon = FontAwesomeIcons.plane;
                  color = Colors.orange;
                  break;
                case 'tour':
                  icon = FontAwesomeIcons.personWalkingLuggage;
                  color = Colors.green;
                  break;
                default:
                  icon = FontAwesomeIcons.receipt;
                  color = AppColors.primary;
              }

              return GestureDetector(
                onTap: () => _showTransactionDetail(transaction),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
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
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: FaIcon(icon, color: color, size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction['title'],
                                  style: AppTextStyles.bodyText1.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      transaction['date'],
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '•',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      transaction['paymentMethod'],
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children:
                                      (transaction['tags'] as List<String>)
                                          .map((tag) => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  '#$tag',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                transaction['amount'],
                                style: AppTextStyles.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getTransactionStatusColor(
                                          transaction['status'])
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  transaction['status'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _getTransactionStatusColor(
                                        transaction['status']),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Reference number
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.hashtag,
                              size: 10, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'Ref: ${transaction['reference']}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getTransactionStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'Cancelled':
        return AppColors.error;
      case 'Processing':
        return Colors.orange;
      case 'Pending':
        return Colors.amber;
      case 'Upcoming':
        return Colors.blue;
      default:
        return AppColors.primary;
    }
  }

  void _showTransactionDetail(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['title'],
                          style: AppTextStyles.headline3.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Transaction ID: ${transaction['id']}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getTransactionStatusColor(transaction['status'])
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      transaction['status'],
                      style: TextStyle(
                        color:
                            _getTransactionStatusColor(transaction['status']),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Transaction details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Date', transaction['date']),
                    _buildDetailRow(
                        'Payment Method', transaction['paymentMethod']),
                    _buildDetailRow('Reference', transaction['reference']),
                    _buildDetailRow('Type', transaction['type']),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Tags
              Text(
                'Tags',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (transaction['tags'] as List<String>)
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              // Cost breakdown
              Text(
                'Cost Breakdown',
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: transaction['breakdown'].length,
                  itemBuilder: (context, index) {
                    final item = transaction['breakdown'][index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['item'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            item['cost'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Total
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      transaction['amount'],
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip(int index, IconData icon, String label) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.textSecondary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
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
              const SizedBox(height: 24),
              Text('Settings', style: AppTextStyles.headline3),
              const SizedBox(height: 24),
              _buildSettingsOption(
                  FontAwesomeIcons.user, 'Edit Profile', () {}),
              _buildSettingsOption(
                  FontAwesomeIcons.bell, 'Notifications', () {}),
              _buildSettingsOption(
                  FontAwesomeIcons.lock, 'Privacy & Security', () {}),
              _buildSettingsOption(
                  FontAwesomeIcons.circleQuestion, 'Help & Support', () {}),
              _buildSettingsOption(
                  FontAwesomeIcons.fileLines, 'Terms & Conditions', () {}),
              const Divider(height: 32),
              _buildSettingsOption(
                FontAwesomeIcons.rightFromBracket,
                'Log Out',
                () => Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false),
                isDestructive: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption(IconData icon, String label, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ListTile(
      leading: FaIcon(
        icon,
        size: 20,
        color: isDestructive ? AppColors.error : AppColors.textPrimary,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        size: 14,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _child;

  _SliverAppBarDelegate(this._child);

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => true;
}
