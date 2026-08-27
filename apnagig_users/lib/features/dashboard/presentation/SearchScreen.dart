import 'package:flutter/material.dart';
import 'package:apnagig_users/features/booking/presentation/WorkerDetailsScreen.dart';
import 'package:apnagig_users/features/booking/presentation/ScheduleServiceScreen.dart';
class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  String _selectedFilter = 'All';
  String _searchQuery = '';
  int _selectedNavIndex = 1; // Search tab selected by default

  final List<String> _popularSuggestions = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'Cleaner',
    'Painter',
    'AC Repair',
    'Landscaping',
  ];

  final List<Map<String, dynamic>> _allWorkers = [
    {
      'id': 'w1',
      'name': 'Marcus T.',
      'role': 'Master Plumber',
      'category': 'Plumbing',
      'rating': 4.9,
      'reviews': 128,
      'hourlyRate': '\$85',
      'distance': '1.2 miles away',
      'availability': 'Available Today',
      'isNearby': true,
      'isTodayAvailable': true,
      'isTopRated': true,
      'bannerUrl':
          'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?auto=format&fit=crop&w=800&q=80',
      'fallbackAsset': 'assets/profile1.png',
    },
    {
      'id': 'w2',
      'name': 'Sarah J.',
      'role': 'Certified Electrician',
      'category': 'Electrical',
      'rating': 4.8,
      'reviews': 89,
      'hourlyRate': '\$90',
      'distance': '2.5 miles away',
      'availability': 'Available Tomorrow',
      'isNearby': true,
      'isTodayAvailable': false,
      'isTopRated': true,
      'bannerUrl':
          'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=800&q=80',
      'fallbackAsset': 'assets/profile1.png',
    },
    {
      'id': 'w3',
      'name': 'David L.',
      'role': 'Custom Carpentry',
      'category': 'Carpentry',
      'rating': 5.0,
      'reviews': 215,
      'hourlyRate': '\$75',
      'distance': '4.0 miles away',
      'availability': 'Available Today',
      'isNearby': false,
      'isTodayAvailable': true,
      'isTopRated': true,
      'bannerUrl':
          'https://images.unsplash.com/photo-1504148455328-c376907d081c?auto=format&fit=crop&w=800&q=80',
      'fallbackAsset': 'assets/profile1.png',
    },
    {
      'id': 'w4',
      'name': 'Elena R.',
      'role': 'Landscaping & Garden Expert',
      'category': 'Landscaping',
      'rating': 4.7,
      'reviews': 64,
      'hourlyRate': '\$60',
      'distance': '1.8 miles away',
      'availability': 'Available Today',
      'isNearby': true,
      'isTodayAvailable': true,
      'isTopRated': false,
      'bannerUrl':
          'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?auto=format&fit=crop&w=800&q=80',
      'fallbackAsset': 'assets/profile1.png',
    },
    {
      'id': 'w5',
      'name': 'Alex K.',
      'role': 'House & Office Cleaner',
      'category': 'Cleaner',
      'rating': 4.9,
      'reviews': 142,
      'hourlyRate': '\$55',
      'distance': '3.2 miles away',
      'availability': 'Available Today',
      'isNearby': false,
      'isTodayAvailable': true,
      'isTopRated': true,
      'bannerUrl':
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=800&q=80',
      'fallbackAsset': 'assets/profile1.png',
    },
  ];

  String _locationFilter = 'San Francisco, CA';
  double _minPrice = 20;
  double _maxPrice = 150;
  String _availabilityFilter = 'Today';
  String _minRatingFilter = '4.0+';
  String _genderFilter = 'Any';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    _searchQuery = widget.initialQuery ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheetModal(
          initialLocation: _locationFilter,
          initialMinPrice: _minPrice,
          initialMaxPrice: _maxPrice,
          initialAvailability: _availabilityFilter,
          initialMinRating: _minRatingFilter,
          initialGender: _genderFilter,
          onApply: (location, minPrice, maxPrice, availability, minRating, gender) {
            setState(() {
              _locationFilter = location;
              _minPrice = minPrice;
              _maxPrice = maxPrice;
              _availabilityFilter = availability;
              _minRatingFilter = minRating;
              _genderFilter = gender;
            });
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> get _filteredWorkers {
    return _allWorkers.where((worker) {
      // 1. Text Query Filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final nameMatch = worker['name'].toString().toLowerCase().contains(query);
        final roleMatch = worker['role'].toString().toLowerCase().contains(query);
        final categoryMatch = worker['category'].toString().toLowerCase().contains(query);
        if (!nameMatch && !roleMatch && !categoryMatch) {
          return false;
        }
      }

      // 2. Price Range Filter
      final double price = double.tryParse(worker['hourlyRate'].toString().replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      if (price < _minPrice || price > _maxPrice) {
        return false;
      }

      // 3. Minimum Rating Filter
      if (_minRatingFilter == '4.0+' && (worker['rating'] as double) < 4.0) {
        return false;
      } else if (_minRatingFilter == '4.5+' && (worker['rating'] as double) < 4.5) {
        return false;
      }

      // 4. Filter Pills Filter
      if (_selectedFilter == 'Nearby') {
        return worker['isNearby'] == true;
      } else if (_selectedFilter == 'Available Today') {
        return worker['isTodayAvailable'] == true;
      } else if (_selectedFilter == 'Top Rated') {
        return (worker['rating'] as double) >= 4.8;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar & Search Box
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildSearchBox(),
                  const SizedBox(height: 14),
                  _buildFilterPills(),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Suggestions row if user is typing
                    if (_searchController.text.isNotEmpty || _searchQuery.isEmpty)
                      _buildSuggestionsSection(),

                    const SizedBox(height: 16),
                    _buildWorkerList(),
                    const SizedBox(height: 100), // Bottom padding for floating nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Profile Avatar
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE2E8F0),
              image: DecorationImage(
                image: AssetImage('assets/profile1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Title: ApnaGig
        const Text(
          'ApnaGig',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006699),
          ),
        ),
        // Right Notification Bell
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF1E293B),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: Color(0xFF1E293B),
              ),
              decoration: const InputDecoration(
                hintText: 'What service do you need?',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.cancel_rounded, color: Color(0xFF94A3B8), size: 20),
              ),
            ),
          Container(
            height: 32,
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: const Padding(
              padding: EdgeInsets.only(left: 12, right: 16),
              child: Icon(Icons.tune_rounded, color: Color(0xFF006699), size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPills() {
    final filters = ['All', 'Nearby', 'Available Today', 'Top Rated'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF159FEF) : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Suggestions',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
            ),
            if (_searchQuery.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
                child: const Text(
                  'Clear filter',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF159FEF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: _popularSuggestions.map((sugg) {
              final isMatching = _searchQuery.toLowerCase() == sugg.toLowerCase();
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ActionChip(
                  label: Text(sugg),
                  labelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: isMatching ? FontWeight.bold : FontWeight.w500,
                    color: isMatching ? const Color(0xFF159FEF) : const Color(0xFF334155),
                  ),
                  backgroundColor: isMatching ? const Color(0xFFE0F2FE) : Colors.white,
                  side: BorderSide(
                    color: isMatching ? const Color(0xFF38BDF8) : const Color(0xFFE2E8F0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    _searchController.text = sugg;
                    setState(() {
                      _searchQuery = sugg;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkerList() {
    final workers = _filteredWorkers;

    if (workers.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: Column(
          children: const [
            Icon(Icons.search_off_rounded, size: 48, color: Color(0xFFCBD5E1)),
            SizedBox(height: 12),
            Text(
              'No services found matching your query.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 600;

        if (isWideScreen) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              mainAxisExtent: 410,
            ),
            itemCount: workers.length,
            itemBuilder: (context, index) => _buildWorkerCard(workers[index]),
          );
        } else {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) => _buildWorkerCard(workers[index]),
          );
        }
      },
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkerDetailsScreen(worker: worker),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image with Rating Badge Overlay
            Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  worker['bannerUrl'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      width: double.infinity,
                      color: const Color(0xFFE2E8F0),
                      child: Image.asset(
                        worker['fallbackAsset'],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              // Floating Rating Pill (Top-Left)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 4),
                      Text(
                        '${worker['rating']}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${worker['reviews']})',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Card Info Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name & Hourly Rate
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      worker['name'],
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: worker['hourlyRate'],
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF159FEF),
                            ),
                          ),
                          const TextSpan(
                            text: '/hr',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Color(0xFF159FEF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  worker['role'],
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 12),

                // Info Pills (Distance + Availability)
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    // Distance Pill (Light pink background)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0ED),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Color(0xFFFF5722),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            worker['distance'],
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF5722),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Availability Pill (Light grey background)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        worker['availability'],
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Buttons Row (Book Now + Chat Button)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ScheduleServiceScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF159FEF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Color(0xFF334155),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
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

class FilterBottomSheetModal extends StatefulWidget {
  final String initialLocation;
  final double initialMinPrice;
  final double initialMaxPrice;
  final String initialAvailability;
  final String initialMinRating;
  final String initialGender;
  final Function(
    String location,
    double minPrice,
    double maxPrice,
    String availability,
    String minRating,
    String gender,
  ) onApply;

  const FilterBottomSheetModal({
    super.key,
    required this.initialLocation,
    required this.initialMinPrice,
    required this.initialMaxPrice,
    required this.initialAvailability,
    required this.initialMinRating,
    required this.initialGender,
    required this.onApply,
  });

  @override
  State<FilterBottomSheetModal> createState() => _FilterBottomSheetModalState();
}

class _FilterBottomSheetModalState extends State<FilterBottomSheetModal> {
  late TextEditingController _locationController;
  late RangeValues _priceRange;
  late String _availability;
  late String _minRating;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.initialLocation);
    _priceRange = RangeValues(widget.initialMinPrice, widget.initialMaxPrice);
    _availability = widget.initialAvailability;
    _minRating = widget.initialMinRating;
    _gender = widget.initialGender;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _locationController.text = 'San Francisco, CA';
      _priceRange = const RangeValues(20, 150);
      _availability = 'Today';
      _minRating = '4.0+';
      _gender = 'Any';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Header Row: Title "Filters" + Close button X
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            const SizedBox(height: 20),

            // 1. Location Section
            const Text(
              'Location',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF64748B), size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter location...',
                        hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Price Range Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price Range',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}${_priceRange.end >= 150 ? '+' : ''}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF159FEF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF159FEF),
                inactiveTrackColor: const Color(0xFFE2E8F0),
                thumbColor: Colors.white,
                overlayColor: const Color(0xFF159FEF).withValues(alpha: 0.15),
                trackHeight: 4,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 12,
                  elevation: 4,
                ),
              ),
              child: RangeSlider(
                values: _priceRange,
                min: 10,
                max: 200,
                onChanged: (values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // 3. Availability Section
            const Text(
              'Availability',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildPillOption('Today', _availability == 'Today', () {
                  setState(() => _availability = 'Today');
                }),
                _buildPillOption('Tomorrow', _availability == 'Tomorrow', () {
                  setState(() => _availability = 'Tomorrow');
                }),
                _buildPillOption('This Week', _availability == 'This Week', () {
                  setState(() => _availability = 'This Week');
                }),
                _buildPillOption('📅 Choose Date', _availability == 'Choose Date', () {
                  setState(() => _availability = 'Choose Date');
                }),
              ],
            ),
            const SizedBox(height: 24),

            // 4. Minimum Rating Section
            const Text(
              'Minimum Rating',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildRatingPill('Any', _minRating == 'Any', () {
                    setState(() => _minRating = 'Any');
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildRatingPill('4.0+ ⭐️', _minRating == '4.0+', () {
                    setState(() => _minRating = '4.0+');
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildRatingPill('4.5+ ⭐️', _minRating == '4.5+', () {
                    setState(() => _minRating = '4.5+');
                  }),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Gender Preference Section
            const Text(
              'Gender Preference',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildGenderButton('Female', _gender == 'Female', () {
                    setState(() => _gender = 'Female');
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildGenderButton('Male', _gender == 'Male', () {
                    setState(() => _gender = 'Male');
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildGenderButton('Any', _gender == 'Any', () {
                    setState(() => _gender = 'Any');
                  }),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Footer Action Buttons: Reset & Apply Filters
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: _resetFilters,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(
                        _locationController.text,
                        _priceRange.start,
                        _priceRange.end,
                        _availability,
                        _minRating,
                        _gender,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF159FEF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildPillOption(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF159FEF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF159FEF) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingPill(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F2FE) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? const Color(0xFF0284C7) : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF159FEF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF159FEF) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }
}
