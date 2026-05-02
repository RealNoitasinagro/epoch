import 'package:flutter/material.dart';

class CuriositiesTab extends StatelessWidget {
  final DateTime now;
  const CuriositiesTab({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Curiosities – coming soon'),
    );
  }
}