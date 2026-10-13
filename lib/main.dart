import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'ui/screens/screens.dart';
import 'ui/theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return MaterialApp(
      title: 'Hostel Management',
      theme: AppTheme.getTheme(appProvider.themeColor),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
