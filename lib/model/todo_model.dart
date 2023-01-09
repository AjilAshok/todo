import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference todosCollection =
    FirebaseFirestore.instance.collection("Todos");

class Todo {
  String uid;
  String title;
  String subTitle;

  Todo({required this.uid, required this.title, required this.subTitle});
}
