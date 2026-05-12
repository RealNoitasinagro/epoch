// In lib/build_info.dart
const kBuildTimestamp = String.fromEnvironment(
  'BUILD_TIMESTAMP',
  defaultValue: 'development build',
);
