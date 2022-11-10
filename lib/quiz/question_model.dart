class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> list = [];

  list.add(Question("Who is the owner of flutter?", [
    Answer("Nokia", false),
    Answer("Samsung", false),
    Answer("Google", true),
    Answer("Apple", false),
  ]));

  list.add(Question("Who owns Iphone?", [
    Answer("Apple", true),
    Answer("Microsoft", false),
    Answer("Google", false),
    Answer("nOKIA", false),
  ]));

  list.add(Question("Youtube is ________ platform", [
    Answer("Music Sharing", false),
    Answer("Video Sharing", false),
    Answer("Live Streaming", false),
    Answer("All of the above", true),
  ]));

  list.add(Question("Flutter use Dart as a language?", [
    Answer("True", true),
    Answer("False", false),
  ]));

  return list;
}
