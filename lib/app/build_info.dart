final kBuildInfo = const String.fromEnvironment(
  'BUILD_INFO',
  defaultValue: "You've found an Easter egg! 🥚",
).replaceAll(' | ', '\n');
