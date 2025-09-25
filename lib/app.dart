import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

class PropertyCalcApp extends StatelessWidget {
  const PropertyCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Property Calc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark, // simple dark theme like your mockups
      routes: appRoutes,
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final user = snap.data;
        if (user == null) {
          return const LoginScreen();
        }
        return const HomeScreen();
      },
    );
  }
}
