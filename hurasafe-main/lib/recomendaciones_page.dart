import 'package:flutter/material.dart';
import 'recomendacion_verde.dart';
import 'recomendacion_amarilla.dart';
import 'recomendacion_roja.dart';

class RecomendacionesPage extends StatelessWidget {
  const RecomendacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Recomendaciones"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            const Text(
              "Semáforo de acción ante ciclones y huracanes",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 40),

            botonColor(
              label: "VERDE",
              color: const Color(0xff87e38a),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecomendacionVerde()),
                );
              },
            ),

            botonColor(
              label: "AMARILLA",
              color: const Color(0xfff7e86b),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecomendacionAmarilla()),
                );
              },
            ),

            botonColor(
              label: "ROJA",
              color: const Color(0xffff8a8a),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecomendacionRoja()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget botonColor({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

