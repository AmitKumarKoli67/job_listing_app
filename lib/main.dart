import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/job_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobProvider()..fetchJobs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Job Listing App',
        theme: ThemeData(
          brightness: Brightness.light,
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
