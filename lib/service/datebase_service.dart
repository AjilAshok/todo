import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection("Todos");

  Future createNewTodo(String title, String subTitle) async {
    return await todosCollection.add({
      "title": title,
      "subTitle": subTitle,
    }).then((DocumentReference doc) {
      todosCollection.doc(doc.id).update({'uid': doc.id});
    });
  }

  Future removeTodo(uid) async {
    await todosCollection.doc(uid).delete();
  }

  Future updateTodo(String title, String subTitle, String uid) async {
    return await todosCollection.doc(uid).update({
      "title": title,
      "subTitle": subTitle,
    });
  }
}
