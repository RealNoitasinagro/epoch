import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LocationService {
  static const _channel = MethodChannel(
      'io.github.RealEarthling.epoch/location');

  /// Returns the last known longitude, or null if unavailable.
  /// Does not request GPS, only uses cached network/passive location.
  static Future<double?> getLastKnownLongitude() async {
    try {
      final result = await _channel
          .invokeMapMethod<String, dynamic>('getLastKnownLocation')
          .timeout(const Duration(seconds: 20));
      return (result?['longitude'] as num?)?.toDouble();
    } on PlatformException catch (e) {
      debugPrint('Location error: ${e.code} – ${e.message}');
      return null;
    } on TimeoutException {
      debugPrint('Location timeout');
      return null;
    }
  }
}