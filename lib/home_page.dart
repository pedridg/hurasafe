import 'package:flutter/material.dart';
import 'real_time_map_page.dart';   // <<<<<< AGREGA ESTE IMPORT
import 'alerts_page.dart';
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

              Row(
                children: [
                  Image.asset("assets/images/logo.png", width: 45),
                  const SizedBox(width: 8),
                  const Text(
                    "HuraSafe",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Center(
                child: Column(
                  children: [
                    Text(
                      "¡Bienvenido a HuraSafe!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "¿Qué deseas ver hoy?",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // NAVEGACIÓN AL MAPA EN TIEMPO REAL
              menuItem(
                iconPath: "assets/icons/map.jpg",
                label: "Mapa en tiempo real",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RealTimeMapPage(),
                    ),
                  );
                },
              ),

              menuItem(
                iconPath: "assets/icons/alerta.jpg",
                label: "Alertas actuales",
                onTap: () {
                      Navigator.push(
                        context,
                    MaterialPageRoute(builder: (context) => const AlertsPage()),
                   );
                },
              ),

              menuItem(
                iconPath: "assets/icons/recomendaciones.jpg",
                label: "Recomendaciones",
                onTap: () {},
              ),

              menuItem(
                iconPath: "assets/icons/kit.jpg",
                label: "Kit de emergencia",
                onTap: () {},
              ),

              menuItem(
                iconPath: "assets/icons/ayuda.jpg",
                label: "Números de ayuda",
                onTap: () {},
              ),

              menuItem(
                iconPath: "assets/icons/quienes.jpg",
                label: "Quiénes somos",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Image.asset(iconPath, width: 38, height: 38),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xffcfc6ff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
