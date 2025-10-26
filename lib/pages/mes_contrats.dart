import 'package:flutter/material.dart';

class MesContratsPage extends StatelessWidget {
  const MesContratsPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
