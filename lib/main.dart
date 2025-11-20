import 'package:exploreph/screens/auth/login_screen.dart';
import 'package:exploreph/screens/auth/signup_screen.dart';
import 'package:exploreph/screens/onboarding/onboarding_screen.dart';
import 'package:exploreph/screens/profile/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'utils/themes/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
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
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
        '/main': (context) => const MainScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isLoading = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SettingsScreen(),
  ];

  void _showToastDemo() {
    ToastHelper.showInfoToast(message: 'Welcome to ExplorePH!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        isLoading: _isLoading,
        message: 'Loading amazing destinations...',
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showToastDemo,
        child: const Icon(Icons.notifications),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ExplorePH Settings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ToastHelper.showSuccessToast(message: 'Settings saved!');
              },
              child: const Text('Save Settings'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ToastHelper.showWarningToast(
                  message: 'This is a warning message',
                );
              },
              child: const Text('Show Warning'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                ToastHelper.showErrorToast(
                  message: 'This is an error message',
                );
              },
              child: const Text('Show Error'),
            ),
          ],
        ),
      ),
    );
  }
}
