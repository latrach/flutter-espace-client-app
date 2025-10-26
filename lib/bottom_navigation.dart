import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'pages/home.dart';
import 'pages/mes_contrats.dart';
import 'pages/aide.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  final storage = FlutterSecureStorage();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await storage.read(key: 'jwt');
    setState(() {
      isLoggedIn = token != null;
    });
  }

  void logout() async {
    await storage.delete(key: 'jwt');
    setState(() {
      isLoggedIn = false;
      selectedIndex = 0; // revient sur Home
    });
  }

  void onNavTap(int index) {
    // calculer index réel en fonction de l’état de connexion
    int logoutIndex = isLoggedIn ? 3 : -1;
    if (index == logoutIndex) {
      logout();
    } else {
      setState(() => selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // liste dynamique des pages
    final pages = [
      HomePage(onLoginSuccess: checkLoginStatus),
      if (isLoggedIn) MesContratsPage(),
      AidePage(),
    ];


    return Scaffold(
      appBar: AppBar(
        //title: Text(titles[selectedIndex]),
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onNavTap,
        destinations: [
          // Home
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          // Mes Contrats
          if (isLoggedIn) NavigationDestination(
            icon: Icon(Icons.file_copy_outlined),
            selectedIcon: Icon(Icons.file_copy),
            label: 'Mes Contrats'
          ),
          // Aide
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.help),
            label: 'Aide',
          ),
          // Logout
          if (isLoggedIn) NavigationDestination(
            icon: Icon(Icons.logout_outlined),
            selectedIcon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
