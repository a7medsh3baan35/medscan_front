import 'package:flutter/material.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "User Name"; // سيتم تحديثه من بيانات المستخدم

  final List<Widget> _screens = [
    const MainHomeSection(),
    const BookingsHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0a66c2),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class MainHomeSection extends StatelessWidget {
  const MainHomeSection({super.key});

  @override
  Widget build(BuildContext context) {   
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome to Medscan 👋',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            'Our Services',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Cards stacked vertically with blue border and rounded corners
          _buildServiceCard(context, Icons.biotech, 'Medical Tests'),
          const SizedBox(height: 16),
          _buildServiceCard(context, Icons.local_hospital, 'Radiology'),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, IconData icon, String label) {
    String type = label == 'Medical Tests' ? 'Medical Test' : 'Radiology';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/booking',
          arguments: {'type': type},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0a66c2), width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF0a66c2)),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}