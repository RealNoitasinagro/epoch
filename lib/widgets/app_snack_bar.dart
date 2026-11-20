import 'package:flutter/material.dart';
import '../app/layout_constants.dart';

/// Shows [message] as a floating snack bar. It replaces a snack bar that is
/// still showing: the latest message counts, none queues up. [duration] is
/// one of the kSnackBar… constants.
void showAppSnackBar(
  BuildContext context,
  String message, {
  Duration duration = kSnackBarStandard,
}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
