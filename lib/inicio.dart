import 'package:dam_u4_proyecto2_18401120/pagina_asistencia.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asignación - Juan Diego Gómez Monteón"),centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
      body: FutureBuilder(
          future: getAsignacion(),
          builder: ((context, snapshot) {

            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context,index){
                    return Dismissible(
                      onDismissed: (direction) async{
                        await borrarAsignacion(snapshot.data?[index]['uid']);
                        snapshot.data?.removeAt(index);
                      },
                      confirmDismiss: (direction) async {
                        bool resul = false;
                        resul = await showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("¿Seguro de eliminar a ${snapshot.data?[index]["docente"]}?"),
                            actions: [
                              TextButton(onPressed: (){
                                return Navigator.pop(context,false);
                              }, child: Text("Cancelar", style: TextStyle(color: Colors.red),)),
                              TextButton(onPressed: (){
                                return Navigator.pop(context,true);
                              }, child: Text("Si, estoy seguro"))
                            ],
                          );
                        });
                        return resul;
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      ),
                      direction: DismissDirection.startToEnd,
                      key: Key(snapshot.data?[index]['uid']),
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(snapshot.data?[index]["docente"]),
                        subtitle: Text(snapshot.data?[index]['horario'] ?? ''),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('¿Qué desea hacer con la asignacion del docente ${snapshot.data?[index]['docente']}?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Actualizar'),
                                    onPressed: () async {
                                      await Navigator.pushNamed(context,"/edit", arguments: {
                                        "docente": snapshot.data?[index]['docente'],
                                        "edificio":snapshot.data?[index]['edificio'],
                                        "horario":snapshot.data?[index]['horario'],
                                        "materia":snapshot.data?[index]['materia'],
                                        "salon":snapshot.data?[index]['salon'],
                                        "uid":snapshot.data?[index]['uid'],
                                      } );
                                      setState(() {});
                                      setState(() {const Center(
                                        child: CircularProgressIndicator(),
                                      );});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Asistencia'),
                                    onPressed: () async{
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaginaAsistencia(AsignacionId: snapshot.data?[index]['uid'] ?? ''),
                                          )
                                      );
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
              );
            }else{
              return const Center(
                child: Text("Cargando..."),
              );
            }

          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.pushNamed(context,'/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
