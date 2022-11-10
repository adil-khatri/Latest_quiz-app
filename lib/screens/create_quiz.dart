import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/screens/addquestion.dart';
import 'package:quiz_app_kjs/services/database.dart';

import '../widgets/widgets.dart';
// import 'package:quizz_app_2/views/addquestion.dart';
import 'package:random_string/random_string.dart';
// import 'dart:html';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  CollectionReference quiz = FirebaseFirestore.instance.collection('quiz');

  final _formkey = GlobalKey<FormState>();
  late String quizImgUrl, quizTitle, quizDesc;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  String quizId = randomAlphaNumeric(16);

  CreateQuizOnline() async {
    if (_formkey.currentState!.validate()) {
      quizId = randomAlphaNumeric(16);
      setState(() {
        _isLoading = true;
      });
      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImgUrl": quizImgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
        print("Quizz Created");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(children: [
                  TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? "Enter Quiz Image Url" : null,
                    decoration:
                        InputDecoration(hintText: "Quiz Image Url (Optional)"),
                    onChanged: (val) {
                      quizImgUrl = val;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? "Enter Quiz Title" : null,
                    decoration: InputDecoration(hintText: "Quiz Title"),
                    onChanged: (val) {
                      quizTitle = val;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? "Enter Quiz Description" : null,
                    decoration: InputDecoration(hintText: "Quiz Description"),
                    onChanged: (val) {
                      quizDesc = val;
                    },
                  ),
                  Spacer(),
                  // blueButton(context, "Create Quiz"),
                  ElevatedButton(
                    onPressed: () async {
                      // await quiz.doc(quizId).set({
                      //   // "quizId": quizId,
                      //   "quizImgUrl": quizImgUrl,
                      //   "quizTitle": quizTitle,
                      //   "quizDesc": quizDesc
                      // }).then((value) {
                      //   // setState(() {
                      //   //   _isLoading = false;
                      //   // });
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => AddQuestion(quizId)));
                      // }).catchError(
                      //     (error) => print("Failed to add user: $error"));

                      // **************NICHE WAALAA WORKING HAI************
                      await CreateQuizOnline();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 48,
                      child: Text(
                        "Next1",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ]),
              ),
            ),
    );
  }
}
