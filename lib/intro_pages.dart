import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> pages = [
  _OnboardingPageData(
    imagePath: '../assets/images/intro-1.jpg',
    title: 'Welcome In Your Medscan',
    subtitle: 'We Care About Your Health',
  ),
  _OnboardingPageData(
    imagePath: '../assets/images/intro-2.jpg',
    title: 'All You Need for Your Health',
    subtitle:'Book medical tests and radiology scans all in one place!',
  ),
  _OnboardingPageData(
    imagePath: '../assets/images/intro-3.jpg',
    title: 'Find Nearby Labs',
    subtitle: 'Use your location to discover the closest medical labs with available services and prices.',
  ),
];


  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Navigate to login or home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: pages.length,
                itemBuilder: (context, index) => _buildPage(pages[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF383BD9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
                child: Text(_currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                style: TextStyle(color: Colors.white70),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPageData data) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue, // لون الحدود
            width: 3,           // سمك الحدود
          ),
          borderRadius: BorderRadius.circular(16), // زوايا دائرية
          image: DecorationImage(
            image: AssetImage(data.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 32),
      Text(
        data.title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 12),
      Text(
        data.subtitle,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    ],
  )

    );
  }
}

class _OnboardingPageData {
  final String imagePath;
  final String title;
  final String subtitle;

  _OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
