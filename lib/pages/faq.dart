//creer la page faq qui affiche Aide
import 'package:flutter/material.dart';
import 'package:flutter_espace_client_app/components/global_fab.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAQ")),
      body: Center(child: Text("Page FAQ")),
      floatingActionButton: const GlobalFloatingActionButtons(),
    );
  }
}
