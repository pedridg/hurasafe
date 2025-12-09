import 'package:flutter/material.dart';

class RecomendacionRoja extends StatelessWidget {
  const RecomendacionRoja({super.key});

  @override
  Widget build(BuildContext context) {
    const rojoFuerte = Color(0xFFFF8A8A);
    const rojoSuave = Color(0xFFFFD4D4);

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
                      color: rojoFuerte,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ROJA',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Huracán categoría 4 o 5',
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
                colorFondo: rojoSuave,
                items: const [
                  'Evacúa si las autoridades lo indican.',
                  'Lleva tu kit de emergencia, documentos y ropa ligera.',
                  'Cierra gas, agua y electricidad antes de salir.',
                  'Mantén comunicación con familiares o vecinos.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Durante:',
                colorFondo: rojoSuave,
                items: const [
                  'Si no lograste evacuar, refúgiate en una zona baja y segura dentro de tu vivienda.',
                  'Aléjate completamente de puertas y ventanas.',
                  'No salgas bajo ninguna circunstancia, aunque parezca que el huracán disminuyó.',
                ],
              ),
              const SizedBox(height: 16),
              _seccionConCuadro(
                titulo: 'Después:',
                colorFondo: rojoSuave,
                items: const [
                  'Espera la autorización oficial antes de regresar a casa.',
                  'Evita transitar por calles con agua o escombros.',
                  'No consumas alimentos o agua contaminados.',
                  'Informa a las autoridades si hay personas heridas o desaparecidas.',
                  'Mantente alerta a nuevas tormentas o réplicas de lluvia.',
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