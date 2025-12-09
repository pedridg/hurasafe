import 'package:flutter/material.dart';
    
class kitsDeEmergencia extends StatefulWidget {
  const kitsDeEmergencia({super.key});
  @override
  State<kitsDeEmergencia> createState() => _kitsDeEmergenciaState();
}
class _kitsDeEmergenciaState extends State<kitsDeEmergencia> {
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kits de Emergencia"),
      ),
      body: SingleChildScrollView(
        /*child: Padding(*/
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.backpack, size: 55,color: Colors.grey,),
                  SizedBox(width: 20),
                  Text(
                    "Kit Basico",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              //Mustra la lista correspondiente
              listas([
                "Agua (aprox. 3.8 litros) por persona",
                "Alimentos no perecederos (atún, sardinas, galletas, etc.)",
                "Fósforos o encendedor",
                "Botiquin de primeros auxilios (vendas, gasas, analgésicos, desinfectante)",
                "Linterna con pilas de repuesto",
                "Artículos de higiene personal (gel de manos, papel higiénico)",
              ]),
              SizedBox(height: 40,),

              //Mensaje de kit avanzada
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.backpack,size: 55,color: Colors.grey,),
                  SizedBox(width: 20),
                  Text(
                    "Kit Avanzado",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              //lista de cosas
              listas([
                "Agua (aprox. 3.8 litros) por persona",
                "Alimentos no perecederos (atún, sardinas, galletas, etc.)",
                "Fósforos o encendedor",
                "Botiquin de primeros auxilios (vendas, gasas, analgésicos, desinfectante)",
                "Linterna con pilas de repuesto",
                "Artículos de higiene personal (gel de manos, papel higiénico)",
                "Baterías externas (power banks) para cargar teléfonos móviles y otros dispositivos",
                "Ropa abrigadora adicional, mantas extra o sacos de dormir.",
                "Multiherramienta o navaja, cinta adhesiva resistente y cuerdas",
              ]),
              SizedBox(height: 40,),

              //Mensaje de Kit Familiar
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.backpack,size: 55,color: Colors.grey,),
                  SizedBox(width: 20),
                  Text(
                    "Kit Familiar",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              //mensaje de listas
              listas([
                "Agua (aprox. 3.8 litros) por persona",
                "Alimentos no perecederos (atún, sardinas, galletas, etc.)",
                "Fósforos o encendedor",
                "Botiquin de primeros auxilios (vendas, gasas, analgésicos, desinfectante)",
                "Linterna con pilas de repuesto",
                "Artículos de higiene personal (gel de manos, papel higiénico)",
                "Baterías externas (power banks) para cargar teléfonos móviles y otros dispositivos",
                "Ropa abrigadora adicional, mantas extra o sacos de dormir.",
                "Multiherramienta o navaja, cinta adhesiva resistente y cuerdas",
                "suministros médicos especiales (gafas de seguridad, mascarillas si es necesario)",
                "Artículos para hacer la vida más fácil durante el suceso, como libros o juegos de mesa"
              ]),
            ],
          ),
        /*),*/
      ),
    );
  }

  Widget listas( List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 10),
          )]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...items.map((e) => Text("*$e",style: TextStyle(fontSize: 17),textAlign: TextAlign.justify),),
          ],
        ),
      ),
    );
  }
}