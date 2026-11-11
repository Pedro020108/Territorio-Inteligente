import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'alerts_screen.dart';
import 'occurrences_screen.dart';
import 'about_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override State<AppShell> createState() => _AppShellState();
}
class _AppShellState extends State<AppShell> {
  int index = 0;
  final pages = const [DashboardScreen(), AlertsScreen(), OccurrencesScreen(), AboutScreen()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: IndexedStack(index: index, children: pages)),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Painel'),
        NavigationDestination(icon: Icon(Icons.notifications_active_outlined), label: 'Alertas'),
        NavigationDestination(icon: Icon(Icons.add_location_alt_outlined), label: 'Ocorrências'),
        NavigationDestination(icon: Icon(Icons.info_outline), label: 'Sobre'),
      ]),
  );
}
