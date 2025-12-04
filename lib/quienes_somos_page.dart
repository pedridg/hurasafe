import 'package:flutter/material.dart';

class QuienesSomosPage extends StatelessWidget {
  const QuienesSomosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 380,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // ===================== TITULO =====================
                  const Text(
                    "Quiénes somos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===================== TEXTO 1 =====================
                  const Text(
                    "HuraSafe es una aplicación creada por alumnos de Ingeniería en Sistemas Computacionales del Instituto TecNM, con el objetivo de informar, alertar y orientar a la población ante ciclones y huracanes.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ===================== TEXTO 2 =====================
                  const Text(
                    "El proyecto nació tras las tragedias ocasionadas por los huracanes Otis y John en Acapulco, con la intención de desarrollar una herramienta tecnológica que ayude a prevenir riesgos, reducir pérdidas y salvar vidas.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ===================== TEXTO 3 =====================
                  const Text(
                    "Buscamos fomentar la cultura de la prevención mediante información confiable, actualizada y accesible para todas las personas.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ===================== IMAGEN =====================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/images/john_acapulco.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ===================== FECHA =====================
                  const Text(
                    "John 23 de Septiembre, 2023.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ===================== MISION =====================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Misión:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Brindar orientación oportuna y recursos útiles para actuar con responsabilidad ante fenómenos naturales.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===================== VISION =====================
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Visión:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Ser una aplicación reconocida por su confiabilidad, accesibilidad y contribución a la seguridad ciudadana.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
