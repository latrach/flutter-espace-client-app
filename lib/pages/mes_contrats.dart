import 'package:flutter/material.dart';
import 'package:flutter_espace_client_app/components/global_fab.dart';

class MesContratsPage extends StatelessWidget {
  const MesContratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes Contrats")),
      body: Center(child: Text("Liste de mes contrats")),
      floatingActionButton: const GlobalFloatingActionButtons(),
    );
  }
}
