import 'package:exploreph/screens/auth/login_screen.dart';
import 'package:exploreph/screens/auth/signup_screen.dart';
import 'package:exploreph/screens/home/home_screen.dart';
import 'package:exploreph/screens/onboarding/onboarding_screen.dart';
import 'package:exploreph/screens/profile/profile_setup_screen.dart';
import 'package:exploreph/screens/main/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'utils/themes/app_theme.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/forgot_password_screen.dart';

void main() {
  runApp(const ExplorePHApp());
}

class ExplorePHApp extends StatelessWidget {
  const ExplorePHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExplorePH',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainDashboard(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
        '/main': (context) => const MainDashboard(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
