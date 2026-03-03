class Model {
  final String question;
  final List<Answers> answers;

  Model({required this.question, required this.answers});
}

class Answers {
  final String choissen;
  final bool iscorrect;

  Answers({required this.choissen, required this.iscorrect});
}

List<Model> questions = [
  Model(
    question: "What is the owner flutter ?",
    answers: [
      Answers(choissen: "amazon", iscorrect: false),
      Answers(choissen: "flutter", iscorrect: true),
      Answers(choissen: "google", iscorrect: false),
      Answers(choissen: "Almonofia?!", iscorrect: false),
    ],
  ),
  Model(
    question: "Who is the owner of iphone",
    answers: [
      Answers(choissen: "apple", iscorrect: true),
      Answers(choissen: "samsung", iscorrect: false),
      Answers(choissen: "HUAWEI", iscorrect: false),
    ],
  ),
  Model(
    question: "Which language is used by Flutter?",
    answers: [
      Answers(choissen: "Java", iscorrect: false),
      Answers(choissen: "Dart", iscorrect: true),
      Answers(choissen: "Kotlin", iscorrect: false),
      Answers(choissen: "Swift", iscorrect: false),
    ],
  ),
  Model(
    question: "What company created Flutter?",
    answers: [
      Answers(choissen: "Apple", iscorrect: false),
      Answers(choissen: "Facebook", iscorrect: false),
      Answers(choissen: "Google", iscorrect: true),
      Answers(choissen: "Microsoft", iscorrect: false),
    ],
  ),
  Model(
    question: "Flutter is mainly used for?",
    answers: [
      Answers(choissen: "Data Analysis", iscorrect: false),
      Answers(choissen: "Mobile App Development", iscorrect: true),
      Answers(choissen: "Cyber Security", iscorrect: false),
      Answers(choissen: "Web Hosting", iscorrect: false),
    ],
  ),
  Model(
    question: "Which widget is used for layout in Flutter?",
    answers: [
      Answers(choissen: "Column", iscorrect: true),
      Answers(choissen: "Paint", iscorrect: false),
      Answers(choissen: "Color", iscorrect: false),
      Answers(choissen: "MediaQuery", iscorrect: false),
    ],
  ),
  Model(
    question: "What does 'StatelessWidget' mean?",
    answers: [
      Answers(choissen: "It changes UI", iscorrect: false),
      Answers(choissen: "It has no state", iscorrect: true),
      Answers(choissen: "It’s a button", iscorrect: false),
      Answers(choissen: "It loads images", iscorrect: false),
    ],
  ),
  Model(
    question: "What command runs a Flutter app?",
    answers: [
      Answers(choissen: "flutter go", iscorrect: false),
      Answers(choissen: "flutter run", iscorrect: true),
      Answers(choissen: "flutter build", iscorrect: false),
      Answers(choissen: "flutter clean", iscorrect: false),
    ],
  ),
  Model(
    question: "Which one is a state management solution?",
    answers: [
      Answers(choissen: "Bloc", iscorrect: true),
      Answers(choissen: "Paint", iscorrect: false),
      Answers(choissen: "Render", iscorrect: false),
      Answers(choissen: "Align", iscorrect: false),
    ],
  ),
  Model(
    question: "Which one is a state management solution?",
    answers: [
      Answers(choissen: "Bloc", iscorrect: true),
      Answers(choissen: "Paint", iscorrect: false),
      Answers(choissen: "Render", iscorrect: false),
      Answers(choissen: "Align", iscorrect: false),
    ],
  ),
];
