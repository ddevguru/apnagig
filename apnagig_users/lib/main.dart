import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apnagig_users/features/auth/presentation/SplashScreen.dart';
import 'package:apnagig_users/features/auth/presentation/OnboardingScreen.dart';
import 'features/dashboard/bloc/navigation_bloc.dart';
import 'features/booking/bloc/booking_bloc.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ApnaGigApp());
}

class ApnaGigApp extends StatelessWidget {
  const ApnaGigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        BlocProvider<BookingBloc>(create: (context) => BookingBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ApnaGig',
        theme: AppTheme.lightTheme,
        home: Builder(
          builder: (context) {
            return SplashScreen(
              onFinished: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OnboardingScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}