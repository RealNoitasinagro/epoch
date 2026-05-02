import 'package:flutter/material.dart';

class TechnicalTab extends StatelessWidget {
  final DateTime now;
  const TechnicalTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Technical – coming soon'),
    );
  }
}