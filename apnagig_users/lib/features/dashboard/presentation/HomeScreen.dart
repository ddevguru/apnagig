import 'package:flutter/material.dart';
import 'package:apnagig_users/features/booking/presentation/AllServicesScreen.dart';
import 'package:apnagig_users/features/dashboard/presentation/SearchScreen.dart';
import 'package:apnagig_users/features/booking/presentation/WorkerDetailsScreen.dart';
import 'package:apnagig_users/features/booking/presentation/ScheduleServiceScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedBestMatchCategory = 'All Services';
  final Set<String> _favoriteWorkerIds = {};

  final List<Map<String, dynamic>> _bestMatchesList = [
    {
      'id': '1',
      'name': 'Sarah Jenkins',
      'role': 'Master Plumber',
      'category': 'Plumbing',
      'verifiedBadge': 'Verified ApnaGig',
      'avatarUrl': 'assets/profile1.png',
      'rating': 4.9,
      'reviewsCount': 128,
      'experience': '8+ Years Exp.',
      'distance': '1.2 miles away',
      'availability': 'Avail. Tomorrow',
      'hourlyRate': '\$65',
      'isOnline': true,
      'isAiMatch': true,
    },
    {
      'id': '2',
      'name': 'David Miller',
      'role': 'Licensed Electrician',
      'category': 'Electrical',
      'verifiedBadge': 'Verified ApnaGig',
      'avatarUrl': 'assets/profile1.png',
      'rating': 4.8,
      'reviewsCount': 94,
      'experience': '5+ Years Exp.',
      'distance': '2.5 miles away',
      'availability': 'Avail. Today',
      'hourlyRate': '\$75',
      'isOnline': false,
      'isAiMatch': false,
    },
    {
      'id': '3',
      'name': 'Elena Rodriguez',
      'role': 'Landscaping Expert',
      'category': 'Landscaping',
      'verifiedBadge': 'Verified ApnaGig',
      'avatarUrl': 'assets/profile1.png',
      'rating': 4.7,
      'reviewsCount': 42,
      'experience': '3+ Years Exp.',
      'distance': '3.1 miles away',
      'availability': 'Avail. Nov 12',
      'hourlyRate': '\$50',
      'isOnline': true,
      'isAiMatch': false,
    },
    {
      'id': '4',
      'name': 'Robert Chen',
      'role': 'Master Carpenter',
      'category': 'Carpentry',
      'verifiedBadge': 'Verified ApnaGig',
      'avatarUrl': 'assets/profile1.png',
      'rating': 4.9,
      'reviewsCount': 156,
      'experience': '10+ Years Exp.',
      'distance': '1.8 miles away',
      'availability': 'Avail. Today',
      'hourlyRate': '\$70',
      'isOnline': true,
      'isAiMatch': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Light grey matching screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildPromoBanner(),
                const SizedBox(height: 32),
                _buildSectionHeader(
                  'Most Booked Services',
                  'View all',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AllServicesScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildServicesGrid(),
                const SizedBox(height: 32),
                _buildSectionHeader(
                  'Popular Near You',
                  'View all',
                  onTap: () {
                    // Do nothing or show future screen
                  },
                ),
                const SizedBox(height: 16),
                _buildPopularNearYouList(),
                const SizedBox(height: 36),
                _buildBestMatchesHeader(),
                const SizedBox(height: 20),
                _buildBestMatchFilterPills(),
                const SizedBox(height: 24),
                _buildBestMatchesList(),
                const SizedBox(height: 100), // Space for floating bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE2E8F0),
                image: DecorationImage(
                  image: AssetImage('assets/profile1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hello 👋',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Alex Carter',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_none, color: Color(0xFF1E293B)),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF159FEF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Color(0xFF94A3B8)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'What service do you need?',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.tune, color: Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF159FEF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Graphic mock (Right side)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/home_avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Save 25% Today!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B00), // Orange
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Exclusive discounts\non home service',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScheduleServiceScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B00), // Orange button
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_month, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Book Now',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        GestureDetector(
          onTap: onTap ??
              () {
                if (actionText.toLowerCase().contains('view')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllServicesScreen()),
                  );
                }
              },
          child: Text(
            actionText,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF159FEF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    final List<Map<String, dynamic>> services = [
      {'name': 'Plumber', 'emoji': '🚰'},
      {'name': 'Electrician', 'emoji': '⚡'},
      {'name': 'Carpenter', 'emoji': '🪚'},
      {'name': 'Painter', 'emoji': '🎨'},
      {'name': 'Mason', 'emoji': '🧱'},
      {'name': 'Welder', 'emoji': '🏗️'},
      {'name': 'Roofer', 'emoji': '🏠'},
      {'name': 'More', 'emoji': '🗂️'},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 320 ? 3 : 4;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final isMore = services[index]['name'] == 'More';
            return InkWell(
              onTap: () {
                if (isMore || true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllServicesScreen()),
                  );
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      services[index]['emoji'],
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    services[index]['name'],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPopularNearYouList() {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildServiceCard(
            name: 'Expert Plumbing',
            price: '\$45 /hr',
            category: 'Plumber',
            categoryColor: const Color(0xFFFF6B00),
            avatarUrl: 'assets/profile1.png',
          ),
          const SizedBox(width: 16),
          _buildServiceCard(
            name: 'Volt Services',
            price: '\$55 /hr',
            category: 'Electrician',
            categoryColor: const Color(0xFF159FEF),
            avatarUrl: 'assets/profile1.png',
          ),
          const SizedBox(width: 16),
          _buildServiceCard(
            name: 'Clean & Fresh House',
            price: '\$40 /hr',
            category: 'Cleaner',
            categoryColor: const Color(0xFF22C55E),
            avatarUrl: 'assets/profile1.png',
          ),
          const SizedBox(width: 16),
          _buildServiceCard(
            name: 'Pro Carpentry',
            price: '\$50 /hr',
            category: 'Carpenter',
            categoryColor: const Color(0xFFA855F7),
            avatarUrl: 'assets/profile1.png',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String name,
    required String price,
    required String category,
    required Color categoryColor,
    required String avatarUrl,
  }) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar mockup
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE2E8F0),
                      image: DecorationImage(
                        image: avatarUrl.startsWith('http')
                            ? NetworkImage(avatarUrl) as ImageProvider
                            : AssetImage(avatarUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF22C55E),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: categoryColor,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WorkerDetailsScreen(worker: {
                        'name': 'Dummy Pro',
                        'role': 'Professional',
                        'category': 'Service',
                        'rating': 4.9,
                        'reviews': 100,
                        'hourlyRate': '\$50',
                        'distance': '1 mile',
                        'availability': 'Available',
                        'isNearby': true,
                        'isTodayAvailable': true,
                        'isTopRated': true,
                        'bannerUrl': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?auto=format&fit=crop&w=800&q=80',
                        'fallbackAsset': 'assets/profile1.png',
                      })),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.remove_red_eye_outlined, size: 16, color: Color(0xFF1E293B)),
                      SizedBox(width: 4),
                      Text(
                        'View',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildBestMatchesHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Best Matches Near You',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'We found 24 ApnaGig professionals matching your request.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color(0xFF64748B),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildBestMatchFilterPills() {
    final categories = ['All Services', 'Plumbing', 'Electrical', 'Carpentry', 'Landscaping'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedBestMatchCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedBestMatchCategory = cat;
                });
              },
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF159FEF) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF159FEF).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  cat,
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

  Widget _buildBestMatchesList() {
    final filteredList = _selectedBestMatchCategory == 'All Services'
        ? _bestMatchesList
        : _bestMatchesList
            .where((w) => w['category'] == _selectedBestMatchCategory)
            .toList();

    if (filteredList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'No professionals found in this category.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Color(0xFF94A3B8),
          ),
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
              mainAxisExtent: 290,
            ),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return _buildBestMatchCard(filteredList[index]);
            },
          );
        } else {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return _buildBestMatchCard(filteredList[index]);
            },
          );
        }
      },
    );
  }

  Widget _buildBestMatchCard(Map<String, dynamic> worker) {
    final isFavorite = _favoriteWorkerIds.contains(worker['id']);
    final isAiMatch = worker['isAiMatch'] == true;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: isAiMatch ? 14.0 : 0.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isAiMatch ? const Color(0xFF38BDF8) : const Color(0xFFF1F5F9),
              width: isAiMatch ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row (Avatar + Info + Heart)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with Online dot
                  Stack(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xFFE2E8F0),
                          image: DecorationImage(
                            image: AssetImage(worker['avatarUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: worker['isOnline'] == true
                                ? const Color(0xFF22C55E)
                                : const Color(0xFF94A3B8),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  // Name, Badge & Specialty
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          worker['name'],
                          style: const TextStyle(
                            fontFamily: 'serif',
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Verified Badge Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1F2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFECDD3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                size: 12,
                                color: Color(0xFF991B1B),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                worker['verifiedBadge'],
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF991B1B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          worker['role'],
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Favorite Heart button
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isFavorite) {
                          _favoriteWorkerIds.remove(worker['id']);
                        } else {
                          _favoriteWorkerIds.add(worker['id']);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                        color: isFavorite ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats Info Section (Rating, Experience, Distance, Availability)
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                spacing: 12,
                children: [
                  // Rating
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 18, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 4),
                      Text(
                        '${worker['rating']}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${worker['reviewsCount']} Reviews)',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  // Experience
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.work_outline_rounded, size: 15, color: Color(0xFF475569)),
                      const SizedBox(width: 4),
                      Text(
                        worker['experience'],
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                spacing: 12,
                children: [
                  // Location
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF475569)),
                      const SizedBox(width: 4),
                      Text(
                        worker['distance'],
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                  // Availability
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time_rounded, size: 15, color: Color(0xFF475569)),
                      const SizedBox(width: 4),
                      Text(
                        worker['availability'],
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),
              // Bottom Price & Action Buttons Row
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 10,
                spacing: 8,
                children: [
                  // Price
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: worker['hourlyRate'],
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const TextSpan(
                          text: ' /hr',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Buttons Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // View Profile Button
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WorkerDetailsScreen(worker: {
                        'name': 'Dummy Pro',
                        'role': 'Professional',
                        'category': 'Service',
                        'rating': 4.9,
                        'reviews': 100,
                        'hourlyRate': '\$50',
                        'distance': '1 mile',
                        'availability': 'Available',
                        'isNearby': true,
                        'isTodayAvailable': true,
                        'isTopRated': true,
                        'bannerUrl': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?auto=format&fit=crop&w=800&q=80',
                        'fallbackAsset': 'assets/profile1.png',
                      })),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'View Profile',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Book Now Button
                      ElevatedButton(
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
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // AI Match Badge Overlay
        if (isAiMatch)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0284C7), Color(0xFF159FEF)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF159FEF).withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.auto_awesome, size: 13, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'AI Match',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
