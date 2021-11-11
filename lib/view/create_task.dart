import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/interface/auth_interface.dart';
import 'package:flutter_todo_app/core/service/database_service.dart';
import 'package:flutter_todo_app/core/utils/utils.dart';
import 'package:flutter_todo_app/locator.dart';
import 'package:flutter_todo_app/view/widget/button/primary_button.dart';
import 'package:flutter_todo_app/view/widget/custom_appbar.dart';
import 'package:flutter_todo_app/view/widget/my_text_field.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  Database database = locator<Database>();

  Utils utils = locator<Utils>();

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthInterface>(context);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: 'Görev Ekle',
            hasBack: true,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildTextField(
                  
                    label: 'Başlık',
                    controller: titleController,
                    icon: const Icon(Icons.edit),
                    context: context),
                const SizedBox(height: 16),
                buildTextField(
                    label: 'İçerik',
                    controller: contentController,
                    icon: const Icon(Icons.message),
                    context: context,
                    maxLines: 5),
                const SizedBox(height: 20),
                PrimaryButton(
                  child: const Text('Kaydet', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    if (titleController.text == '') {
                      utils.showErrorSnackBar(context, 'Lütfen başlık giriniz.');
                    } else if (contentController.text == '') {
                      utils.showErrorSnackBar(context, 'Lütfen içerik giriniz.');
                    } else {
                      database
                          .createTask(authService.userCredential.data!.user!.uid,
                              titleController.text, contentController.text, widget.type)
                          .then((value) {
                        if (value) {
                          setState(() {
                            titleController.text = '';
                            contentController.text = '';
                          });
                          utils.showSuccessSnackBar(context);
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
