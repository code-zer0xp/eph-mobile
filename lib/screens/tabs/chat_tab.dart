import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> worldChats = [
    {
      'name': 'PH Travelers Hub',
      'lastMessage': 'Anyone visiting Palawan next week?',
      'time': '2m ago',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'unread': 5,
      'online': true,
      'members': 1234,
    },
    {
      'name': 'Beach Lovers PH',
      'lastMessage': 'Boracay is beautiful this time of year! 🏖️',
      'time': '15m ago',
      'avatar':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=100',
      'unread': 2,
      'online': true,
      'members': 856,
    },
    {
      'name': 'Adventure Seekers',
      'lastMessage': 'Just completed Pulag trek! Amazing sunrise 🌄',
      'time': '1h ago',
      'avatar':
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=100',
      'unread': 0,
      'online': true,
      'members': 2341,
    },
    {
      'name': 'Budget Travelers',
      'lastMessage': 'Tips for cheap accommodations in Cebu?',
      'time': '3h ago',
      'avatar':
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=100',
      'unread': 0,
      'online': false,
      'members': 567,
    },
  ];

  final List<Map<String, dynamic>> countryChats = [
    {
      'name': 'Visayas Explorers',
      'lastMessage': 'Oslob whale shark watching is a must!',
      'time': '5m ago',
      'avatar':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=100',
      'unread': 3,
      'online': true,
      'region': 'Visayas',
    },
    {
      'name': 'Mindanao Adventures',
      'lastMessage': 'Camiguin island hopping tips',
      'time': '30m ago',
      'avatar':
          'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=100',
      'unread': 0,
      'online': true,
      'region': 'Mindanao',
    },
    {
      'name': 'Luzon Travelers',
      'lastMessage': 'Baguio weather update anyone?',
      'time': '2h ago',
      'avatar':
          'https://images.unsplash.com/photo-1500076656116-558758c991c1?w=100',
      'unread': 1,
      'online': true,
      'region': 'Luzon',
    },
    {
      'name': 'Palawan Paradise',
      'lastMessage': 'El Nido or Coron? Which one first?',
      'time': '4h ago',
      'avatar':
          'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=100',
      'unread': 0,
      'online': false,
      'region': 'Palawan',
    },
  ];

  final List<Map<String, dynamic>> personalChats = [
    {
      'name': 'Maria Santos',
      'lastMessage': 'See you at the resort! 😊',
      'time': '10m ago',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'unread': 2,
      'online': true,
    },
    {
      'name': 'Juan dela Cruz',
      'lastMessage': 'Thanks for the recommendations!',
      'time': '1h ago',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'unread': 0,
      'online': true,
    },
    {
      'name': 'Ana Reyes',
      'lastMessage': 'The tour was amazing yesterday!',
      'time': '3h ago',
      'avatar':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'unread': 0,
      'online': false,
    },
    {
      'name': 'Island Hopper Tours',
      'lastMessage': 'Your booking is confirmed ✓',
      'time': '1d ago',
      'avatar':
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=100',
      'unread': 0,
      'online': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Messages',
              style: AppTextStyles.headline3.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: AppColors.primary,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.lightGrey,
                      width: 1,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.globe, size: 16),
                          const SizedBox(width: 8),
                          const Text('World'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.flag, size: 16),
                          const SizedBox(width: 8),
                          const Text('Country'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.user, size: 16),
                          const SizedBox(width: 8),
                          const Text('Personal'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildWorldChats(),
            _buildCountryChats(),
            _buildPersonalChats(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
    );
  }

  Widget _buildWorldChats() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: worldChats.length,
      itemBuilder: (context, index) {
        final chat = worldChats[index];
        return _buildChatTile(
          chat,
          subtitle: '${chat['members']} members',
          isGroup: true,
        );
      },
    );
  }

  Widget _buildCountryChats() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: countryChats.length,
      itemBuilder: (context, index) {
        final chat = countryChats[index];
        return _buildChatTile(
          chat,
          subtitle: chat['region'],
          isGroup: true,
        );
      },
    );
  }

  Widget _buildPersonalChats() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: personalChats.length,
      itemBuilder: (context, index) {
        final chat = personalChats[index];
        return _buildChatTile(chat, isGroup: false);
      },
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat,
      {String? subtitle, bool isGroup = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(chat['avatar']),
              backgroundColor: AppColors.lightGrey,
            ),
            if (chat['online'] == true)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            if (isGroup)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: FaIcon(
                  FontAwesomeIcons.userGroup,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            Expanded(
              child: Text(
                chat['name'],
                style: AppTextStyles.bodyText1.copyWith(
                  fontWeight:
                      chat['unread'] > 0 ? FontWeight.bold : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              chat['lastMessage'],
              style: AppTextStyles.bodyText2.copyWith(
                color: chat['unread'] > 0
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontWeight:
                    chat['unread'] > 0 ? FontWeight.w500 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  FaIcon(
                    isGroup
                        ? FontAwesomeIcons.locationDot
                        : FontAwesomeIcons.circle,
                    size: 10,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time'],
              style: AppTextStyles.caption.copyWith(
                color: chat['unread'] > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            if (chat['unread'] > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${chat['unread']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () => _openChat(chat),
      ),
    );
  }

  void _openChat(Map<String, dynamic> chat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Chat header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.lightGrey),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(chat['avatar']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat['name'],
                          style: AppTextStyles.headline4,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: chat['online']
                                    ? AppColors.success
                                    : AppColors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              chat['online'] ? 'Online' : 'Offline',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.phone, size: 18),
                    onPressed: () {},
                    color: AppColors.primary,
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.video, size: 18),
                    onPressed: () {},
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
            // Chat messages placeholder
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.comments,
                      size: 64,
                      color: AppColors.lightGrey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Start a conversation',
                      style: AppTextStyles.bodyText1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Message input
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.lightGrey),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.paperclip,
                        color: AppColors.textSecondary, size: 20),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: AppColors.textSecondary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const FaIcon(FontAwesomeIcons.paperPlane,
                        color: Colors.white, size: 18),
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
