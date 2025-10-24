import 'package:flutter/material.dart';

class GlobalFloatingActionButtons extends StatelessWidget {
  const GlobalFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    void linkMesContrats() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Mes contrats")),
          body: Center(child: Text("Page Mes contrats")),
        )),
      );
    }

    void linkFaq() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Scaffold(
          appBar: AppBar(title: Text("FAQ")),
          body: Center(child: Text("Page FAQ")),
        )),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: linkMesContrats,
          tooltip: 'Mes contrats',
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.file_copy, color: Colors.white),
        ),
        SizedBox(width: 16),
        FloatingActionButton(
          onPressed: linkFaq,
          tooltip: 'Aide',
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.help, color: Colors.white),
        ),
      ],
    );
  }
}
