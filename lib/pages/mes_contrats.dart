import 'package:flutter/material.dart';

class MesContratsPage extends StatelessWidget {
  const MesContratsPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title),
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