import 'package:flutter/material.dart';

class RecomendacionRoja extends StatelessWidget {
  const RecomendacionRoja({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ROJA"),
        centerTitle: true,
        backgroundColor: Color(0xffff8a8a),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            titulo("ROJA - Huracán categoría 4 o 5"),

            seccion("Antes:", [
              "Sigue instrucciones oficiales sin dudar.",
              "Evacúa si Protección Civil lo ordena.",
              "Cierra gas y desconecta aparatos.",
              "Resguarda objetos que puedan volarse.",
            ]),

            seccion("Durante:", [
              "Permanece en refugio o zona segura.",
              "No salgas bajo ninguna circunstancia.",
              "Mantén comunicación solo si es necesario.",
            ]),

            seccion("Después:", [
              "Espera aviso oficial antes de salir.",
              "No regreses a zonas inundadas.",
              "Revisa daños con mucho cuidado.",
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
          color: const Color(0xffffd4d4),
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
