import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RealTimeMapPage extends StatefulWidget {
  const RealTimeMapPage({super.key});

  @override
  _RealTimeMapPageState createState() => _RealTimeMapPageState();
}

class _RealTimeMapPageState extends State<RealTimeMapPage> {
  LatLng? userLocation;
  String userAddress = "Cargando ubicación...";
  List<Marker> hurricaneMarkers = [];
  List<Polyline> hurricaneRoutes = [];

  @override
  void initState() {
    super.initState();
    getLocation();
    loadHurricaneData();
  }

  // OBTENER UBICACIÓN DEL USUARIO
  Future<void> getLocation() async {
    LocationPermission perm = await Geolocator.requestPermission();

    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      setState(() {
        userAddress = "Permiso denegado";
      });
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(pos.latitude, pos.longitude);
      userAddress = "Lat: ${pos.latitude.toStringAsFixed(4)}, "
          "Lng: ${pos.longitude.toStringAsFixed(4)}";
    });
  }

  // CARGAR DATOS DE HURACANES NOAA
  Future<void> loadHurricaneData() async {
    final url =
        Uri.parse("https://www.nhc.noaa.gov/CurrentStorms.json");

    final res = await http.get(url);
    if (res.statusCode != 200) return;

    final data = json.decode(res.body);

    List<Marker> markers = [];
    List<Polyline> routes = [];

    for (var storm in data["activeStorms"]) {
      // posición actual del huracán
      double lat = storm["lat"];
      double lon = storm["lon"];

      markers.add(
        Marker(
          point: LatLng(lat, lon),
          width: 40,
          height: 40,
          child: const Icon(
            Icons.cyclone,
            color: Colors.red,
            size: 36,
          ),
        ),
      );

      // trayectoria (historial de puntos)
      List<LatLng> points = [];

      for (var track in storm["track"]) {
        points.add(
          LatLng(track["lat"], track["lon"]),
        );
      }

      routes.add(
        Polyline(
          points: points,
          color: Colors.red,
          strokeWidth: 4,
        ),
      );
    }

    setState(() {
      hurricaneMarkers = markers;
      hurricaneRoutes = routes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: userLocation!,
                    initialZoom: 5,
                    maxZoom: 18,
                    minZoom: 2,
                  ),
                  children: [
                    // 🌍 MAPA MUNDIAL SATELITAL (GOES)
                    TileLayer(
                      urlTemplate:
                          "https://api.maptiler.com/tiles/satellite-v2/{z}/{x}/{y}.jpg?key=TU_KEY",
                      userAgentPackageName: 'com.example.hurasafe',
                    ),

                    // 🌀 RUTAS DE HURACANES
                    PolylineLayer(polylines: hurricaneRoutes),

                    // 🌀 MARCADORES DE HURACANES
                    MarkerLayer(markers: hurricaneMarkers),

                    // 📍 TU UBICACIÓN
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: userLocation!,
                          width: 20,
                          height: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // TEXTO ABAJO
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Tu ubicación actual es:\n$userAddress",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
