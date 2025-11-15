import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // logo arriba
              Row(
                children: [
                  Image.asset("assets/images/logo.png", width: 45),
                  const SizedBox(width: 8),
                  const Text(
                    "HuraSafe",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Center(
                child: Column(
                  children: [
                    Text(
                      "¡Bienvenido a HuraSafe!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "¿Qué deseas ver hoy?",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              menuItem("assets/icons/map.jpg", "Mapa en tiempo real"),
              menuItem("assets/icons/alerta.jpg", "Alertas actuales"),
              menuItem("assets/icons/recomendaciones.jpg", "Recomendaciones"),
              menuItem("assets/icons/kit.jpg", "Kit de emergencia"),
              menuItem("assets/icons/ayuda.jpg", "Números de ayuda"),
              menuItem("assets/icons/quienes.jpg", "Quiénes somos"),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String iconPath, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Image.asset(iconPath, width: 34, height: 34),   //  <<<<<< icono PNG TUYO
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffcfc6ff),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
