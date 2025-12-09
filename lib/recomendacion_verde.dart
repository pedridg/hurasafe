import 'package:flutter/material.dart';

class RecomendacionVerde extends StatelessWidget {
  const RecomendacionVerde({super.key});

  @override
  Widget build(BuildContext context) {
    const verdeFuerte = Color(0xFF7ED957);
    const verdeSuave = Color(0xFFE8FBD9);

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
                      color: verdeFuerte,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VERDE',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Ciclón o tormenta tropical',
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
                colorFondo: verdeSuave,
                items: const [
                  'Mantente informado sobre el pronóstico y avisos de Protección Civil.',
                  'Guarda documentos importantes y ten a la mano una linterna, radio, agua y comida.',
                  'Asegura objetos que puedan volarse como macetas, láminas o cubetas.',
                  'Revisa tu casa: techo, puertas y ventanas.',
                  'Carga tu celular y prepara una mochila con lo necesario.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Durante:',
                colorFondo: verdeSuave,
                items: const [
                  'Permanece dentro de casa o en un refugio seguro.',
                  'Evita salir, manejar o cruzar zonas inundadas.',
                  'Desconecta aparatos eléctricos.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Después:',
                colorFondo: verdeSuave,
                items: const [
                  'Espera la indicación oficial para salir.',
                  'Limpia con precaución y revisa si hay daños leves.',
                  'Ayuda a tus vecinos si es seguro hacerlo.',
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