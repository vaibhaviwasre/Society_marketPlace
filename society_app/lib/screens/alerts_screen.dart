import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<Map<String, dynamic>> _alerts = [
    {
      'id': 1,
      'type': 'safety',
      'title': 'Safety Alert',
      'message':
          'Package theft reported on Maple Street. Please secure deliveries.',
      'time': '15m ago',
      'isRead': false,
      'icon': Icons.security,
      'color': Colors.red,
    },
    {
      'id': 2,
      'type': 'event',
      'title': 'Community Event',
      'message': 'Summer block party starts in 2 hours at Oakwood Park.',
      'time': '1h ago',
      'isRead': false,
      'icon': Icons.event,
      'color': Colors.blue,
    },
    {
      'id': 3,
      'type': 'weather',
      'title': 'Weather Update',
      'message':
          'Severe thunderstorm warning issued for tonight. Stay indoors.',
      'time': '3h ago',
      'isRead': true,
      'icon': Icons.cloud,
      'color': Colors.orange,
    },
    {
      'id': 4,
      'type': 'marketplace',
      'title': 'Price Drop',
      'message': 'Wooden coffee table you saved is now \$75 (was \$85).',
      'time': '5h ago',
      'isRead': false,
      'icon': Icons.shopping_bag,
      'color': Colors.green,
    },
    {
      'id': 5,
      'type': 'service',
      'title': 'Service Reminder',
      'message': 'John\'s lawn mowing service is available tomorrow.',
      'time': '1d ago',
      'isRead': true,
      'icon': Icons.build,
      'color': Colors.purple,
    },
    {
      'id': 6,
      'type': 'neighborhood',
      'title': 'Neighborhood Watch',
      'message': 'Monthly meeting scheduled for Saturday at 7 PM.',
      'time': '2d ago',
      'isRead': true,
      'icon': Icons.visibility,
      'color': Colors.teal,
    },
  ];

  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterTabs(),
            Expanded(child: _buildAlertsList()),
          ],
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
            'Alerts',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _markAllAsRead,
                icon: const Icon(Icons.done_all),
                iconSize: 24,
                tooltip: 'Mark all as read',
              ),
              IconButton(
                onPressed: () {
                  // Alert settings
                },
                icon: const Icon(Icons.settings),
                iconSize: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = [
      {'key': 'all', 'label': 'All', 'count': _alerts.length},
      {
        'key': 'unread',
        'label': 'Unread',
        'count': _alerts.where((a) => !a['isRead']).length,
      },
      {
        'key': 'safety',
        'label': 'Safety',
        'count': _alerts.where((a) => a['type'] == 'safety').length,
      },
      {
        'key': 'events',
        'label': 'Events',
        'count': _alerts.where((a) => a['type'] == 'event').length,
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter['key'];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter['key'] as String;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      filter['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if ((filter['count'] as int) > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.3)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${filter['count']}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAlertsList() {
    final filteredAlerts = _getFilteredAlerts();

    if (filteredAlerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No alerts found',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredAlerts.length,
      itemBuilder: (context, index) {
        return _buildAlertItem(filteredAlerts[index]);
      },
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alert['isRead']
              ? Colors.transparent
              : Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: (alert['color'] as Color).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            alert['icon'] as IconData,
            color: alert['color'] as Color,
            size: 24,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                alert['title'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: alert['isRead']
                      ? FontWeight.w500
                      : FontWeight.w600,
                ),
              ),
            ),
            Text(
              alert['time'],
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              alert['message'],
              style: TextStyle(
                fontSize: 14,
                color: alert['isRead'] ? Colors.grey[600] : Colors.black87,
              ),
            ),
            if (!alert['isRead'])
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'New',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        onTap: () {
          _markAsRead(alert);
          _showAlertDetails(alert);
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAlerts() {
    switch (_selectedFilter) {
      case 'unread':
        return _alerts.where((alert) => !alert['isRead']).toList();
      case 'safety':
        return _alerts.where((alert) => alert['type'] == 'safety').toList();
      case 'events':
        return _alerts.where((alert) => alert['type'] == 'event').toList();
      default:
        return _alerts;
    }
  }

  void _markAsRead(Map<String, dynamic> alert) {
    setState(() {
      alert['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var alert in _alerts) {
        alert['isRead'] = true;
      }
    });
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(alert['icon'] as IconData, color: alert['color'] as Color),
            const SizedBox(width: 8),
            Expanded(child: Text(alert['title'])),
          ],
        ),
        content: Text(alert['message']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (alert['type'] == 'marketplace' || alert['type'] == 'event')
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to relevant screen
              },
              child: Text(
                alert['type'] == 'marketplace' ? 'View Item' : 'View Event',
              ),
            ),
        ],
      ),
    );
  }
}
