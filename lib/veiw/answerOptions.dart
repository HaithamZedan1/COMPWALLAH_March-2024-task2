import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/question_controller.dart';

class AnswerOptions extends StatelessWidget {
  final String text;
  final int index, questionsID;
  final Function() onPressed;

  AnswerOptions({
    required this.text,
    required this.index,
    required this.questionsID,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (controller) => InkWell(
        onTap: controller.checkIsQuestionAnswered(questionsID) ? null : onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 3, color: controller.getColor(index)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: '${index + 1}. ',
                    style: Theme.of(context).textTheme.headline6,
                    children: [
                      TextSpan(
                        text: text,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
