// lib/real_time_map_page.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RealTimeMapPage extends StatefulWidget {
  const RealTimeMapPage({super.key});

  @override
  State<RealTimeMapPage> createState() => _RealTimeMapPageState();
}

class _RealTimeMapPageState extends State<RealTimeMapPage> {
  final MapController _mapController = MapController();

  LatLng? userLocation;
  String userAddress = 'Cargando ubicación...';
  bool loading = true;

  List<Polyline> hurricaneTracks = [];
  List<Marker> stormMarkers = [];

  // SOLO OpenWeatherMap
  final String _openWeatherApiKey = '50f497c804cad52458d3385805be17f2';

  bool showSatellite = true;
  bool showPrecip = true;
  bool showWind = true;
  bool showTemp = true;
  bool showPressure = false;
  bool showNOAAtracks = true;
  bool showStormMarkers = true;

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  Future<void> _initAll() async {
    await _ensureLocation();
    await Future.wait([
      loadHurricaneTracks(),
      loadStorms(),
    ]);
    setState(() {
      loading = false;
    });
  }

  // ------------------------------------------------------------------------
  // UBICACIÓN
  // ------------------------------------------------------------------------
  Future<void> _ensureLocation() async {
    try {
      LocationPermission perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        setState(() {
          userAddress = 'Permiso de ubicación denegado';
          loading = false;
        });
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      userLocation = LatLng(pos.latitude, pos.longitude);

      await Future.delayed(const Duration(milliseconds: 250));
      _mapController.move(userLocation!, 6);

      userAddress =
          await _getAddressFromCoordinates(pos.latitude, pos.longitude);

      setState(() {});
    } catch (e) {
      userAddress = "Error obteniendo la ubicación";
      setState(() {});
    }
  }

  Future<String> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      final url =
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1&accept-language=es";

      final r = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'HuraSafe/1.0 (contact@example.com)'
      });

      if (r.statusCode != 200) return "Dirección no disponible";

      final data = jsonDecode(r.body);
      final addr = data["address"] ?? {};

      final city = addr["city"] ??
          addr["town"] ??
          addr["village"] ??
          addr["municipality"] ??
          "";
      final state = addr["state"] ?? "";
      final country = addr["country"] ?? "";
      final cp = addr["postcode"] ?? "";

      final txt = [city, state, country].where((e) => e != "").join(", ");
      return txt.isEmpty ? "Ubicación (CP: $cp)" : "$txt (CP: $cp)";
    } catch (_) {
      return "Dirección no disponible";
    }
  }

  // ------------------------------------------------------------------------
  // NOAA HURACANES — TRACKS
  // ------------------------------------------------------------------------
  Future<void> loadHurricaneTracks() async {
    hurricaneTracks = [];

    final urls = [
      'https://www.nhc.noaa.gov/gis/forecast/atcf/latest/aal_latest_best_track.geojson',
      'https://www.nhc.noaa.gov/refresh/graphics_at1_latest/AL_tracks_latest.geojson',
    ];

    for (final url in urls) {
      try {
        final r = await http.get(Uri.parse(url));
        if (r.statusCode != 200) continue;

        final data = jsonDecode(r.body);
        final features = data["features"] as List<dynamic>? ?? [];

        for (final f in features) {
          final geom = f["geometry"];
          if (geom == null) continue;

          if (geom["type"] == "LineString") {
            final coords = (geom["coordinates"] as List)
                .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
                .toList();

            hurricaneTracks.add(
              Polyline(
                points: coords,
                strokeWidth: 3,
                color: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        debugPrint("NOAA track error: $e");
      }
    }

    setState(() {});
  }

  // ------------------------------------------------------------------------
  // NOAA TORMENTAS — MARKERS
  // ------------------------------------------------------------------------
  Future<void> loadStorms() async {
    stormMarkers = [];

    final urls = [
      'https://www.nhc.noaa.gov/gis/forecast/atcf/latest/active_storms.geojson',
      'https://www.nhc.noaa.gov/refresh/graphics_at1_latest/storm_locations.geojson',
    ];

    for (final url in urls) {
      try {
        final r = await http.get(Uri.parse(url));
        if (r.statusCode != 200) continue;

        final data = jsonDecode(r.body);
        final features = data["features"] as List<dynamic>? ?? [];

        for (final f in features) {
          final geom = f["geometry"];
          if (geom == null || geom["type"] != "Point") continue;

          final coords = geom["coordinates"];

          final name =
              f["properties"]?["name"] ?? f["properties"]?["stormName"] ?? "Tormenta";

          stormMarkers.add(
            Marker(
              point: LatLng(coords[1].toDouble(), coords[0].toDouble()),
              width: 130,
              height: 55,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.location_on, color: Colors.red, size: 28),
                ],
              ),
            ),
          );
        }
      } catch (e) {
        debugPrint("NOAA storm error: $e");
      }
    }

    setState(() {});
  }

  // ------------------------------------------------------------------------
  // UI MAPA + LAYERS
  // ------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HuraSafe — Mapa en tiempo real"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              setState(() => loading = true);
              await loadHurricaneTracks();
              await loadStorms();
              setState(() => loading = false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              if (userLocation != null) {
                _mapController.move(userLocation!, 8);
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: userLocation ?? LatLng(16.8380, -99.8159),
              initialZoom: 5,
              maxZoom: 18,
              minZoom: 2,
            ),
            children: [
              // MAPA BASE
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "com.example.hurasafe",
              ),

              // SATÉLITE
              if (showSatellite)
                Opacity(
                  opacity: 0.35,
                  child: TileLayer(
                    urlTemplate:
                        "https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/goes-e/{z}/{x}/{y}.png",
                  ),
                ),

              // LLUVIA
              if (showPrecip)
                Opacity(
                  opacity: 0.55,
                  child: TileLayer(
                    urlTemplate:
                        "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=$_openWeatherApiKey",
                  ),
                ),

              // VIENTO
              if (showWind)
                Opacity(
                  opacity: 0.50,
                  child: TileLayer(
                    urlTemplate:
                        "https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=$_openWeatherApiKey",
                  ),
                ),

              // TEMPERATURA — CORREGIDO (OpenWeatherMap)
              if (showTemp)
                Opacity(
                  opacity: 0.75,
                  child: TileLayer(
                    urlTemplate:
                        "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=$_openWeatherApiKey",
                  ),
                ),

              // PRESIÓN
              if (showPressure)
                Opacity(
                  opacity: 0.50,
                  child: TileLayer(
                    urlTemplate:
                        "https://tile.openweathermap.org/map/pressure/{z}/{x}/{y}.png?appid=$_openWeatherApiKey",
                  ),
                ),

              // TRACKS
              if (showNOAAtracks)
                PolylineLayer(polylines: hurricaneTracks),

              // TORMENTAS
              if (showStormMarkers)
                MarkerLayer(markers: stormMarkers),

              // USUARIO
              if (userLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation!,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    )
                  ],
                )
            ],
          ),

          // DIRECCIÓN
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                userAddress,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // TOGGLES
          Positioned(
            bottom: 15,
            left: 10,
            right: 10,
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _toggle("Sat", showSatellite,
                          (v) => setState(() => showSatellite = v)),
                      _toggle("Lluvia", showPrecip,
                          (v) => setState(() => showPrecip = v)),
                      _toggle("Viento", showWind,
                          (v) => setState(() => showWind = v)),
                      _toggle("Temp", showTemp,
                          (v) => setState(() => showTemp = v)),
                      _toggle("Presión", showPressure,
                          (v) => setState(() => showPressure = v)),
                      _toggle("Tracks", showNOAAtracks,
                          (v) => setState(() => showNOAAtracks = v)),
                      _toggle("Tormentas", showStormMarkers,
                          (v) => setState(() => showStormMarkers = v)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggle(String label, bool value, ValueChanged<bool> f) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Switch(value: value, onChanged: f),
        const SizedBox(width: 8),
      ],
    );
  }
}
