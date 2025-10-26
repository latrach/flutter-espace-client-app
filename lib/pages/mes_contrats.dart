import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MesContratsPage extends StatefulWidget {
  const MesContratsPage({super.key});
  @override
  State<MesContratsPage> createState() => _MesContratsPageState();
}

class _MesContratsPageState extends State<MesContratsPage> {
  final _storage = FlutterSecureStorage();
  bool loading = true;
  String? error;
  List<dynamic> contrats = [];

  @override
  void initState() {
    super.initState();
    fetchContrats();
  }

  Future<void> fetchContrats() async {
    setState(() {
      loading = true;
      error = null;
    });

    final token = await _storage.read(key: 'jwt');
    if (token == null) {
      setState(() {
        error = 'Utilisateur non connecté';
        loading = false;
      });
      return;
    }

    final apiUrl = dotenv.env['API_URL'] ?? '';
    final url = Uri.parse('$apiUrl/api/mes-contrats');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        contrats = data; // suppose que l'API renvoie une liste JSON
        loading = false;
      });
    } else if (response.statusCode == 401) {
      setState(() {
        error = 'Token invalide ou expiré';
        loading = false;
      });
    } else {
      setState(() {
        error = 'Erreur API : ${response.statusCode}';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Mes Contrats'),
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
