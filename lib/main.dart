// main.dart
// Laborator 1 - Calculator consum combustibil
// Varianta 3

// Importăm pachetul Material Design - conține toate widget-urile
// standard (TextField, ElevatedButton, Scaffold, etc.)
import 'package:flutter/material.dart';

// Funcția main() este punctul de start al oricărei aplicații Dart/Flutter.
// runApp() "montează" widget-ul rădăcină pe ecran.
void main() {
  runApp(const MyApp());
}

// MyApp este widget-ul rădăcină al aplicației.
// Este StatelessWidget pentru că el însuși nu se schimbă niciodată -
// el doar setează tema și ecranul principal.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Consum Combustibil',
      // Tema generală a aplicației (culori, stiluri implicite)
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // ascunde banner-ul "DEBUG" din colț
      home: const ConsumoCalculatorPage(),
    );
  }
}

// Acesta este ecranul nostru principal.
// ESTE StatefulWidget pentru că textul cu rezultatul se schimbă
// atunci când utilizatorul apasă butonul.
class ConsumoCalculatorPage extends StatefulWidget {
  const ConsumoCalculatorPage({super.key});

  @override
  State<ConsumoCalculatorPage> createState() => _ConsumoCalculatorPageState();
}

// Clasa "State" conține tot ce se poate schimba în timp:
// variabilele, controller-ele și logica de calcul.
class _ConsumoCalculatorPageState extends State<ConsumoCalculatorPage> {
  // Controller-ele "citesc" ce scrie utilizatorul în TextField-uri.
  final TextEditingController _distantaController = TextEditingController();
  final TextEditingController _combustibilController = TextEditingController();

  // Variabila în care păstrăm textul rezultatului afișat.
  // Începe goală (nimic afișat până nu se apasă butonul).
  String _rezultat = '';

  // Această funcție se apelează la apăsarea butonului.
  void _calculeazaConsum() {
    // Citim textul din câmpuri și îl convertim în numere (double).
    // double.tryParse() întoarce null dacă textul nu e un număr valid,
    // în loc să arunce o eroare - de aceea îl folosim, nu double.parse().
    final double? distanta = double.tryParse(_distantaController.text);
    final double? combustibil = double.tryParse(_combustibilController.text);

    // Verificăm datele introduse de utilizator (validare simplă).
    if (distanta == null || combustibil == null) {
      setState(() {
        _rezultat = 'Introduceți valori numerice valide.';
      });
      return; // oprim execuția aici
    }

    if (distanta <= 0) {
      setState(() {
        _rezultat = 'Distanța trebuie să fie mai mare decât 0.';
      });
      return;
    }

    // Formula consumului mediu: (litri / km) * 100
    final double consumMediu = (combustibil / distanta) * 100;

    // setState() spune lui Flutter: "am schimbat o variabilă,
    // te rog redesenează interfața cu noua valoare".
    setState(() {
      // toStringAsFixed(2) rotunjește la 2 zecimale, pentru afișare frumoasă.
      _rezultat = 'Consum mediu: ${consumMediu.toStringAsFixed(2)} L/100km';
    });
  }

  // Este bună practică să "eliberăm" controller-ele când widget-ul
  // este distrus, ca să nu ocupăm memorie degeaba.
  @override
  void dispose() {
    _distantaController.dispose();
    _combustibilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar = bara de sus, cu titlul aplicației
      appBar: AppBar(
        title: const Text('Calculator Consum Combustibil'),
        centerTitle: true,
      ),
      // Padding adaugă spațiu în jurul conținutului, ca să nu fie
      // lipit de marginile ecranului.
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // Column aranjează widget-urile unul sub altul, pe verticală.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20), // spațiu gol

            // Primul TextField: distanța parcursă
            TextField(
              controller: _distantaController,
              // Afișează doar tastatura numerică pe telefon
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Distanța parcursă (km)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.route),
              ),
            ),

            const SizedBox(height: 16),

            // Al doilea TextField: cantitatea de combustibil
            TextField(
              controller: _combustibilController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Combustibil consumat (litri)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_gas_station),
              ),
            ),

            const SizedBox(height: 24),

            // Butonul care declanșează calculul
            ElevatedButton(
              onPressed: _calculeazaConsum,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Calculează',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            // Text-ul cu rezultatul - se schimbă automat
            // când _rezultat își schimbă valoarea via setState()
            Text(
              _rezultat,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}