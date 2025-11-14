import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const LoadingWidget({
    super.key,
    this.size = 50.0,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color: color ?? AppColors.primary,
            size: size,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double size;
  final Color? color;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    this.isLoading = false,
    this.size = 50.0,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: LoadingWidget(
              size: size,
              color: color,
              message: message,
            ),
          ),
      ],
    );
  }
}

class ButtonLoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;

  const ButtonLoadingWidget({
    super.key,
    this.size = 20.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: color ?? Colors.white,
      size: size,
    );
  }
}

class ListLoadingWidget extends StatelessWidget {
  final Color? color;

  const ListLoadingWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SpinKitWave(
          color: color ?? AppColors.primary,
          size: 30.0,
        ),
      ),
    );
  }
}

class RefreshLoadingWidget extends StatelessWidget {
  final Color? color;

  const RefreshLoadingWidget({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SpinKitPulse(
        color: color ?? AppColors.primary,
        size: 30.0,
      ),
    );
  }
}
