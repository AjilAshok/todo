import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todopro/constant/constant.dart';
import 'package:todopro/screens/widgets/view_updatedpage.dart';
import 'package:todopro/service/datebase_service.dart';

class HomaPage extends StatelessWidget {
  const HomaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController titileControler = TextEditingController();
    TextEditingController subTitileControler = TextEditingController();
    return Scaffold(
      backgroundColor: Constants.black,
      appBar: AppBar(
        title: Text(
          'Todo',
          style: TextStyle(color: Constants.white),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Todos').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Todos',
                        style: TextStyle(color: Constants.white, fontSize: 25),
                      ),
                    );
                  }
                  final docs = snapshot.data!.docs;
                  return Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListView.builder(
                          itemCount: docs.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewPage(
                                    title: docs[index]['title'],
                                    subTitle: docs[index]['subTitle'],
                                    uid: docs[index]['uid'],
                                  ),
                                ));
                              },
                              leading: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                              ),
                              title: Text(
                                docs[index]['title'],
                                style: TextStyle(
                                    color: Constants.white, fontSize: 23),
                              ),
                              subtitle: Text(
                                docs[index]['subTitle'],
                                style: TextStyle(
                                    color: Constants.white, fontSize: 20),
                              ),
                            );
                          })));
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Add_todo(context, formKey, titileControler, subTitileControler);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Add_todo(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController titileControler,
      TextEditingController subTitileControler) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Constants.white,
          title: const Text('Enter values'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: titileControler,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: subTitileControler,
                      decoration: const InputDecoration(labelText: 'Todo '),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            DatabaseService().createNewTodo(
                                titileControler.text, subTitileControler.text);

                            titileControler.clear();
                            subTitileControler.clear();

                            Navigator.of(context).pop();
                          }
                        },
                        child: const Center(child: Text('Add')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
