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
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _worldScrollController = ScrollController();
  final ScrollController _countryScrollController = ScrollController();

  // World Chat Messages (live chat room style)
  final List<Map<String, dynamic>> worldMessages = [
    {
      'isSystem': true,
      'title': 'Travel Advisory',
      'message':
          'Typhoon warning in Visayas region. Check weather before traveling.',
      'icon': FontAwesomeIcons.triangleExclamation,
      'time': '11:00',
    },
    {
      'isSystem': false,
      'username': 'TravellerMike',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'badge': 'Explorer',
      'badgeColor': Colors.blue,
      'message': 'Has anyone been to Siargao recently? How\'s the surf?',
      'time': '11:02',
    },
    {
      'isSystem': false,
      'username': 'BeachLover_PH',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'badge': 'Pro',
      'badgeColor': Colors.purple,
      'message': 'Cloud 9 is amazing right now! Perfect waves 🏄',
      'time': '11:03',
    },
    {
      'isSystem': false,
      'username': 'AdventureSeeker',
      'avatar':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'badge': 'Newbie',
      'badgeColor': Colors.green,
      'message': 'Planning my first trip to Palawan. Any tips?',
      'time': '11:05',
    },
    {
      'isSystem': true,
      'title': 'Featured Destination',
      'message':
          'Discover the hidden gems of Batanes! Limited promo available.',
      'icon': FontAwesomeIcons.locationDot,
      'time': '11:08',
    },
    {
      'isSystem': false,
      'username': 'WanderlustJuan',
      'avatar':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      'badge': 'Guide',
      'badgeColor': Colors.orange,
      'message':
          '@AdventureSeeker El Nido is a must! Island hopping Tour A is the best.',
      'time': '11:10',
    },
    {
      'isSystem': false,
      'username': 'BudgetTraveler',
      'avatar':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      'badge': 'Explorer',
      'badgeColor': Colors.blue,
      'message': 'Just booked my flight to Cebu! So excited! ✈️',
      'time': '11:12',
    },
  ];

  // Country Chat Messages (regional discussions)
  final List<Map<String, dynamic>> countryMessages = [
    {
      'isSystem': true,
      'title': 'Regional Update',
      'message': 'New eco-tourism site opened in Bohol!',
      'icon': FontAwesomeIcons.leaf,
      'time': '10:30',
    },
    {
      'isSystem': false,
      'username': 'VisayasExplorer',
      'avatar':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=100',
      'badge': 'Local',
      'badgeColor': Colors.teal,
      'message': 'Oslob whale shark watching is incredible this season!',
      'time': '10:35',
    },
    {
      'isSystem': false,
      'username': 'CebuanPride',
      'avatar':
          'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=100',
      'badge': 'Pro',
      'badgeColor': Colors.purple,
      'message': 'Anyone want to join Kawasan Falls canyoneering this weekend?',
      'time': '10:40',
    },
    {
      'isSystem': false,
      'username': 'MindanaoTraveler',
      'avatar':
          'https://images.unsplash.com/photo-1500076656116-558758c991c1?w=100',
      'badge': 'Explorer',
      'badgeColor': Colors.blue,
      'message': 'Camiguin is so underrated! The white island is beautiful.',
      'time': '10:45',
    },
    {
      'isSystem': false,
      'username': 'LuzonRider',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'badge': 'Guide',
      'badgeColor': Colors.orange,
      'message': '@CebuanPride Count me in! I\'ve been wanting to try that.',
      'time': '10:48',
    },
  ];

  // Personal Conversations (list view with group avatars)
  final List<Map<String, dynamic>> personalConversations = [
    {
      'name': 'Palawan Trip Squad',
      'isGroup': true,
      'members': [
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      ],
      'lastMessage': 'Maria: See you all at the airport!',
      'lastSender': 'Maria',
      'time': '11:12',
      'unread': 3,
      'muted': false,
    },
    {
      'name': 'Barkada Travels 2025',
      'isGroup': true,
      'members': [
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=100',
        'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=100',
      ],
      'lastMessage': 'Juan: Let\'s finalize the itinerary',
      'lastSender': 'Juan',
      'time': '10:55',
      'unread': 0,
      'muted': false,
    },
    {
      'name': 'Island Hopper Tours',
      'isGroup': false,
      'members': [
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=100',
      ],
      'lastMessage': 'Your booking is confirmed ✓',
      'lastSender': '',
      'time': '2025-12-04',
      'unread': 1,
      'muted': false,
    },
    {
      'name': 'Cebu Foodie Group',
      'isGroup': true,
      'members': [
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
        'https://images.unsplash.com/photo-1500076656116-558758c991c1?w=100',
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      ],
      'lastMessage': 'Ana: Best lechon in town! 🍖',
      'lastSender': 'Ana',
      'time': 'Yesterday',
      'unread': 0,
      'muted': true,
    },
    {
      'name': 'Maria Santos',
      'isGroup': false,
      'members': [
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      ],
      'lastMessage': 'Thanks for the recommendations!',
      'lastSender': '',
      'time': 'Yesterday',
      'unread': 0,
      'muted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _tabController.dispose();
    _worldScrollController.dispose();
    _countryScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 8,
            ),
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
            child: Column(
              children: [
                // Title row
                Row(
                  children: [
                    Text(
                      'Chat',
                      style: AppTextStyles.headline3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.gear,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.userPlus,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Tab bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    tabs: const [
                      Tab(text: 'World'),
                      Tab(text: 'Country'),
                      Tab(text: 'Personal'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWorldChat(),
                _buildCountryChat(),
                _buildPersonalList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // World Chat - Live chat room
  Widget _buildWorldChat() {
    return Column(
      children: [
        // Messages list
        Expanded(
          child: Container(
            color: Colors.grey[100],
            child: ListView.builder(
              controller: _worldScrollController,
              padding: const EdgeInsets.all(12),
              itemCount: worldMessages.length,
              itemBuilder: (context, index) {
                final msg = worldMessages[index];
                if (msg['isSystem'] == true) {
                  return _buildSystemMessage(msg);
                }
                return _buildUserMessage(msg);
              },
            ),
          ),
        ),
        // Message input
        _buildMessageInput('World'),
      ],
    );
  }

  // Country Chat - Regional discussions
  Widget _buildCountryChat() {
    return Column(
      children: [
        // Sub-tabs for Chat / Announcements
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              _buildSubTab('Chat', true),
              const SizedBox(width: 8),
              _buildSubTab('Announcements', false),
            ],
          ),
        ),
        // Messages list
        Expanded(
          child: Container(
            color: Colors.grey[100],
            child: ListView.builder(
              controller: _countryScrollController,
              padding: const EdgeInsets.all(12),
              itemCount: countryMessages.length,
              itemBuilder: (context, index) {
                final msg = countryMessages[index];
                if (msg['isSystem'] == true) {
                  return _buildSystemMessage(msg);
                }
                return _buildUserMessage(msg);
              },
            ),
          ),
        ),
        // Message input
        _buildMessageInput('Country'),
      ],
    );
  }

  Widget _buildSubTab(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.lightGrey,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  // Personal - Conversation list
  Widget _buildPersonalList() {
    return Column(
      children: [
        // Search bar
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search conversations...',
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Conversations list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: personalConversations.length,
            itemBuilder: (context, index) {
              final conv = personalConversations[index];
              return _buildConversationTile(conv);
            },
          ),
        ),
      ],
    );
  }

  // System announcement message
  Widget _buildSystemMessage(Map<String, dynamic> msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.9),
            AppColors.primaryLight.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FaIcon(
              msg['icon'] ?? FontAwesomeIcons.bullhorn,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  msg['message'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // User chat message bubble
  Widget _buildUserMessage(Map<String, dynamic> msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(msg['avatar']),
                backgroundColor: AppColors.lightGrey,
              ),
            ],
          ),
          const SizedBox(width: 10),
          // Message content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: msg['badgeColor'] ?? Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        msg['badge'] ?? 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      msg['username'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Message bubble
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    msg['message'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 2),
                // Time
                Text(
                  msg['time'],
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Conversation tile for Personal tab
  Widget _buildConversationTile(Map<String, dynamic> conv) {
    final members = conv['members'] as List;
    final isGroup = conv['isGroup'] == true;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: _buildGroupAvatar(members, isGroup),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conv['name'],
                style: TextStyle(
                  fontWeight:
                      conv['unread'] > 0 ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (conv['muted'] == true)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FaIcon(
                  FontAwesomeIcons.bellSlash,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            conv['lastMessage'],
            style: TextStyle(
              color: conv['unread'] > 0
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: 12,
              fontWeight:
                  conv['unread'] > 0 ? FontWeight.w500 : FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              conv['time'],
              style: TextStyle(
                color: conv['unread'] > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            if (conv['unread'] > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${conv['unread']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  // Group avatar with multiple member photos
  Widget _buildGroupAvatar(List members, bool isGroup) {
    if (!isGroup || members.length == 1) {
      return CircleAvatar(
        radius: 26,
        backgroundImage: NetworkImage(members.first),
        backgroundColor: AppColors.lightGrey,
      );
    }

    // Grid of member avatars for groups
    final displayCount = members.length > 4 ? 4 : members.length;
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          itemCount: displayCount,
          itemBuilder: (context, index) {
            return Image.network(
              members[index],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.primary.withOpacity(0.3),
              ),
            );
          },
        ),
      ),
    );
  }

  // Message input bar
  Widget _buildMessageInput(String channel) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.lightGrey),
        ),
      ),
      child: Row(
        children: [
          // Channel indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '[$channel]',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Text input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Tap to enter text',
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Emoji button
          Container(
            padding: const EdgeInsets.all(8),
            child: FaIcon(
              FontAwesomeIcons.faceSmile,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
          // Send button
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const FaIcon(
              FontAwesomeIcons.paperPlane,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
