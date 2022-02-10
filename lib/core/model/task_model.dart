
import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

class TaskModel {
    TaskModel({
        required this.content,
        required this.title,
         this.taskId,

    });

    String content;
    String title;
    String? taskId;

    factory TaskModel.fromJson(Map<dynamic, dynamic> json) => TaskModel(
        content: json["content"],
        title: json["title"],
        taskId: json["taskId"] ?? ''
    );

    
}
