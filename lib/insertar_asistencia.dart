
import 'package:dam_u4_proyecto2_18401120/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InsertarAsistencia extends StatefulWidget {

  final String AsignacionId;

  const InsertarAsistencia({Key? key, required this.AsignacionId}) : super(key: key);

  @override
  State<InsertarAsistencia> createState() => _InsertarAsistenciaState();
}

class _InsertarAsistenciaState extends State<InsertarAsistencia> {

  TextEditingController fechahoraController = TextEditingController(text: "");
  TextEditingController revisorController = TextEditingController(text: "");

  DateTime SelectedFecha = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insertar Asistencia",)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Revisor",icon: Icon(Icons.check)),
              controller: revisorController,
            ),
            TextButton(
                onPressed: () async{
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: SelectedFecha, 
                      firstDate: DateTime(2015,8), 
                      lastDate: DateTime(2101)
                  );
                  if(picked != null && picked != SelectedFecha)
                    setState(() {
                      SelectedFecha = picked;
                    });
                }, 
                child: Text("Seleccionar Fecha: ${DateFormat.yMd().format(SelectedFecha)}")
            ),
            ElevatedButton(onPressed: () async{
              await insertarAsistencia(widget.AsignacionId, {
                "revisor": revisorController.text,
                "fechahora": SelectedFecha
              }).then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("INSERTAR"))
          ],
        ),
      ),
    );
  }
}
