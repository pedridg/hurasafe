import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class RealTimeMapPage extends StatefulWidget {
  const RealTimeMapPage({super.key});

  @override
  _RealTimeMapPageState createState() => _RealTimeMapPageState();
}

class _RealTimeMapPageState extends State<RealTimeMapPage> {
  LatLng? userLocation;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    LocationPermission perm = await Geolocator.requestPermission();

    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

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

                // 🌎 OpenStreetMap base
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),

                // 🛰️ Satélite GOES con opacidad
                TileLayer(
                  urlTemplate:
                      "https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/goes-e/{z}/{x}/{y}.png",
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

                // 🌪️ Capa NOAA (huracanes)
                TileLayer(
                  urlTemplate:
                      "https://nowcoast.noaa.gov/tiles/analysis/firewx.fcst.ptype/{z}/{x}/{y}.png",
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

                // 📍 marcador usuario
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation!,
                      width: 30,
                      height: 30,
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
