import 'package:flutter/foundation.dart';

bool get isDesktopPlatform =>
    defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS;
