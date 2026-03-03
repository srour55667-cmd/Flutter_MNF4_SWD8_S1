import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizeapp/Models/models.dart';
import 'package:quizeapp/bloc/statecubit.dart';

class ChangecountCubit extends Cubit<ChangeqtState> {
  ChangecountCubit() : super(ChangeqtInitial());

  int index = 0;
  int score = 0;
  Answers? selectanswer;
  bool islastquestion = false;

  void selectAnswer(Answers answer) {
    selectanswer = answer;
    emit(ChangeqtUpdate());
  }

  void nextquestion(int totalQuestions) {
    if (selectanswer != null && selectanswer!.iscorrect) {
      score++;
    }

    if (index < totalQuestions - 1) {
      index++;
      selectanswer = null;
    } else {
      islastquestion = true;
    }

    emit(ChangeqtUpdate());
  }

  void reset() {
    score = 0;
    index = 0;
    selectanswer = null;
    islastquestion = false;
    emit(ChangeqtInitial());
  }
}
