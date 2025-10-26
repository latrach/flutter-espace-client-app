import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onLogout();
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, size: 48),
          SizedBox(height: 16),
          Text('Déconnexion en cours...'),

        ],
      ),
    );
  }
}
