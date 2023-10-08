import 'package:flutter/material.dart';
import 'package:sqlfilewithnote/sqldb.dart';
import 'package:sqlfilewithnote/widgets/text_from_field.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.note, required this.title, this.id});
  final String note, title;
  final id;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  void initState() {
    titleController.text = widget.title;
    noteController.text = widget.note;
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
        title: const Text('editNotes'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: "edit note",
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
                  hintText: "edit title",
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
                                  int response = await sqlDb.updateDate('''
                                  UPDATE notes SET 
                                  note = "${noteController.text}",
                                  title = "${titleController.text}" 
                                  WHERE id = ${widget.id}
                                  ''');
                          print(response);
                          if (response > 0) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "home", (route) => false);
                          }
                        }
                      },
                      child: const Text("edit note")),
                ),
              ],
            ),
          )),
    );
  }
}
