import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
    login() {
      // afficher le mail et mot de passe
      String email = emailController.text;
      String password = passwordController.text;
      //alert avec email
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Informations de connexion"),
            content: Text("Email: $email\nMot de passe: $password"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

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
