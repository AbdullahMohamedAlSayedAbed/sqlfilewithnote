import 'package:flutter/material.dart';
import 'package:sqlfilewithnote/sqldb.dart';
import 'package:sqlfilewithnote/widgets/text_from_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late TextEditingController titleController;
  late TextEditingController noteController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('addNotes'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: "add note",
                  controller: noteController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "the note is requerd";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: "add title",
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "the title is requerd";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          int response = await sqlDb.insertDate(
                              "INSERT INTO notes (note,title) VALUES ('${noteController.text}','${titleController.text}')");
                          print(response);
                          if (response > 0) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "home", (route) => false);
                          }
                        }
                      },
                      child: const Text("add note")),
                ),
              ],
            ),
          )),
    );
  }
}
