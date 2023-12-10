import 'package:flutter/material.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';

class SnackBarUtil {
  static GlobalKey<ScaffoldMessengerState> key =
  GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, Colors.white));
  }

  static void showMessage(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, Colors.white));
  }

  static void showSuccess(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(drawSnackBar(message, Colors.white));
  }

  static SnackBar drawSnackBar(String message, Color color) {
    return SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        textAlign: TextAlign.center,
        softWrap: false,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(
        vertical: kPaddingMiddleSize,
        horizontal: kPaddingSmallSize,
      ),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
