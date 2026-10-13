// Laborator 1 - Calculator consum combustibil


import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Consum Combustibil',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // ascunde banner-ul "DEBUG" din colț
      home: const ConsumoCalculatorPage(),
    );
  }
}


class ConsumoCalculatorPage extends StatefulWidget {
  const ConsumoCalculatorPage({super.key});

  @override
  State<ConsumoCalculatorPage> createState() => _ConsumoCalculatorPageState();
}


class _ConsumoCalculatorPageState extends State<ConsumoCalculatorPage> {
  // Controller-ele "citesc" ce scrie utilizatorul în TextField-uri.
  final TextEditingController _distantaController = TextEditingController();
  final TextEditingController _combustibilController = TextEditingController();


  String _rezultat = '';

  // Această funcție se apelează la apăsarea butonului.
  void _calculeazaConsum() {

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


    setState(() {
      // toStringAsFixed(2) rotunjește la 2 zecimale, pentru afișare frumoasă.
      _rezultat = 'Consum mediu: ${consumMediu.toStringAsFixed(2)} L/100km';
    });
  }


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