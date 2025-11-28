import 'package:flutter/material.dart';

class kitsDeEmergencia extends StatefulWidget {
  const kitsDeEmergencia({super.key});
  @override
  _kitsDeEmergenciaState createState() => _kitsDeEmergenciaState();
}
class _kitsDeEmergenciaState extends State<kitsDeEmergencia> {
  List<Map<String, String>> emergencyKits = [
    {
      "Kit Basico":"Agua, alimentos no perecederos, linterna, radio, botiquín de primeros auxilios.",
    },
    {
      "Kit Avanzado": "Ropa extra, documentos importantes, dinero en efectivo, herramientas multiusos.",
    },
    {
      "Kit Familiar": "Artículos para bebés, medicamentos, artículos de higiene personal, mantas.",
    },
  ];
  
  Null get data => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kits de Emergencia"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: emergencyKits.length,
        itemBuilder: (context, index) {
          final item = emergencyKits[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.backpack,
                  size: 70,
                  color: Colors.green,
                ),
                const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize:MainAxisSize.max,
                  children: [
                    Text(
                      item.keys.first,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                /*Text(
                  item.keys.first,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),*/
                const SizedBox(height: 8),
                Text(
                  item.values.first,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  /*@override
  Widget menuItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: const Icon(Icons.backpack),
      title: Text(data["Servicio"]!),
      onTap: onTap,
    );
  }*/
}