import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class HomePage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const HomePage({ super.key, required this.onLoginSuccess});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  bool loading = false;
  String? error;

  Future<void> login() async {
    setState(() {
      loading = true;
      error = null;
    });

    final apiUrl = dotenv.env['API_URL'] ?? '';
    final url = Uri.parse('$apiUrl/api/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token']; // assume API renvoie { "token": "..." }
      if (token != null) {
        await storage.write(key: 'jwt', value: token);
        widget.onLoginSuccess(); // met à jour la nav dans main.dart
      } else {
        setState(() {
          error = "Token introuvable";
        });
      }
    } else {
      setState(() {
        error = "Erreur de connexion : ${response.statusCode}";
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          welcomeCard(context),
          Text("SE CONNECTER", style: TextStyle(fontSize: 20)),
          separationBorder(),
          Text("Si vous avez déjà un compte, identifiez-vous."),
          SizedBox(height: 10),
          formLogin(),
          SizedBox(height: 24),
          if (error != null)
            Text(error!, style: TextStyle(color: Colors.red)),
          SizedBox(height: 16),
          loading
              ? CircularProgressIndicator()
              : ElevatedButton(onPressed: login, child: Text('Se connecter')),
        ],
      ),
    );
  }

  // ...existing code...

  Widget separationBorder() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 7,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // Welcome Card Widget
  Widget welcomeCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'BIENVENUE\nSUR VOTRE ESPACE CLIENT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Cet espace vous permet de gérer vos contrats, de déclarer des sinistres, et de suivre l'état d'avancement de vos dossiers.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Counter Display Widget
  Widget counterDisplay(BuildContext context, int counter) {
    return Column(
      children: [
        const Text(
          'You have pushed the button this many times:',
          style: TextStyle(color: Colors.red),
        ),
        Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
        Text(
          '${counter + 1}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  Widget formLogin() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegex.hasMatch(value)) {
                return 'Format d\'email invalide';
              }
              return null;
            },
          ),

          //input password
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),

          //login button
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 48),
            ),
            child: Text("Se connecter"),
          ),
          // mot de passe oublié avec lien de reinitialisation
          TextButton(
            onPressed: () {
              // Handle forgot password action
            },
            child: Text("Mot de passe oublié ?"),
          ),
        ],
      ),
    );
  }
}
