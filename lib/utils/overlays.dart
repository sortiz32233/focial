import 'package:flutter/material.dart';
import 'package:ots/ots.dart';

class AppOverlays {
  static void showSuccess(String title, String message) {
    showNotification(
      title: title,
      message: message,
      backgroundColor: Colors.greenAccent,
      autoDismissible: true,
      notificationDuration: 3000,
      animDuration: 400,
      messageStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }

  static void showError(String title, String message) {
    showNotification(
      title: title,
      message: message,
      backgroundColor: Colors.redAccent,
      autoDismissible: true,
      notificationDuration: 3000,
      animDuration: 400,
      messageStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }
}
