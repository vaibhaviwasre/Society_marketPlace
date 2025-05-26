import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool _isMapView = true;
  bool _showFilterModal = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  double _distanceValue = 5.0;
  String _selectedSort = 'newest';
  List<String> _selectedCategories = [];
  Set<int> _favoriteItems = {};

  // Helper method to get an icon based on category name
  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'furniture':
        return Icons.chair;
      case 'electronics':
        return Icons.devices;
      case 'clothing':
        return Icons.checkroom;
      case 'sports':
        return Icons.sports_basketball;
      case 'books':
        return Icons.book;
      case 'music':
        return Icons.music_note;
      case 'lighting':
        return Icons.lightbulb;
      default:
        return Icons.category;
    }
  }

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Furniture', 'count': 218, 'icon': Icons.chair_outlined},
    {'name': 'Electronics', 'count': 175, 'icon': Icons.devices_outlined},
    {'name': 'Clothing', 'count': 143, 'icon': Icons.checkroom_outlined},
    {'name': 'Sports', 'count': 98, 'icon': Icons.sports_basketball_outlined},
    {'name': 'Books', 'count': 87, 'icon': Icons.book_outlined},
    {'name': 'Kitchen', 'count': 76, 'icon': Icons.kitchen_outlined},
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 1,
      'name': 'Wooden Coffee Table',
      'price': 85.00,
      'distance': '0.8 miles',
      'image': 'furniture',
      'condition': 'Like new',
      'timePosted': '2h ago',
    },
    {
      'id': 2,
      'name': 'Vintage Record Player',
      'price': 120.00,
      'distance': '0.5 miles',
      'image': 'electronics',
      'condition': 'Excellent condition',
      'timePosted': '3h ago',
    },
    {
      'id': 3,
      'name': 'Modern Desk Lamp',
      'price': 35.00,
      'distance': '1.2 miles',
      'image': 'lighting',
      'condition': 'Good condition',
      'timePosted': '1d ago',
    },
    {
      'id': 4,
      'name': 'Mountain Bike',
      'price': 215.00,
      'distance': '1.5 miles',
      'image': 'sports',
      'condition': 'Like new',
      'timePosted': '5h ago',
    },
    {
      'id': 5,
      'name': 'Acoustic Guitar',
      'price': 150.00,
      'distance': '0.4 miles',
      'image': 'music',
      'condition': 'Like new, barely used',
      'timePosted': '2h ago',
    },
    {
      'id': 6,
      'name': 'Wooden Bookshelf',
      'price': 95.00,
      'distance': '0.6 miles',
      'image': 'furniture',
      'condition': 'Excellent condition, moving sale',
      'timePosted': '5h ago',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteItems.contains(productId)) {
        _favoriteItems.remove(productId);
      } else {
        _favoriteItems.add(productId);
      }
    });
  }

  void _toggleView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  void _showFilters() {
    setState(() {
      _showFilterModal = true;
    });
  }

  void _hideFilters() {
    setState(() {
      _showFilterModal = false;
    });
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _resetFilters() {
    setState(() {
      _minPriceController.clear();
      _maxPriceController.clear();
      _distanceValue = 5.0;
      _selectedSort = 'newest';
      _selectedCategories.clear();
    });
  }

  void _applyFilters() {
    // Apply filter logic here
    _hideFilters();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filters applied successfully'),
        backgroundColor: Color(0xFF009688),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios, size: 20),
                      ),
                      Text(
                        'Explore',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _toggleView,
                            child: Icon(
                              _isMapView ? Icons.view_list : Icons.map_outlined,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: _showFilters,
                            child: const Icon(Icons.tune, size: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search Section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search items, services or locations',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: Color(0xFF009688),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Filter Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip('Price Range', Icons.attach_money),
                            _buildFilterChip('Distance', Icons.location_on),
                            _buildFilterChip('Category', Icons.apps),
                            _buildFilterChip('Sort By', Icons.sort),
                            _buildFilterChip('More Filters', Icons.tune),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: _isMapView ? _buildMapView() : _buildListView(),
                ),
              ],
            ),
          ),

          // Filter Modal
          if (_showFilterModal) _buildFilterModal(),

          // Floating Action Button
          Positioned(
            bottom: 90,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Add new item functionality
              },
              backgroundColor: const Color(0xFF009688),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: _showFilters,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapView() {
    return Column(
      children: [
        // Map Container
        Container(
          height: 250,
          decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
          child: Stack(
            children: [
              // Location Pins
              Positioned(
                top: 60,
                left: 120,
                child: _buildLocationPin('\$85', const Color(0xFF009688)),
              ),
              Positioned(
                top: 120,
                left: 200,
                child: _buildLocationPin('\$120', const Color(0xFF009688)),
              ),
              Positioned(
                bottom: 80,
                right: 100,
                child: _buildLocationPin('\$45', const Color(0xFF009688)),
              ),
              Positioned(
                top: 80,
                right: 120,
                child: _buildLocationPin('\$35', const Color(0xFFFFC107)),
              ),

              // Current Location
              const Positioned(
                bottom: 120,
                right: 200,
                child: Icon(Icons.my_location, color: Colors.blue, size: 24),
              ),

              // Map Controls
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  children: [
                    _buildMapControl(Icons.add),
                    const SizedBox(height: 8),
                    _buildMapControl(Icons.remove),
                    const SizedBox(height: 8),
                    _buildMapControl(
                      Icons.my_location,
                      color: const Color(0xFF009688),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Mini List Preview
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  height: 4,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '12 Items Nearby',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Horizontal Product List
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: _products.take(3).map((product) {
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: _buildProductCard(product, isHorizontal: true),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPin(String price, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Icon(Icons.location_on, color: color, size: 20),
      ],
    );
  }

  Widget _buildMapControl(IconData icon, {Color? color}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: color ?? Colors.grey[700], size: 20),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Trending Near You
          _buildSection(
            'Trending Near You',
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _products.take(4).map((product) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: _buildProductCard(product, isHorizontal: true),
                  );
                }).toList(),
              ),
            ),
          ),

          // Popular Categories
          _buildSection(
            'Popular Categories',
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return _buildCategoryCard(category);
                },
              ),
            ),
          ),

          // Recommended For You
          _buildSection(
            'Recommended For You',
            Column(
              children: _products.skip(2).take(4).map((product) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: _buildRecommendedItem(product),
                );
              }).toList(),
            ),
            subtitle: 'Based on your history',
          ),

          // Nearby Items
          _buildSection(
            'Nearby Items',
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildProductCard(_products[index]);
                },
              ),
            ),
          ),

          const SizedBox(height: 100), // Extra space for bottom navigation
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildProductCard(
    Map<String, dynamic> product, {
    bool isHorizontal = false,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to product detail
      },
      child: Container(
        width: isHorizontal ? 160 : null,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            // Image
            Stack(
              children: [
                Container(
                  height: isHorizontal ? 120 : 144,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: const Color(0xFF009688).withOpacity(0.1),
                  ),
                  child: Center(
                    child: Icon(
                      _getIconForCategory(product['image']),
                      size: 48,
                      color: const Color(0xFF009688),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(product['id']),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _favoriteItems.contains(product['id'])
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favoriteItems.contains(product['id'])
                            ? Colors.red
                            : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                if (isHorizontal)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: Text(
                        product['distance'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product['price'].toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF009688),
                    ),
                  ),
                  if (!isHorizontal) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product['distance'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
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
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        // Navigate to category
      },
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF009688).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              category['icon'],
              color: const Color(0xFF009688),
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category['name'],
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${category['count']} items',
            style: TextStyle(fontSize: 10, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Image
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: const Color(0xFF009688).withOpacity(0.1),
            ),
            child: Center(
              child: Icon(
                _getIconForCategory(product['image']),
                size: 40,
                color: const Color(0xFF009688),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF009688),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['condition'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product['distance'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Posted ${product['timePosted']}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterModal() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: GestureDetector(
        onTap: _hideFilters,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {}, // Prevent dismissing when tapping on modal content
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filters',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: _hideFilters,
                            child: const Icon(Icons.close, size: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Price Range
                      Text(
                        'Price Range',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _minPriceController,
                              decoration: InputDecoration(
                                prefixText: '\$',
                                hintText: 'Min',
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'to',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _maxPriceController,
                              decoration: InputDecoration(
                                prefixText: '\$',
                                hintText: 'Max',
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Distance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Distance',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${_distanceValue.round()} miles',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF009688),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _distanceValue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        activeColor: const Color(0xFF009688),
                        onChanged: (value) {
                          setState(() {
                            _distanceValue = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0 miles',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            '10 miles',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Categories
                      Text(
                        'Categories',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3,
                            ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index]['name'];
                          final isSelected = _selectedCategories.contains(
                            category,
                          );

                          return GestureDetector(
                            onTap: () => _toggleCategory(category),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF009688)
                                      : Colors.grey[300]!,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: isSelected
                                    ? const Color(0xFF009688).withOpacity(0.1)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? const Color(0xFF009688)
                                        : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Sort By
                      Text(
                        'Sort By',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          _buildSortOption('newest', 'Newest First'),
                          _buildSortOption('lowest', 'Price: Low to High'),
                          _buildSortOption('highest', 'Price: High to Low'),
                          _buildSortOption(
                            'nearest',
                            'Distance: Nearest First',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetFilters,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _applyFilters,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF009688),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Apply Filters',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortOption(String value, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _selectedSort,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSort = newValue!;
                });
              },
              activeColor: const Color(0xFF009688),
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
