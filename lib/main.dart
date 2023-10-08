import 'package:flutter/material.dart';
import 'package:sqlfilewithnote/add_note.dart';
import 'package:sqlfilewithnote/primary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PrimaryHome(),
      routes: {
        "add": (context) => const AddNote(),
        "home": (context) => const PrimaryHome(),
      },
    );
  }
}
