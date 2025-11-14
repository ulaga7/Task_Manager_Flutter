import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/parse_service.dart';
import 'services/auth_service.dart';
import 'services/task_service.dart';
import 'screens/entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ParseService.initialize(
    appId: String.fromEnvironment('PARSE_APP_ID'), // not pushing the keys to repo
    clientKey: String.fromEnvironment('PARSE_CLIENT_KEY'), // not pushing the keys to repo
    serverUrl: 'https://parseapi.back4app.com/',
  );

  // Restore previous Parse session
  final authService = AuthService();
  await authService.restoreSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: authService),
        ChangeNotifierProxyProvider<AuthService, TaskService>(
          create: (_) => TaskService(),
          update: (_, auth, tasks) => tasks!..updateUser(auth.currentUser),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const EntryScreen(),
    );
  }
}
