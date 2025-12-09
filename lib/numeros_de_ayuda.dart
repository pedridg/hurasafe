import 'package:flutter/material.dart';


class NumerosDeAyuda extends StatefulWidget {
  const NumerosDeAyuda({super.key});
  @override
  _NumerosDeAyudaState createState() => _NumerosDeAyudaState();
}
class _NumerosDeAyudaState extends State<NumerosDeAyuda> {
  final List<Map<String, String>> numerosEmergencia = [
  {
    "estado": "Ciudad de México",
    "emergencia": "911",
    "proteccionCivil": "5683 2222",
    "cruzRoja": "5557 5757"
  },
  {
    "estado": "Jalisco",
    "emergencia": "911",
    "proteccionCivil": "3636 7506",
    "cruzRoja": "3336 5655"
  },
  {
    "estado": "Guerrero",
    "emergencia": "911",
    "proteccionCivil": "7444 8461",
    "cruzRoja": "7444 8505"
  },
  {
    "estado": "Nuevo León",
    "emergencia": "911",
    "proteccionCivil": "8120 3030",
    "cruzRoja": "8183 2020"
  }
];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Números de Emergencia")),
      body: ListView.builder(
        itemCount: numerosEmergencia.length,
        itemBuilder: (context, index) {
          final item = numerosEmergencia[index];
          return Card(
            child: ListTile(
              title: Text(item["estado"] ?? "",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              leading: Icon(Icons.phone),
              subtitle: Text(
                "Emergencia: ${item["emergencia"]}\n"
                "Protección Civil: ${item["proteccionCivil"]}\n"
                "Cruz Roja: ${item["cruzRoja"]}",
              ),
              subtitleTextStyle: const TextStyle(
                height: 1.6,
                fontSize:15,
                color: Colors.black,
              ),
              onTap: () {
                //funcion para llamar
              },
            ),
          );
        },
      ),
    );
  }
}