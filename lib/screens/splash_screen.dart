import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../layout_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (mounted) setState(() => _version = 'Epoch v${info.version}');
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 260,
              height: 260,
              child: Image.asset(
                'assets/icon/epoch_icon_splash.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 0, right: 0, bottom: 32,
            child: Text(
              _version,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kColorNightRed,
                fontFamily: fontFamilyDefault,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
