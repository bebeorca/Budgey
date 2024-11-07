import 'package:budgey/presentation/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budgey',
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 0, 49, 97),
          foregroundColor: Colors.white,
          iconSize: 28,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 49, 97),
          ),
        ),
        
        scaffoldBackgroundColor: const Color.fromARGB(255, 252, 250, 238),
        textTheme: GoogleFonts.rubikTextTheme(),
        useMaterial3: true,
      ),
      home: const ReportsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
