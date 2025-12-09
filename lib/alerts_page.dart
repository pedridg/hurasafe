import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Alertas actuales",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Ícono de alerta
            const Icon(
              Icons.warning_rounded,
              color: Color(0xffB71C1C), // rojo oscuro
              size: 60,
            ),

            const SizedBox(height: 15),

            // Etiqueta "ALERTA ROJA"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xfff8c6c6), // rosa suave
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "ALERTA ROJA",
                style: TextStyle(
                  color: Color(0xffb71c1c),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // TÍTULO
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Peligro extremo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DESCRIPCIÓN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "El huracán Otis se aproxima con vientos de hasta 265 km/h (categoría 5). "
                "Se recomienda evacuar las zonas costeras y buscar refugio seguro inmediatamente.",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/*class AlertPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const AlertPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Lat: $latitude — Lng: $longitude"),
      ),
    );
  }
}*/
class AlertPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const AlertPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alertas actuales")),

      body: Center(
        child: Text(
          "Tu ubicación actual:\nLat: $latitude\nLng: $longitude",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
