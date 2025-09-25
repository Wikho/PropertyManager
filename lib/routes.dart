import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';

class AppRoute {
  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot';
  static const home = '/home';
}

final Map<String, WidgetBuilder> appRoutes = {
  AppRoute.login: (_) => const LoginScreen(),
  AppRoute.register: (_) => const RegisterScreen(),
  AppRoute.forgot: (_) => const ForgotPasswordScreen(),
  AppRoute.home: (_) => const HomeScreen(),
};
