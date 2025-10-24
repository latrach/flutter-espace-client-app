import 'package:flutter/material.dart';


class GlobalFloatingActionButtons extends StatelessWidget {
  final bool showMesContrats;
  final bool showFaq;
  const GlobalFloatingActionButtons({
    super.key,
    this.showMesContrats = true,
    this.showFaq = true,
  });

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

    List<Widget> buttons = [];
    if (showMesContrats) {
      buttons.add(FloatingActionButton(
        heroTag: 'mesContratsBtn',
        onPressed: linkMesContrats,
        tooltip: 'Mes contrats',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.file_copy, color: Colors.white),
      ));
    }
    if (showFaq) {
      if (buttons.isNotEmpty) buttons.add(SizedBox(width: 16));
      buttons.add(FloatingActionButton(
        heroTag: 'faqBtn',
        onPressed: linkFaq,
        tooltip: 'Aide',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.help, color: Colors.white),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: buttons,
    );
  }
}
