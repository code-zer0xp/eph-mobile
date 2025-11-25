import 'package:flutter/material.dart';

class ImageHelper {
  // App logo
  static const String appLogo = 'assets/images/logo1.png';

  // Placeholder images
  static const String placeholder = 'assets/images/placeholder.png';
  static const String profilePlaceholder =
      'assets/images/profile_placeholder.png';

  // Load image from assets with error handling
  static Widget loadImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return placeholder ?? _defaultPlaceholder();
      },
    );
  }

  // Load network image with error handling
  static Widget loadNetworkImage(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
  }) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return placeholder ?? _defaultPlaceholder();
      },
    );
  }

  // Default placeholder widget
  static Widget _defaultPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 48,
      ),
    );
  }

  // Get app logo widget
  static Widget appLogoWidget({
    double? width,
    double? height,
  }) {
    return loadImage(
      appLogo,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
