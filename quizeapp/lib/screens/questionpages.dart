import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizeapp/Models/models.dart';
import 'package:quizeapp/screens/homepage.dart';
import 'package:quizeapp/bloc/homecubit.dart';
import 'package:quizeapp/bloc/statecubit.dart';

class Questionpages extends StatelessWidget {
  const Questionpages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangecountCubit(),
      child: const QuestionpagesView(),
    );
  }
}

class QuestionpagesView extends StatelessWidget {
  const QuestionpagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangecountCubit, ChangeqtState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<ChangecountCubit>(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 5),
              const Text(
                "Quizz App ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        " Questions ${cubit.index + 1}/${questions.length}",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "${(cubit.index + 1) * 10} % completed",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(25),
                  value: (cubit.index + 1) / questions.length,
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                  minHeight: 10,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 130,
                    child: Text(
                      questions[cubit.index].question,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              for (int i = 0; i < questions[cubit.index].answers.length; i++)
                answerbutton(questions[cubit.index].answers[i], cubit),
              movebuttom(context, cubit),
            ],
          ),
        );
      },
    );
  }

  Widget movebuttom(BuildContext context, ChangecountCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minWidth: double.infinity,
        height: 80,
        onPressed: () {
          cubit.nextquestion(questions.length);

          if (cubit.islastquestion) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                title: Text(
                  cubit.score > 5
                      ? " passed | score is ${cubit.score} "
                      : " faild | score is ${cubit.score} ",
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.reset();
                        Navigator.pop(ctx);
                      },
                      child: const Text("reset"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.reset();
                        Navigator.pushReplacement(
                          ctx,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                      },
                      child: const Text("home"),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        child: Text(
          cubit.index == questions.length - 1 && cubit.islastquestion == false
              ? "submit"
              : "Next questions ",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget answerbutton(Answers answer, ChangecountCubit cubit) {
    bool isselect = cubit.selectanswer == answer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        color: isselect ? Colors.orange : Colors.white,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        minWidth: double.infinity,
        height: 80,
        onPressed: () {
          cubit.selectAnswer(answer);
        },
        child: Text(
          answer.choissen,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
