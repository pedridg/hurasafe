import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
   
    final List<Map<String, dynamic>> alerts = [
      {
        "nivel": "Roja",
        "descripcion":
            "Peligro extremo: Un huracán categoría 5 se acerca con vientos mayores a 260 km/h y condiciones muy peligrosas. se espera fuerte oleaje, lluvias intensas y posible marejada cliclónica. se recomienda evacuar zonas costeras y buscar refugio seguro de inmediato.",
        "color": Colors.red
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alertas actuales"),
        backgroundColor: const Color(0xffcfc6ff),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alerta = alerts[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  // Círculo de color según la alerta
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: alerta["color"],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Texto de la alerta
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alerta["nivel"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          alerta["descripcion"],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
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
