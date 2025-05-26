import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userProfile = {
    'name': 'Emily Johnson',
    'email': 'emily.johnson@email.com',
    'joinDate': 'Joined March 2024',
    'location': 'Maple Street, Riverside Community',
    'rating': 4.8,
    'totalTransactions': 23,
    'avatar': 'EJ',
    'verified': true,
  };

  final List<Map<String, dynamic>> _stats = [
    {'title': 'Items Sold', 'value': '15', 'icon': Icons.shopping_bag},
    {'title': 'Items Bought', 'value': '8', 'icon': Icons.shopping_cart},
    {'title': 'Rating', 'value': '4.8', 'icon': Icons.star},
    {'title': 'Reviews', 'value': '12', 'icon': Icons.rate_review},
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'My Listings',
      'subtitle': 'View and manage your items',
      'icon': Icons.list_alt,
      'color': Colors.blue,
    },
    {
      'title': 'Favorites',
      'subtitle': 'Items you\'ve saved',
      'icon': Icons.favorite,
      'color': Colors.red,
    },
    {
      'title': 'Transaction History',
      'subtitle': 'See your buying and selling history',
      'icon': Icons.history,
      'color': Colors.green,
    },
    {
      'title': 'Reviews & Ratings',
      'subtitle': 'Read reviews from other users',
      'icon': Icons.star_rate,
      'color': Colors.amber,
    },
    {
      'title': 'Notifications',
      'subtitle': 'Manage alert preferences',
      'icon': Icons.notifications,
      'color': Colors.orange,
    },
    {
      'title': 'Privacy & Safety',
      'subtitle': 'Security and privacy settings',
      'icon': Icons.security,
      'color': Colors.purple,
    },
    {
      'title': 'Help & Support',
      'subtitle': 'Get help or contact support',
      'icon': Icons.help,
      'color': Colors.teal,
    },
    {
      'title': 'Settings',
      'subtitle': 'App preferences and account settings',
      'icon': Icons.settings,
      'color': Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildProfileCard(),
              _buildStatsSection(),
              _buildMenuSection(),
              _buildLogoutButton(),
              const SizedBox(height: 100), // Extra space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {
              // Edit profile
              _showEditProfileDialog();
            },
            icon: const Icon(Icons.edit),
            iconSize: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF009688),
                child: Text(
                  _userProfile['avatar'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (_userProfile['verified'])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _userProfile['name'],
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userProfile['email'],
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                _userProfile['location'],
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _userProfile['joinDate'],
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < _userProfile['rating'].floor()
                      ? Icons.star
                      : index < _userProfile['rating']
                      ? Icons.star_half
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
              const SizedBox(width: 8),
              Text(
                '${_userProfile['rating']} (${_userProfile['totalTransactions']} transactions)',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: _stats.map((stat) {
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    stat['icon'] as IconData,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat['value'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  stat['title'] as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: _menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == _menuItems.length - 1;

          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: item['color'] as Color,
                    size: 20,
                  ),
                ),
                title: Text(
                  item['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  _handleMenuItemTap(item['title'] as String);
                },
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: Colors.grey[200],
                  indent: 76,
                  endIndent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(Icons.logout),
        label: const Text('Log Out'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[50],
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _handleMenuItemTap(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$title functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text(
          'Profile editing functionality would be implemented here.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate back to login/onboarding
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
