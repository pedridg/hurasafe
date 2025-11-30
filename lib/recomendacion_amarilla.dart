import 'package:flutter/material.dart';

class RecomendacionAmarilla extends StatelessWidget {
  const RecomendacionAmarilla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AMARILLA"),
        centerTitle: true,
        backgroundColor: Color(0xfff7e86b),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            titulo("AMARILLA - Huracán categoría 1 a 3"),

            seccion("Antes:", [
              "Refuerza puertas y ventanas.",
              "Prepara tu kit de emergencia.",
              "Guarda documentos en bolsas plásticas.",
              "Ten lista una ruta al refugio.",
            ]),

            seccion("Durante:", [
              "Permanece en una habitación interior.",
              "No salgas mientras el viento siga fuerte.",
              "Usa el radio o HuraSafe para informarte.",
              "Sigue instrucciones oficiales.",
            ]),

            seccion("Después:", [
              "No toques cables mojados.",
              "Evita beber agua sin hervir.",
              "Reporta daños a Protección Civil.",
            ]),
          ],
        ),
      ),
    );
  }

  Widget titulo(String txt) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
      txt,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget seccion(String titulo, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xfffcf6bd),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...items.map((e) => Text("• $e")),
          ],
        ),
      ),
    );
  }
}
