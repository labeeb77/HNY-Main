import 'package:flutter/material.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class OnboardingInfo {
  final String imageAsset;
  final String title;
  final String description;
  final String buttonText;

  OnboardingInfo({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingInfo info;

  const OnboardingPage({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            info.imageAsset,
            fit: BoxFit.cover,
          ),
        ),
        // Overlay content
        Positioned.fill( 
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Main content
        Positioned(
          left: 0,
          right: 0,
          bottom: 100,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  info.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingInfo> pages = [
    OnboardingInfo(
      imageAsset: 'assets/images/My Bookings14.png',
      title: 'Find Your Perfect Ride',
      description:
          'Browse a wide selection of cars for every journey, big or small.',
      buttonText: 'Get Started',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/My Bookings15.png',
      title: 'Easy Booking',
      description: 'Book your car in just a few taps, anytime, anywhere.',
      buttonText: 'Next',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/My Bookings16.png',
      title: 'Enjoy the Journey',
      description: 'Experience comfort and convenience on every trip.',
      buttonText: 'Let\'s Go',
    ),
  ];

  void _onNext() {
    if (_currentIndex < pages.length - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(info: pages[index]);
            },
          ),
          // Bottom controls
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width:_currentIndex == index?21:7,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ?  AppColors.primary
                              : Colors.white54,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  // Button
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      onPressed: _onNext,
                      child: Text(
                        pages[_currentIndex].buttonText,
                        style: const TextStyle(fontSize: 18,color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
