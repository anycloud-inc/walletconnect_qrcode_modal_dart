import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClipboardManager {
  static Future<void> copy(BuildContext context, {required String text}) async {
    final data = ClipboardData(text: text);
    await Clipboard.setData(data);

    HapticFeedback.lightImpact();
  }
}
