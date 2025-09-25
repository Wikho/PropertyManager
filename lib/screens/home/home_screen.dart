import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';
import '../pages/properties_page.dart';
import '../pages/loans_page.dart';
import '../pages/graphs_page.dart';
import '../pages/calculator_page.dart';
import '../auth/login_screen.dart';
import '../pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  final _pages = const [
    PropertiesPage(),
    LoansPage(),
    GraphsPage(),
    CalculatorPage(),
    SettingsPage(),
  ];

  String get _title => switch (_tab) {
    0 => 'Properties',
    1 => 'Loans',
    2 => 'Graphs',
    3 => 'Calculator',
    _ => 'Property Calc',
  };

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? 'User';
    final email = user?.email ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.transparent),
                accountName: Text(name),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  child: Text((name.isNotEmpty ? name[0] : 'U').toUpperCase()),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Properties'),
                selected: _tab == 0,
                onTap: () => _select(0),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Loans'),
                selected: _tab == 1,
                onTap: () => _select(1),
              ),
              ListTile(
                leading: const Icon(Icons.show_chart),
                title: const Text('Graphs'),
                selected: _tab == 2,
                onTap: () => _select(2),
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculator'),
                selected: _tab == 3,
                onTap: () => _select(3),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                selected: _tab == 4,
                onTap: () => _select(4),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Log out'),
                  onPressed: () async {
                    await AuthService.instance.signOut();
                    if (mounted) {
                      // Clear backstack and show login
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_tab],
    );
  }

  void _select(int i) {
    setState(() => _tab = i);
    Navigator.pop(context); // close drawer
  }
}
