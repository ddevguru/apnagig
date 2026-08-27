import 'package:flutter/material.dart';
import 'package:apnagig_users/features/tracking/presentation/ReportIssueScreen.dart';
import 'package:apnagig_users/features/tracking/presentation/VerifyServiceEndScreen.dart';
import 'package:apnagig_users/features/booking/presentation/ActiveBookingDetailsScreen.dart';

class ServiceInProgressScreen extends StatefulWidget {
  const ServiceInProgressScreen({super.key});

  @override
  State<ServiceInProgressScreen> createState() => _ServiceInProgressScreenState();
}

class _ServiceInProgressScreenState extends State<ServiceInProgressScreen> {
  // State for checkboxes
  bool task1 = true;
  bool task2 = true;
  bool task3 = false;
  bool task4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: const AssetImage('assets/profile1.png'), // Placeholder
            backgroundColor: Colors.grey[300],
          ),
        ),
        title: const Text(
          'Service in Progress',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Color(0xFF0F172A)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF159FEF), width: 4),
                    ),
                    child: const Center(
                      child: Icon(Icons.timer_outlined, color: Color(0xFF159FEF), size: 36),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '01:24:08',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Deep Cleaning in progress',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Worker Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/profile1.png'), // Placeholder
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Elena Rodriguez',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Verified',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: const [
                                Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
                                SizedBox(width: 4),
                                Text(
                                  '4.9 (124 jobs)',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF0F172A), size: 18),
                          label: const Text(
                            'Message',
                            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_outlined, color: Color(0xFF0F172A), size: 18),
                          label: const Text(
                            'Call',
                            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Task Checklist
            const Text(
              'Task Checklist',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                  _buildChecklistItem(
                    title: 'Living Room & Common Areas',
                    value: task1,
                    onChanged: (val) => setState(() => task1 = val!),
                    isLast: false,
                  ),
                  _buildChecklistItem(
                    title: 'Kitchen Deep Clean',
                    value: task2,
                    onChanged: (val) => setState(() => task2 = val!),
                    isLast: false,
                  ),
                  _buildChecklistItem(
                    title: 'Master Bathroom',
                    value: task3,
                    onChanged: (val) => setState(() => task3 = val!),
                    isLast: false,
                  ),
                  _buildChecklistItem(
                    title: 'Bedrooms & Dusting',
                    value: task4,
                    onChanged: (val) => setState(() => task4 = val!),
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Safety and Support Cards
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.shield_outlined,
                    title: 'Safety Center',
                    iconColor: const Color(0xFF159FEF),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.help_outline,
                    title: 'Support',
                    iconColor: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Record Incident Button
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportIssueScreen()),
                  );
                },
                icon: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 18),
                label: const Text(
                  'Record Incident / Report Issue',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFFDC2626),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Requested Booking Details Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActiveBookingDetailsScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF159FEF), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF159FEF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Requested End Task Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const VerifyServiceEndScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626), // Red color for ending task
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'End Task',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required bool isLast,
  }) {
    return Column(
      children: [
        CheckboxListTile(
          value: value,
          onChanged: onChanged,
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: value ? const Color(0xFF64748B) : const Color(0xFF1E293B),
              decoration: value ? TextDecoration.lineThrough : null,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: const Color(0xFF159FEF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Color(0xFFF1F5F9), height: 1),
          ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
