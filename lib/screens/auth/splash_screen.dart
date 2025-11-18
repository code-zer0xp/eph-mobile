import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/styles/app_text_styles.dart';
import '../../widgets/loading/loading_widget.dart';
import '../../utils/images/image_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryLight,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ImageHelper.appLogoWidget(
                            width: 96,
                            height: 96,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'ExplorePH',
                        style: AppTextStyles.headline2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Connect travelers with stays, experiences, and local businesses across the Philippines.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText2.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const LoadingWidget(
                  size: 36,
                  color: Colors.white,
                  message: 'Loading your next adventure...',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
