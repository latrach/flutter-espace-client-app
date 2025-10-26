//creer la page faq qui affiche Aide
import 'package:flutter/material.dart';

class AidePage extends StatelessWidget {
  const AidePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Aide'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Text('Aller à l\'accueil'),
          ),
        ],
      ),
    );
  }
}
