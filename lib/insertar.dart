

import 'package:flutter/material.dart';

import 'firebase_service.dart';

class Insertar extends StatefulWidget {
  const Insertar({Key? key}) : super(key: key);

  @override
  State<Insertar> createState() => _InsertarState();
}

class _InsertarState extends State<Insertar> {

  final TextEditingController docenteController = TextEditingController();
  final TextEditingController edificioController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController materiaController = TextEditingController();
  final TextEditingController salonController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Insertar Vehículo"),),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Docente"), controller: docenteController, autofocus: true,),
            TextField(decoration: InputDecoration(labelText: "Edificio"), controller: edificioController,),
            TextField(decoration: InputDecoration(labelText: "Horario"), controller: horarioController,),
            TextField(decoration: InputDecoration(labelText: "Materia"), controller: materiaController,),
            TextField(decoration: InputDecoration(labelText: "Salon"), controller: salonController,),

            ElevatedButton(onPressed: () async{
              await insertarAsignacion(docenteController.text,edificioController.text,
                  horarioController.text,materiaController.text,salonController.text,).then((_) {
                Navigator.pop(context);
              });
            }, child: Text("GUARDAR"))
          ],
        ),
      ),
    );
  }
}

