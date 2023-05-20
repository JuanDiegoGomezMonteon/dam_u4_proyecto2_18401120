

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebase_service.dart';
import 'insertar_asistencia.dart';

class PaginaAsistencia extends StatefulWidget {

  final String AsignacionId;

  const PaginaAsistencia({Key? key, required this.AsignacionId}) : super(key: key);

  @override
  State<PaginaAsistencia> createState() => _PaginaAsistenciaState();
}

class _PaginaAsistenciaState extends State<PaginaAsistencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias"),),
      body: FutureBuilder<List>(
        future: getAsistencias(widget.AsignacionId),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index){
                final asistenciaData = snapshot.data?[index];
                return ListTile(
                  title: Text(
                      (asistenciaData?['fechahora'] as Timestamp)?.toDate().toString() ?? 'No disponible',
                  ),
                  subtitle: Text(asistenciaData?['revisor'] ?? 'Revisor no disponible'),
                );
              },
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text("Error al cargas las asistencias"),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => InsertarAsistencia(AsignacionId: widget.AsignacionId),
          ),
          );
          setState(() {});
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
