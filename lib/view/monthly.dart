
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/interface/auth_interface.dart';
import 'package:flutter_todo_app/core/model/task_model.dart';
import 'package:flutter_todo_app/view/create_task.dart';
import 'package:flutter_todo_app/view/widget/custom_appbar.dart';
import 'package:flutter_todo_app/view/widget/task_card.dart';
import 'package:provider/provider.dart';

class Monthly extends StatelessWidget {
  const Monthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthInterface>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateTask(type: 'monthly')));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const CustomAppBar(title: 'Aylık Planlar', hasBack: false),
          Expanded(
            child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('tasks')
                    .child(authService.userCredential.data!.user!.uid)
                    .child('monthly')
                    .onValue,
                builder: (BuildContext context, event) {
                  if (event.hasData == true && event.connectionState == ConnectionState.active &&event.data!.snapshot.value != null) {
                    List<TaskModel> taskModel = [];
                    var incoming = event.data!.snapshot.value;

                    incoming.forEach((key, value) {
                      var incomingData = TaskModel.fromJson(value);
                      taskModel.add(incomingData);
                    });

                    return GridView.builder(
                        itemCount: taskModel.length,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (_, index) {
                          return TaskCard(
                            title: taskModel[index].title,
                            content: taskModel[index].content,
                          );
                        });
                  } else if (event.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
