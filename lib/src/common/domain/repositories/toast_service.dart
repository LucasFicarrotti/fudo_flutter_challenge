import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastService {
  void error({
    required String title,
    String? subtitle,
  }) {
    BotToast.showNotification(
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      align: const Alignment(0, .8),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.withOpacity(.9),
      leading: (_) => const Icon(
        Icons.error,
        color: Colors.white,
      ),
      title: (_) => Text(
        title,
        style: const TextStyle(color: Colors.white, height: 1.3),
      ),
      subtitle: subtitle != null
          ? (_) => Text(
                subtitle,
                style: const TextStyle(color: Colors.white, height: 1.3),
              )
          : null,
    );
  }

  void success({
    required String title,
    String? subtitle,
  }) {
    BotToast.showNotification(
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      align: const Alignment(0, .8),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green.withOpacity(.9),
      leading: (_) => const Icon(
        Icons.check_rounded,
        color: Colors.white,
      ),
      title: (_) => Text(
        title,
        style: const TextStyle(color: Colors.white, height: 1.3),
      ),
      subtitle: subtitle != null
          ? (_) => Text(
                subtitle,
                style: const TextStyle(color: Colors.white, height: 1.3),
              )
          : null,
    );
  }
}
