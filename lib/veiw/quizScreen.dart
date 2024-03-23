import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/veiw/progressTimer.dart';
import 'package:quiz/veiw/questionCard.dart';

import '../controller/question_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName= '/quiz_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black87
            ),
          ),
          SafeArea(
              child: GetBuilder<QuestionController>(
                  init: QuestionController(),
                  builder: (controller)=>Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(text: TextSpan(
                              text: 'Question',
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                              children : [
                                TextSpan(
                                  text: controller.numberOfQuestion.round().toString(),
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)),
                                  TextSpan(
                                    text: '/',
                                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)
                                  ),
                                  TextSpan(
                                    text: controller.countOfQuestion.toString(),
                                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)
                                  )
                              ]
                            )),
                            ProgressTimer()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 450,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index) => QuestionCard(
                              data: controller.questionList[index],
                            ),
                          controller: controller.pageController,
                          itemCount: controller.questionList.length,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
              ))
          )
        ],
      ),
    );
  }
}
