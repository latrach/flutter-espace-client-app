import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/mes_contrats.dart';
import 'pages/faq.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(title: 'Accueil'),
    MesContratsPage(title: 'Mes contrats'),
    FaqPage(title: 'Aide'),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.file_copy_outlined),
            selectedIcon: Icon(Icons.file_copy),
            label: 'Mes contrats',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.help),
            label: 'Aide',
          ),
        ],
      ),
    );
  }
}
