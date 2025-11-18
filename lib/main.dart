import 'package:exploreph/screens/auth/login_screen.dart';
import 'package:exploreph/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'utils/themes/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'utils/toast/toast_helper.dart';
import 'widgets/loading/loading_widget.dart';

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
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
