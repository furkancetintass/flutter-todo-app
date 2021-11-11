import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/extension/string_extension.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String content;
  const TaskCard({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.yellow.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w700),
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              Text(content.capitalize()),
            ]),
          ),
        ));
  }
}
