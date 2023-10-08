import 'package:flutter/material.dart';
import 'package:sqlfilewithnote/edit_notes.dart';
import 'package:sqlfilewithnote/sqldb.dart';

class PrimaryHome extends StatefulWidget {
  const PrimaryHome({super.key});

  @override
  State<PrimaryHome> createState() => _PrimaryHomeState();
}

class _PrimaryHomeState extends State<PrimaryHome> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readDate() async {
    List<Map> response = await sqlDb.readDate("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "add");
          },
          child: const Icon(Icons.add)),
      body: ListView(children: [
        // ElevatedButton(
        //     onPressed: () {
        //       sqlDb.myDeleteDatabase();
        //     },
        //     child: Text("delete database")),
        FutureBuilder(
          future: readDate(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${snapshot.data![index]['note']}"),
                      subtitle: Text("${snapshot.data![index]['title']}"),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      note: snapshot.data![index]['note'],
                                      title: snapshot.data![index]['title'],
                                      id: snapshot.data![index]['id'],
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.edit, color: Colors.blue)),
                        IconButton(
                            onPressed: () async {
                              int response = await sqlDb.deleteDate(
                                  'DELETE FROM notes WHERE id = ${snapshot.data![index]['id']}');
                              setState(() {});
                              print(response);
                            },
                            icon: const Icon(Icons.delete, color: Colors.red))
                      ]),
                    ),
                  );
                },
              );
            } else if (!(snapshot.hasData)) {
              return const Center(
                child: Text(
                  "this not are notes please add note",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ]),
    );
  }
}
