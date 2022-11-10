import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/services/database.dart';
import '../widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  // const AddQuestion({super.key});
  final String quizId;
  AddQuestion(this.quizId);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  CollectionReference quiz = FirebaseFirestore.instance.collection('quiz');

  final _formkey = GlobalKey<FormState>();
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";
  late bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  // UploadQuestionData() async {
  //   if (_formkey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Map<dynamic, String> questionMap = {
  //       "question": question,
  //       "option1": option1,
  //       "option2": option2,
  //       "option3": option3,
  //       "option4": option4,
  //     };
  //     await databaseService
  //         .addQuestionData(questionMap, widget.quizId)
  //         .then((value) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       print("Question Added");
  //     });
  //   }
  // }

  UploadQuestionData() {
    print("CLicked");
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      print("${widget.quizId}");

      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        // question = "";
        // option1 = "";
        // option2 = "";
        // option3 = "";
        // option4 = "";
        setState(() {
          _isLoading = false;
        });
        print("Question Added");
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
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
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 1" : null,
                      decoration: InputDecoration(
                          hintText: "Option 1 (Correct Answer)"),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 2" : null,
                      decoration: InputDecoration(hintText: "Option 2"),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 3" : null,
                      decoration: InputDecoration(hintText: "Option 3"),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter Option 4" : null,
                      decoration: InputDecoration(hintText: "Option 4"),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: blueButton(
                              context: context,
                              label: "Submit",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Map<dynamic, String> questionMap = {
                            //     "question": question,
                            //     "option1": option1,
                            //     "option2": option2,
                            //     "option3": option3,
                            //     "option4": option4,
                            //   };
                            await UploadQuestionData();
                            // DatabaseService().addQuestions(questionMap,widget.quizId);
                            // CollectionReference quiz =
                            //     FirebaseFirestore.instance.collection('quiz');
                            // await quiz
                            //     .doc("")
                            //     .collection("QNA")
                            //     .add({
                            //   "id": widget.quizId,
                            //   "Question": question,
                            //   "Option1 (Correct ans)": option1,
                            //   "Option2": option2,
                            //   "Option3": option3,
                            //   "Option4": option4,
                            // }).then((value) {
                            //   setState(() {
                            //     _isLoading = false;
                            //   });
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               AddQuestion(widget.quizId)));
                            // }).catchError((error) =>
                            //         print("Failed to add questions: $error"));
                          },
                          child: blueButton(
                              context: context,
                              label: "Add Question",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        )

                        // **********************************************************************88
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     await quiz.add({
                        //       "question": question,
                        //     }).then((value) {
                        //       print("hogaya baba");
                        //     }).catchError((error) =>
                        //         print("Failed to add questions: $error"));
                        //     // await CreateQuizOnline();
                        //   },
                        //   child: blueButton(
                        //       context: context,
                        //       label: "Add Question",
                        //       buttonWidth:
                        //           MediaQuery.of(context).size.width / 2 - 36),
                        // ),

                        // ***************************************************************************
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     await quiz.add({
                        //       "question": question,
                        //     }).then((value) {
                        //       print("hogaya baba");
                        //     }).catchError((error) =>
                        //         print("Failed to add questions: $error"));
                        //     // await CreateQuizOnline();
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       vertical: 18,
                        //     ),
                        //     decoration: BoxDecoration(
                        //         color: Colors.blue,
                        //         borderRadius: BorderRadius.circular(30)),
                        //     alignment: Alignment.center,
                        //     width: MediaQuery.of(context).size.width / 2 - 36,
                        //     child: Text(
                        //       "Next1",
                        //       style: TextStyle(color: Colors.white, fontSize: 20),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
