import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.onFinished,
  });

  final VoidCallback? onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _dotsController;

  late Animation<double> _logoAnimation;
  late Animation<double> _brandAnimation;
  late Animation<double> _taglineAnimation;
  late Animation<double> _dotsAnimation;

  Timer? _timer;

  static const Color primaryColor = Color(0xFF159FEF);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF20242B);

  @override
  void initState() {
    super.initState();

    // Main entrance animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Loading dots animation
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _logoAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.65,
        curve: Curves.easeOutCubic,
      ),
    );

    _brandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.1,
        0.75,
        curve: Curves.easeOutCubic,
      ),
    );

    _taglineAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.2,
        0.9,
        curve: Curves.easeOutCubic,
      ),
    );

    _dotsAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.3,
        1.0,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();

    // Same idea as your HTML setTimeout(3000)
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Widget _fadeSlide({
    required Animation<double> animation,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final value = animation.value;

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          // Responsive values
          final bool isSmallPhone = width < 380;
          final bool isTablet = width >= 600;
          final bool isLargeScreen = width >= 1000;

          final double logoSize = isLargeScreen
              ? 128
              : isTablet
                  ? 116
                  : isSmallPhone
                      ? 76
                      : 96;          final double brandSize = isLargeScreen
              ? 38
              : isTablet
                  ? 34
                  : isSmallPhone
                      ? 26
                      : 30;

          final double horizontalPadding = isLargeScreen
              ? 80
              : isTablet
                  ? 48
                  : isSmallPhone
                      ? 16
                      : 20;

          return Stack(
            children: [
              // Background decorative gradients
              const _BackgroundDecoration(),

              // Main content
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom,
                        maxWidth: 600,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo
                            _fadeSlide(
                              animation: _logoAnimation,
                              child: Container(
                                width: logoSize,
                                height: logoSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    isTablet ? 30 : 24,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/logo.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.20),
                                      blurRadius: 30,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: isTablet ? 28 : 24,
                            ),

                            // Brand name
                            _fadeSlide(
                              animation: _brandAnimation,
                              child: Text(
                                'ApnaGig',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: brandSize,
                                  height: 1.15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.8,
                                  color: primaryColor,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Slogan
                            _fadeSlide(
                              animation: _taglineAnimation,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: Text(
                                  'Your Trusted Partner for Every Task.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: isSmallPhone ? 14 : (isTablet ? 17 : 16),
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: isTablet ? 34 : 32,
                            ),

                            // Loading dots
                            _fadeSlide(
                              animation: _dotsAnimation,
                              child: const LoadingDots(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ------------------------------------------------------------
/// BACKGROUND DECORATION
/// ------------------------------------------------------------

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background pattern illustration
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Top-right soft blue glow
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF159FEF).withOpacity(0.07),
                    const Color(0xFF159FEF).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Bottom-left soft blue glow
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF159FEF).withOpacity(0.06),
                    const Color(0xFF159FEF).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// LOADING DOTS
/// ------------------------------------------------------------

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress =
            (_controller.value + delay) % 1.0;

        double scale;

        if (progress < 0.5) {
          scale = 0.7 + (progress * 0.6);
        } else {
          scale = 1.3 - ((progress - 0.5) * 1.2);
        }

        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF159FEF),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(0.0),
        const SizedBox(width: 4),
        _dot(0.15),
        const SizedBox(width: 4),
        _dot(0.30),
      ],
    );
  }
}