
import 'package:flutter/material.dart';

class MesContratsPage extends StatelessWidget {
  const MesContratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Contrats"),
      ),
      body: Center(
        child: Text("Liste de mes contrats"),
      ),
    );
  }
}
