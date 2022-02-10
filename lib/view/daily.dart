import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/interface/auth_interface.dart';
import 'package:flutter_todo_app/core/model/task_model.dart';
import 'package:flutter_todo_app/core/service/database_service.dart';
import 'package:flutter_todo_app/core/utils/utils.dart';
import 'package:flutter_todo_app/view/create_task.dart';
import 'package:flutter_todo_app/view/widget/custom_appbar.dart';
import 'package:flutter_todo_app/view/widget/task_card.dart';
import 'package:provider/provider.dart';

import '../locator.dart';

class Daily extends StatelessWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthInterface>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CreateTask(type: 'daily')));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const CustomAppBar(title: 'Günlük Planlar', hasBack: false),
          Expanded(
            child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('tasks')
                    .child(authService.userCredential.data!.user!.uid)
                    .child('daily')
                    .onValue,
                builder: (BuildContext context, event) {
                  if (event.hasData == true &&
                      event.data!.snapshot.value != null &&
                      event.connectionState == ConnectionState.active) {
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
                          return FlipCard(
                              front: TaskCard(
                                title: taskModel[index].title,
                                content: taskModel[index].content,
                              ),
                              back: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        if (taskModel[index].taskId == '') {
                                          locator<Utils>()
                                              .showErrorSnackBar(context, 'Bu task silinemez');
                                        } else {
                                          locator<Database>()
                                              .deleteTask('daily', taskModel[index].taskId!,authService.userCredential.data!.user!.uid );
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(CupertinoIcons.delete, color: Colors.white),
                                          Text('Sil', style: TextStyle(color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  )));
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
