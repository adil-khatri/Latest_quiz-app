import 'package:flutter/material.dart';
import 'package:quiz_app_kjs/Components/Home.dart';
import 'package:quiz_app_kjs/quiz/MyAnsPage.dart';
import 'package:quiz_app_kjs/quiz/question_model.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //defines the data
  List<Question> questionList = getQuestion();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Sample Quizz App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          _questionWidget(),
          _answerList(),
          _nextButton(),
        ]),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Questions ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 48,
        child: ElevatedButton(
          child: Text(answer.answerText),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: isSelected ? Colors.orangeAccent : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          onPressed: () {
            if (selectedAnswer == null) {
              if (answer.isCorrect) {
                score++;
              }
              setState(() {
                selectedAnswer = answer;
              });
            }
          },
        ));
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 48,
        child: ElevatedButton(
          child: Text(isLastQuestion ? "Submit" : "Next"),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            if (isLastQuestion) {
              //display score
              showDialog(context: context, builder: (_) => _showScoreDialog());
            } else {
              //next question
              setState(() {
                selectedAnswer = null;
                currentQuestionIndex++;
              });
            }
          },
        ));
  }

  _showScoreDialog() {
    bool isPassed = false;
    if (score >= questionList.length * 0.6) {
      //pass if 60%
      isPassed = true;
    }

    String title = isPassed ? "Passed " : "Failed";

    return AlertDialog(
      title: Text(
        title + " | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text("View Answers"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyAnsPage()),
          );
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}
