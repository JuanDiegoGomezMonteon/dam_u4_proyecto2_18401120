import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAsignacion() async{
  List asignacion = [];

  QuerySnapshot queryAsignacion = await db.collection('asignacion').get();
  for(var doc in queryAsignacion.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asig = {
      "docente": data['docente'],
      "edificio":data['edificio'],
      "horario":data['horario'],
      "materia":data['materia'],
      "salon":data['salon'],
      "uid":doc.id,
    };
    asignacion.add(asig);
  }
  await Future.delayed(const Duration(seconds: 1));
  return asignacion;
}

Future<void> insertarAsignacion(String docente,String edificio, horario, materia, salon) async{
  await db.collection("asignacion").add({
    "docente": docente,
    "edificio": edificio,
    "horario": horario,
    "materia": materia,
    "salon": salon,
  });
}

Future<void> actualizarAsignacion(String uid, String newdocente,String newedificio,
    newhorario, newmateria, newsalon) async{
  await db.collection("asignacion").doc(uid).set({
    "docente": newdocente,
    "edificio": newedificio,
    "horario": newhorario,
    "materia": newmateria,
    "salon": newsalon,});
}

Future<void> borrarAsignacion(String uid) async {
  await db.collection("asignacion").doc(uid).delete();
}

Future<List<Map<String, dynamic>>> getAsistencias(String asignacionId) async {
  List<Map<String, dynamic>> asistencia = [];
  QuerySnapshot queryAsistencia = await FirebaseFirestore.instance.collection('asignacion').doc(asignacionId).collection('asistencia').get();
  for (var doc in queryAsistencia.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asistenciaDoc = {
      "fechahora": data['fechahora'],
      "revisor": data['revisor'],
      "uid": doc.id,
    };
    asistencia.add(asistenciaDoc);
  }
  await Future.delayed(const Duration(seconds: 1));
  return asistencia;
}

Future<void> insertarAsistencia(String asignacionId, Map<String, dynamic> asistenciaData) async{
  await db.collection('asignacion').doc(asignacionId).collection('asistencia').add(asistenciaData);
}