import 'package:flutter/material.dart';

class RecomendacionAmarilla extends StatelessWidget {
  const RecomendacionAmarilla({super.key});

  @override
  Widget build(BuildContext context) {
    const amarilloFuerte = Color(0xFFF7E86B);
    const amarilloSuave = Color(0xFFFCF6BD);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: amarilloFuerte,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AMARILLA',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Huracán categoría 1 a 3',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              _seccionConCuadro(
                titulo: 'Antes:',
                colorFondo: amarilloSuave,
                items: const [
                  'Refuerza puertas, ventanas y techo.',
                  'Prepara tu kit de emergencia con alimentos, agua y medicinas.',
                  'Guarda documentos y objetos importantes en bolsas plásticas.',
                  'Ten lista una ruta hacia el refugio más cercano.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Durante:',
                colorFondo: amarilloSuave,
                items: const [
                  'Permanece en una habitación interior sin ventanas.',
                  'No salgas aunque el viento se calme.',
                  'Usa radio o HuraSafe para mantenerte informado.',
                  'Mantén la calma y sigue las instrucciones de las autoridades.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Después:',
                colorFondo: amarilloSuave,
                items: const [
                  'No toques cables caídos ni objetos mojados con electricidad.',
                  'Revisa si hay fugas de gas antes de reconectar la luz.',
                  'Evita beber agua sin hervir o potabilizar.',
                  'Reporta daños a Protección Civil.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _seccionConCuadro({
    required String titulo,
    required List<String> items,
    required Color colorFondo,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (txt) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      txt,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}