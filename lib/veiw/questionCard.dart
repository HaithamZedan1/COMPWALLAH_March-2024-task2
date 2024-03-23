import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/question_controller.dart';
import 'answerOptions.dart';

class QuestionCard extends StatelessWidget {
  final Map<String, dynamic> data;

  QuestionCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 450,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['question'], style: Theme.of(context).textTheme.headline6),
              const Spacer(flex: 1),
              ...List.generate(4, (index) => Column(
                children: [
                  AnswerOptions(
                    questionsID: data['id'],
                    text: data['answer${index + 1}'],
                    index: index,
                      onPressed: () {
                        // Extract answer_num and answer values from data map
                        dynamic answerNumValue = data['answer_num'];
                        dynamic selectedAnswerValue = index +3;
                        print(answerNumValue);
                        print(selectedAnswerValue);
                        Get.find<QuestionController>().checkAnswer(answerNumValue, selectedAnswerValue, data['id']);
                      },
                  ),
                  const SizedBox(height: 15),
                ],
              )),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
