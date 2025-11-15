import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hurasafe/home_page.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {

  // Función que solicita permisos y navega a HomePage
  Future<void> requestLocation() async {
    // --- WEB ---
    if (kIsWeb) {
      try {
        Position pos = await Geolocator.getCurrentPosition();
        print("WEB POS: ${pos.latitude}, ${pos.longitude}");
      } catch (e) {
        print("Error obteniendo posición en Web: $e");
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      return;
    }

    // --- ANDROID / iOS ---
    PermissionStatus status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      try {
        Position pos = await Geolocator.getCurrentPosition();
        print("LAT: ${pos.latitude}, LNG: ${pos.longitude}");
      } catch (e) {
        print("Error obteniendo posición: $e");
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (status.isPermanentlyDenied) {
      // Si el usuario negó permanentemente, abrir ajustes
      openAppSettings();
    } else {
      // Negado temporalmente, mostrar mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Necesitamos permiso de ubicación para continuar"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // LOGO GRANDE
              Image.asset(
                "assets/images/logo.png",
                width: 350,
                height: 350,
              ),

              const SizedBox(height: 0),

              const Text(
                "HuraSafe necesita acceder a tu ubicación\n"
                "para mostrarte alertas y mapas en\n"
                "tiempo real sobre huracanes cercanos.\n"
                "Tu información se usará solo para\n"
                "brindarte avisos precisos y mantener tu\n"
                "seguridad.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 25),

              GestureDetector(
                onTap: requestLocation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "PERMITIR UBICACION",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
