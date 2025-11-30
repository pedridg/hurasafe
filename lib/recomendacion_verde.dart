import 'package:flutter/material.dart';

class RecomendacionVerde extends StatelessWidget {
  const RecomendacionVerde({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VERDE"),
        centerTitle: true,
        backgroundColor: const Color(0xff87e38a),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            titulo("VERDE - Ciclón o tormenta tropical"),

            seccion("Antes:", [
              "Mantente informado sobre el pronóstico y avisos oficiales.",
              "Guarda documentos importantes, agua y comida.",
              "Asegura objetos que puedan volarse.",
              "Revisa techo, puertas y ventanas.",
              "Carga tu celular y prepara una mochila.",
            ]),

            seccion("Durante:", [
              "Permanece dentro de casa o refugio seguro.",
              "Evita manejar o cruzar zonas inundadas.",
              "Desconecta aparatos eléctricos.",
            ]),

            seccion("Después:", [
              "Espera indicación oficial para salir.",
              "Revisa daños y ayuda a tus vecinos si es seguro.",
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
          color: const Color(0xffd4f7d8),
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
