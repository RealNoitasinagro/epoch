import 'package:flutter/material.dart';

class AstronomyTab extends StatelessWidget {
  final DateTime now;
  const AstronomyTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Astronomy – coming soon'),
    );
  }
}