//creer la page faq qui affiche Aide
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
