import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/territory_provider.dart';
import 'src/screens/app_shell.dart';
import 'src/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = TerritoryProvider();
  await provider.load();
  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: const TerritorioApp(),
    ),
  );
}

class TerritorioApp extends StatelessWidget {
  const TerritorioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Território Inteligente',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
