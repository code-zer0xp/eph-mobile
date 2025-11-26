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
    },
    {
      'name': 'Underground River',
      'location': 'Palawan',
      'image':
          'https://images.unsplash.com/photo-1500627965408-b5f300c68645?w=400',
      'completed': true,
    },
    {
      'name': 'Mayon Volcano',
      'location': 'Albay',
      'image':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?w=400',
      'completed': false,
    },
    {
      'name': 'Banaue Rice Terraces',
      'location': 'Ifugao',
      'image':
          'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=400',
      'completed': true,
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

  // Photos
  final List<String> photos = [
    'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
    'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400',
    'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=400',
    'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=400',
  ];

  // Transactions
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'El Nido Island Hopping',
      'date': 'Dec 15, 2024',
      'amount': '₱3,500',
      'status': 'Completed',
      'type': 'booking',
    },
    {
      'title': 'Makati Shangri-La',
      'date': 'Dec 10, 2024',
      'amount': '₱12,500',
      'status': 'Completed',
      'type': 'hotel',
    },
    {
      'title': 'Cebu Pacific Flight',
      'date': 'Dec 05, 2024',
      'amount': '₱2,800',
      'status': 'Upcoming',
      'type': 'flight',
    },
    {
      'title': 'Kawasan Falls Tour',
      'date': 'Nov 28, 2024',
      'amount': '₱1,200',
      'status': 'Completed',
      'type': 'tour',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                tabs: const [
                  Tab(
                      icon: FaIcon(FontAwesomeIcons.listCheck, size: 16),
                      text: 'Bucket List'),
                  Tab(
                      icon: FaIcon(FontAwesomeIcons.medal, size: 16),
                      text: 'Badges'),
                  Tab(
                      icon: FaIcon(FontAwesomeIcons.images, size: 16),
                      text: 'Photos'),
                  Tab(
                      icon: FaIcon(FontAwesomeIcons.receipt, size: 16),
                      text: 'Transactions'),
                ],
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
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Stack(
                  children: [
                    Image.network(
                      item['image'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
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
                      Text(
                        item['name'],
                        style: AppTextStyles.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: item['completed']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
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
        );
      },
    );
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
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: photos.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.plus,
                    color: AppColors.primary, size: 24),
                const SizedBox(height: 8),
                Text(
                  'Add Photo',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                photos[index - 1],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.lightGrey,
                  child: const Icon(Icons.image),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const FaIcon(FontAwesomeIcons.shareNodes,
                      color: Colors.white, size: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
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

        return Container(
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
          child: Row(
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
                    Text(
                      transaction['date'],
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: transaction['status'] == 'Completed'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      transaction['status'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: transaction['status'] == 'Completed'
                            ? AppColors.success
                            : AppColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
