import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  final StatefulNavigationShell navigationShell;

  const HomeScreen(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Hoy"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Historial",
          ),
        ],
      ),
    );
  }
}
