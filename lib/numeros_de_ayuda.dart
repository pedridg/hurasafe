import 'package:flutter/material.dart';

class NumerosDeAyuda extends StatefulWidget {
  const NumerosDeAyuda({super.key});
  @override
  _NumerosDeAyudaState createState() => _NumerosDeAyudaState();
}
class _NumerosDeAyudaState extends State<NumerosDeAyuda> {
  List<Map<String, String>> helpNumbers = [
    {
      "Servicio": "Emergencias",
      "Número": "911",
    },
    {
      "Servicio": "Locatel",
      "Número": "56581111",
    },
    {
      "Servicio": "Proteccion Civil",
      "Número": "56832222",
    },
    {
      "Servicio": "Cruz Roja",
      "Número": "065",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Números de Ayuda"),
      ),
      body: ListView.builder(
        itemCount: helpNumbers.length,
        itemBuilder: (context, index) {
          final item = helpNumbers[index];
          return ListTile(
            leading: const Icon(Icons.phone),
            title: Text(item["Servicio"]!),
            subtitle: Text(item["Número"]!),
            subtitleTextStyle: const TextStyle(
              color: Colors.blue,
            ),
            onTap: () {
              // Aquí podrías agregar funcionalidad para llamar al número
            },
          );
        },
      ),
    );
  }
}