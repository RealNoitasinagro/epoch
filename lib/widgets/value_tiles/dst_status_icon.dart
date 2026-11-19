import 'package:flutter/material.dart';
import '../../app/layout_constants.dart';
import '../../models/time_value.dart';

extension TimeValueIcons on TimeValue {
  IconData? dstStatusIcon(DateTime nowUtc, String localIanaZone) {
    switch (effectiveClockChangeMode(nowUtc, localIanaZone)) {
      case TimezoneClockChangeMode.forceDst:
        return kIconDstActive;
      case TimezoneClockChangeMode.forceStandard:
        return kIconDstInactive;
      case TimezoneClockChangeMode.auto:
        break;
    }
    // auto: determine actual current DST status:
    return switch (isDstCurrentlyActive(nowUtc, localIanaZone)) {
      true => kIconDstActive,
      false => kIconDstInactive,
      null => null,
    };
  }
}
