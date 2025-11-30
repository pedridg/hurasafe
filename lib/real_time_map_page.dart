// ============================================================================
// HURASAFE — MAPA DE HURACANES
// Versión Full Optimizada • flutter_map 7.x compatible • incluye OTIS Cat 5
// ============================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RealTimeMapPage extends StatefulWidget {
  const RealTimeMapPage({super.key});

  @override
  State<RealTimeMapPage> createState() => _RealTimeMapPageState();
}

class _RealTimeMapPageState extends State<RealTimeMapPage> {
  final MapController map = MapController();

  LatLng? userPos;
  String userAddress = "Cargando ubicación...";
  bool loading = true;
  String error = "";

  // Capas de huracanes
  List<Polyline> stormTracks = [];
  List<Polygon> windPolygons = [];
  List<Marker> stormMarkers = [];

  // Capas de meteorología
  bool showSat = true;
  bool showRain = true;
  bool showWind = true;
  bool showTemp = false;
  bool showPressure = false;

  bool showTracks = true;
  bool showMarkers = true;
  bool showWindRadii = true;

  final String owKey = "50f497c804cad52458d3385805be17f2";

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    setState(() {
      loading = true;
      error = "";
    });

    try {
      await requestLocation();
      await loadStormData();
    } catch (e) {
      error = "Error cargando datos: $e";
    }

    setState(() => loading = false);
  }

  // ==================================================================
  // UBICACIÓN
  // ==================================================================
  Future<void> requestLocation() async {
    LocationPermission perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      userAddress = "Permiso de ubicación denegado";
      return;
    }

    Position p = await Geolocator.getCurrentPosition();
    userPos = LatLng(p.latitude, p.longitude);

    map.move(userPos!, 7);
    userAddress = await reverseGeocode(p.latitude, p.longitude);
  }

  Future<String> reverseGeocode(double lat, double lon) async {
    try {
      final url =
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1";

      final r = await http.get(Uri.parse(url),
          headers: {"User-Agent": "HuraSafe-App/1.0"});

      if (r.statusCode != 200) return "Ubicación desconocida";

      final a = jsonDecode(r.body)["address"] ?? {};

      final city = a["city"] ?? a["town"] ?? a["village"] ?? "";
      final state = a["state"] ?? "";
      final country = a["country"] ?? "";

      return "$city, $state, $country";
    } catch (_) {
      return "Ubicación desconocida";
    }
  }

  // ==================================================================
  // FUNCIONES NUEVAS PARA COLORES DE HURACÁN
  // ==================================================================
  Color _stormColor(int kt) {
    if (kt < 34) return Colors.lightBlue;           // Depresión
    if (kt < 64) return Colors.green;               // Tormenta tropical
    if (kt < 83) return Colors.yellow.shade700;     // Cat 1
    if (kt < 96) return Colors.orange;              // Cat 2
    if (kt < 113) return Colors.deepOrange;         // Cat 3
    if (kt > 137) return const Color.fromARGB(255, 78, 4, 4);             // Cat 4
    return const Color.fromARGB(255, 78, 72, 71);                              // Cat 5
  }

  // ==================================================================
  // SIMULACIÓN API HURACANES + OTIS CAT 5
  // ==================================================================
  Future<String> getMockStormAPI() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return jsonEncode({
      "storms": [
        // -----------------------------------------------------------
        // 1. OTIS — Huracán Categoría 5
        // -----------------------------------------------------------
        {
          "name": "OTIS",
          "wind_kt": 150,
          "pressure": 923,
          "type": "HURRICANE",

          // ← AQUÍ PUEDES PONER TUS COORDENADAS
          "pos": {"lat": 14.5, "lon": -101.5},

          "track": [
            {"lat": 14.5, "lon": -101.5},
            {"lat": 15.4, "lon": -100.7},
            {"lat": 16.0, "lon": -100.2},
            {"lat": 16.5, "lon": -100.0},
            {"lat": 16.78, "lon": -99.85}
          ],

          "radii": [
            {"kt": 34, "nm": 90},
            {"kt": 64, "nm": 25},
            {"kt": 100, "nm": 12}
          ]
        },

        // -----------------------------------------------------------
        // 2. KOTO
        // -----------------------------------------------------------
        {
          "name": "KOTO",
          "wind_kt": 44,
          "pressure": 965,
          "type": "TROPICAL STORM",
          "pos": {"lat": 14.32, "lon": 111.63},
          "track": [
            {"lat": 14.30, "lon": 109.27},
            {"lat": 14.64, "lon": 110.33},
            {"lat": 14.48, "lon": 110.54},
            {"lat": 14.73, "lon": 111.01},
            {"lat": 14.32, "lon": 111.63},
          ],
          "radii": [
            {"kt": 34, "nm": 140},
            {"kt": 64, "nm": 45}
          ]
        },

        // -----------------------------------------------------------
        // 3. DITWAH
        // -----------------------------------------------------------
        {
          "name": "Ditwah",
          "wind_kt": 30,
          "pressure": 100,
          "type": "tropical depression",
          "pos": {"lat": 10.6, "lon": 81.37},
          "track": [
            {"lat": 11.51, "lon": 80.12},
            {"lat": 11.60, "lon": 80.85},
            {"lat": 12.2, "lon": 81.73},
            {"lat": 12.5, "lon": 81.09},
            {"lat": 12.0, "lon": 81.09},
            {"lat": 11.7, "lon": 81.41},
            {"lat": 10.6, "lon": 81.37},
          ],
          "radii": [
            {"kt": 34, "nm": 100}
          ]
        }
      ]
    });
  }

  // ==================================================================
  // PROCESAR HURACANES
  // ==================================================================
  Future<void> loadStormData() async {
    stormTracks.clear();
    windPolygons.clear();
    stormMarkers.clear();

    final raw = await getMockStormAPI();
    final data = jsonDecode(raw);

    final storms = data["storms"] ?? [];

    for (final s in storms) {
      processStorm(s);
    }
  }

  String classifyStorm(int kt) {
    if (kt >= 137) return "Huracán Categoría 5";
    if (kt >= 113) return "Huracán Categoría 4";
    if (kt >= 96) return "Huracán Categoría 3";
    if (kt >= 83) return "Huracán Categoría 2";
    if (kt >= 64) return "Huracán Categoría 1";
    if (kt >= 35) return "Tormenta Tropical";
    if (kt >= 1) return "Depresión Tropical";
    return "Disturbio";
  }

  void processStorm(Map s) {
    final name = s["name"] ?? "Storm";
    final int windKt = s["wind_kt"] ?? 0;
    final int pressure = s["pressure"] ?? 0;
    final String type = classifyStorm(windKt);

    final pos = s["pos"];
    final track = s["track"] ?? [];

    if (pos == null) return;

    LatLng center = LatLng(pos["lat"], pos["lon"]);

    // TRACK
    List<LatLng> points =
        track.map<LatLng>((p) => LatLng(p["lat"], p["lon"])).toList();

    if (points.length > 1) {
      stormTracks.add(
        Polyline(
          points: points,
          color: _stormColor(windKt),   // ← COLOR NUEVO
          strokeWidth: 4,
        ),
      );
    }

    // MARCADOR
    stormMarkers.add(
      Marker(
        point: center,
        width: 200,
        height: 110,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _stormColor(windKt),     // ← COLOR NUEVO
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    "$name — $type",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  Text(
                    "Viento: $windKt kt  |  Presión: $pressure hPa",
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
            Icon(Icons.location_on, color: _stormColor(windKt), size: 32),
          ],
        ),
      ),
    );

    // RADIOS DE VIENTO
    final c = _stormColor(windKt);

    for (final r in (s["radii"] ?? [])) {
      final nm = r["nm"];
      double deg = nm / 60;

      windPolygons.add(
        Polygon(
          points: generateCircle(center, deg),
          color: c.withOpacity(.22),   // ← COLOR NUEVO
          borderColor: c,              // ← COLOR NUEVO
          borderStrokeWidth: 1.4,
        ),
      );
    }
  }

  List<LatLng> generateCircle(LatLng c, double deg) {
    List<LatLng> pts = [];
    for (int i = 0; i < 360; i += 12) {
      pts.add(LatLng(
        c.latitude + deg * math.cos(i * math.pi / 180),
        c.longitude + deg * math.sin(i * math.pi / 180),
      ));
    }
    return pts;
  }

  // ==================================================================
  // INTERFAZ
  // ==================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HuraSafe — Mapa en tiempo real"),
        backgroundColor: Colors.blueGrey.shade800,
        actions: [
          IconButton(onPressed: initialize, icon: const Icon(Icons.refresh)),
          if (userPos != null)
            IconButton(
                onPressed: () => map.move(userPos!, 8),
                icon: const Icon(Icons.my_location))
        ],
      ),

      body: Stack(
        children: [
          FlutterMap(
            mapController: map,
            options: MapOptions(
              initialCenter: userPos ?? const LatLng(20, -85),
              initialZoom: 5,
              maxZoom: 18,
              minZoom: 2,
            ),
            children: [
              TileLayer(
                  urlTemplate:
                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: "hurasafe"),

              if (showSat)
                weatherLayer(
                    "https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/goes-e/{z}/{x}/{y}.png",
                    opacity: .35),

              if (showRain)
                weatherLayer(
                    "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=$owKey",
                    opacity: .55),

              if (showWind)
                weatherLayer(
                    "https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=$owKey",
                    opacity: .40),

              if (showTemp)
                weatherLayer(
                    "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=$owKey",
                    opacity: .70),

              if (showPressure)
                weatherLayer(
                    "https://tile.openweathermap.org/map/pressure_new/{z}/{x}/{y}.png?appid=$owKey",
                    opacity: .50),

              if (showWindRadii) PolygonLayer(polygons: windPolygons),
              if (showTracks) PolylineLayer(polylines: stormTracks),
              if (showMarkers) MarkerLayer(markers: stormMarkers),

              if (userPos != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userPos!,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 3)),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ],
                )
            ],
          ),

          if (loading || error.isNotEmpty)
            Container(
              color: Colors.black54,
              child: Center(
                child: Text(
                  loading ? "Cargando..." : error,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                userAddress,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 15,
            left: 10,
            right: 10,
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      layerToggle("Tracks", showTracks,
                          (v) => setState(() => showTracks = v)),
                      layerToggle("Tormentas", showMarkers,
                          (v) => setState(() => showMarkers = v)),
                      layerToggle("Radios", showWindRadii,
                          (v) => setState(() => showWindRadii = v)),

                      const VerticalDivider(),

                      layerToggle("Sat", showSat,
                          (v) => setState(() => showSat = v)),
                      layerToggle("Lluvia", showRain,
                          (v) => setState(() => showRain = v)),
                      layerToggle("Viento", showWind,
                          (v) => setState(() => showWind = v)),
                      layerToggle("Temp", showTemp,
                          (v) => setState(() => showTemp = v)),
                      layerToggle("Presión", showPressure,
                          (v) => setState(() => showPressure = v)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ==================================================================
  // REUTILIZABLES
  // ==================================================================
  Widget weatherLayer(String url, {required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: TileLayer(
        urlTemplate: url,
        userAgentPackageName: "hurasafe",
      ),
    );
  }

  Widget layerToggle(String label, bool value, Function(bool) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: value ? Colors.blue : Colors.grey)),
          Switch.adaptive(value: value, onChanged: onChange),
        ],
      ),
    );
  }
}
