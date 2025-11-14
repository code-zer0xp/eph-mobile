import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_colors.dart';

class ToastHelper {
  static void showToast({
    required String message,
    ToastType type = ToastType.info,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (type) {
      case ToastType.success:
        backgroundColor = AppColors.success;
        break;
      case ToastType.error:
        backgroundColor = AppColors.error;
        break;
      case ToastType.warning:
        backgroundColor = AppColors.warning;
        break;
      case ToastType.info:
      default:
        backgroundColor = AppColors.info;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength:
          duration.inSeconds >= 3 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }

  static void showSuccessToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: ToastType.success,
      gravity: gravity,
      duration: duration,
    );
  }

  static void showErrorToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: ToastType.error,
      gravity: gravity,
      duration: duration,
    );
  }

  static void showWarningToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: ToastType.warning,
      gravity: gravity,
      duration: duration,
    );
  }

  static void showInfoToast({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: ToastType.info,
      gravity: gravity,
      duration: duration,
    );
  }

  static void showCenterToast({
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: type,
      gravity: ToastGravity.CENTER,
      duration: duration,
    );
  }

  static void showTopToast({
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    showToast(
      message: message,
      type: type,
      gravity: ToastGravity.TOP,
      duration: duration,
    );
  }
}

enum ToastType {
  success,
  error,
  warning,
  info,
}
