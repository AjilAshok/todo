import 'package:flutter/material.dart';
import 'package:todopro/constant/constant.dart';
import 'package:todopro/service/datebase_service.dart';

class ViewPage extends StatelessWidget {
  const ViewPage(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.uid});
  final String? title;
  final String? subTitle;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController titileControler = TextEditingController(text: title);
    TextEditingController subTitileControler =
        TextEditingController(text: subTitle);
    return Scaffold(
      backgroundColor: Constants.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                deleteDialogue(context);
              },
              icon: const Icon(
                Icons.delete,
              )),
        ],
        title: Text(
          title.toString(),
          style: TextStyle(color: Constants.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Constants.white),
                controller: titileControler,
                decoration: InputDecoration(
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder(),
                    labelText: 'Title ',
                    labelStyle: const TextStyle(color: Colors.red)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Constants.white),
                controller: subTitileControler,
                decoration: InputDecoration(
                    border: myinputborder(),
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusborder(),
                    labelText: 'Subtitle ',
                    hintStyle: TextStyle(color: Constants.white),
                    labelStyle: const TextStyle(color: Colors.red)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await DatabaseService().updateTodo(
                          titileControler.text, subTitileControler.text, uid);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Update',
                  ))
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Constants.blue,
          width: 3,
        ));
  }

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Constants.blue,
          width: 3,
        ));
  }

  void deleteDialogue(BuildContext contextchild) {
    showDialog(
      context: contextchild,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure'),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                DatabaseService().removeTodo(uid);
                Navigator.of(context).pop();
                Navigator.of(contextchild).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
