import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Vom crea acest fișier imediat

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,

      // CONFIGURAREA TEMEI
      theme: ThemeData(
        useMaterial3: true,

        // Culoarea principală (Verdele Neon)
        primaryColor: const Color(0xFF8EE342),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8EE342),
          primary: const Color(0xFF8EE342),
          secondary: const Color(0xFF1A1A1A), // Negru/Gri închis
          surface: Colors.white,
          background: const Color(0xFFFBFBFB), // Alb foarte deschis
        ),

        // Stiluri de text globale
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
          bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black87
          ),
          bodySmall: TextStyle(
              fontSize: 14,
              color: Colors.grey
          ),
        ),

        // Stilul implicit al butoanelor
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8EE342),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}