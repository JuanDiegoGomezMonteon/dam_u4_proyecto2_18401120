

import 'package:flutter/material.dart';

import 'firebase_service.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {

  final TextEditingController docenteController = TextEditingController();
  final TextEditingController edificioController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController materiaController = TextEditingController();
  final TextEditingController salonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};

    if (arguments.isNotEmpty) {
      docenteController.text = arguments['docente'] ?? '';
      edificioController.text = arguments['edificio'] ?? '';
      horarioController.text = arguments['horario'] ?? '';
      materiaController.text = arguments['materia'] ?? '';
      salonController.text = arguments['salon'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Actualizar Asignacion"),),
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
              await actualizarAsignacion(arguments['uid'], docenteController.text,edificioController.text,
                horarioController.text,materiaController.text,salonController.text,).then((_) {
                Navigator.pop(context);
              });
            }, child: Text("ACTUALIZAR"))
          ],
        ),
      ),
    );
  }
}
