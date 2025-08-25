import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation {
  static Future<void> showSuccess({
    required BuildContext context,
    String message = "Account created successfully!",
    String lottieAsset = 'assets/animations/success_circle_check.json',
    Duration? duration,
    VoidCallback? onCompleted,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              lottieAsset,
              width: 200,
              height: 200,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(duration ?? composition.duration, () {
                  Navigator.of(context).pop();
                  if (onCompleted != null) onCompleted();
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
