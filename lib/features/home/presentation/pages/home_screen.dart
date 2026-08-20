import 'package:flutter/material.dart';
import 'package:focus_box/core/extensions/translations_extension.dart';
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.l10n.homeToday,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: context.l10n.homeHistorical,
          ),
        ],
      ),
    );
  }
}
