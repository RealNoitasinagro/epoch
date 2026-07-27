final kBuildInfo = const String.fromEnvironment(
  'BUILD_INFO',
  defaultValue: "You've found an easter egg! 🥚",
).replaceAll(' | ', '\n');
