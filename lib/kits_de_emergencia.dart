import 'package:flutter/material.dart';

class kitsDeEmergencia extends StatefulWidget {
  const kitsDeEmergencia({super.key});
  @override
  _kitsDeEmergenciaState createState() => _kitsDeEmergenciaState();
}
class _kitsDeEmergenciaState extends State<kitsDeEmergencia> {
  List<Map<String, String>> emergencyKits = [
    {
      "Kit Básico": "Agua, alimentos no perecederos, linterna, radio, botiquín de primeros auxilios.",
    },
    {
      "Kit Avanzado": "Ropa extra, documentos importantes, dinero en efectivo, herramientas multiusos.",
    },
    {
      "Kit Familiar": "Artículos para bebés, medicamentos, artículos de higiene personal, mantas.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kits de Emergencia"),
      ),
      body: ListView.builder(
        itemCount: emergencyKits.length,
        itemBuilder: (context, index) {
          final item = emergencyKits[index];
          return ListTile(
            leading: const Icon(Icons.backpack),
            title: Text(item.keys.first),
            subtitle: Text(item.values.first),
          );
        },
      ),
    );
  }
}