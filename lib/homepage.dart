import 'package:flutter/material.dart';
import 'package:sqlfilewithnote/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readDate() async {
    List<Map> response = await sqlDb.readDate("SELECT * FROM notes");
    return response;
  }

  @override
  void initState() {
    sqlDb.intialDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(children: [
        Center(
          child: ElevatedButton(
              onPressed: () async {
                int response = await sqlDb.insertDate(
                    "INSERT INTO notes (note) VALUES ('note five')");
                print(response);
              },
              child: const Text("inset Date")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () async {
                List<Map> response =
                    await sqlDb.readDate("SELECT * FROM 'notes'");
                print(response);
              },
              child: const Text("Read Date")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () async {
                int response =
                    await sqlDb.deleteDate('DELETE FROM notes WHERE id = 2');
                print(response);
              },
              child: const Text("Delete Date")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () async {
                
                int response = await sqlDb.updateDate(
                    'UPDATE notes SET note = "five note" WHERE id = 5');
                print(response);
              },
              child: const Text("Update Date")),
        ),
      ]),
    );
  }
}
