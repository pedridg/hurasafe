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
  List<Polyline> hurricaneTracks = [];

  @override
  void initState() {
    super.initState();
    getLocation();
    loadHurricaneData();
  }

  // ----------------- UBICACIÓN -----------------
  Future<void> getLocation() async {
    LocationPermission perm = await Geolocator.requestPermission();

    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      userLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  // ----------------- HURACANES NOAA -----------------
  Future<void> loadHurricaneData() async {
    try {
      final url = Uri.parse(
          "https://www.nhc.noaa.gov/refresh/graphics_at1_latest/AL_tracks_latest.geojson");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List features = data["features"];

        List<Polyline> tracks = [];

        for (var f in features) {
          if (f["geometry"]["type"] == "LineString") {
            List points = f["geometry"]["coordinates"];

            tracks.add(
              Polyline(
                points: points.map((p) => LatLng(p[1], p[0])).toList(),
                strokeWidth: 3,
                color: Colors.red,
              ),
            );
          }
        }

        setState(() {
          hurricaneTracks = tracks;
        });
      }
    } catch (e) {
      print("Error cargando huracanes: $e");
    }
  }

  // ----------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: userLocation!,
                initialZoom: 5,
                maxZoom: 18,
                minZoom: 2,
              ),
              children: [
                // 🌎 BASE MAPA
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),

                // 🛰️ SATÉLITE IR – GOES
                TileLayer(
                  urlTemplate:
                      "https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/goes-ir/{z}/{x}/{y}.png",
                  tileBuilder: (context, child, tile) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4),
                        BlendMode.modulate,
                      ),
                      child: child,
                    );
                  },
                ),

                // 🌧️ LLUVIA (Precipitación global NOAA)
                TileLayer(
                  urlTemplate:
                      "https://tiles.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=b6907d289e10d714a6e88b30761fae22",
                  tileBuilder: (context, child, tile) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.6),
                        BlendMode.modulate,
                      ),
                      child: child,
                    );
                  },
                ),

                // ⚡ TORMENTAS ELÉCTRICAS (NOAA lightning)
                TileLayer(
                  urlTemplate:
                      "https://nowcoast.noaa.gov/tiles/observations/lightning strikes/{z}/{x}/{y}.png",
                  tileBuilder: (context, child, tile) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.7),
                        BlendMode.modulate,
                      ),
                      child: child,
                    );
                  },
                ),

                // 💨 VIENTO (Wind speed OpenWeather)
                TileLayer(
                  urlTemplate:
                      "https://tiles.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=b6907d289e10d714a6e88b30761fae22",
                  tileBuilder: (context, child, tile) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4),
                        BlendMode.modulate,
                      ),
                      child: child,
                    );
                  },
                ),

                // 🌡️ TEMPERATURA GLOBAL
                TileLayer(
                  urlTemplate:
                      "https://tiles.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=b6907d289e10d714a6e88b30761fae22",
                  tileBuilder: (context, child, tile) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4),
                        BlendMode.modulate,
                      ),
                      child: child,
                    );
                  },
                ),

                // 🌪️ HURACANES – TRAYECTORIAS (NOAA)
                PolylineLayer(
                  polylines: hurricaneTracks,
                ),

                // 📍 UBICACIÓN DEL USUARIO
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation!,
                      width: 35,
                      height: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
