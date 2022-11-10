import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:quizz_app_2/views/create_quiz.dart';

class DatabaseService {
  Future<void> addQuizData(quizData, quizId) async {
    await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(questionData, quizId) async {
    await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print("Error to add questionnnn is: ${e.toString()}");
    });
  }

  // void addQuestions(String id) {
  //   var db = FirebaseFirestore.instance.collection("quiz");

  //   db.doc(id).collection("Sub-collection").add({"name": "Joeee"});
  // }

  // getQuizData() async {
  //   return await FirebaseFirestore.instance.collection("quiz").snapshots();
  // }

  getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
