import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/question_controller.dart';
import '../constants.dart';
import 'customButton.dart';
import 'leaderScreen.dart';


class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuestionController>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
          ),
          Center(
            child: GetBuilder<QuestionController>(
              init: controller,
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Finish!!',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    controller.name,
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: KPrimaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Your score is',
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${controller.scoreResult.round()} / 100',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: KPrimaryColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(

                    children: [
                      CustomButton(
                        width: 300,
                        onPressed: () async{
                         await controller.addToLeaderboard(controller.name, controller.scoreResult.round());
                          Get.offAndToNamed(LeaderboardScreen.routeName);
                        },
                        text: 'Leaderboard',
                      ),
                      SizedBox(height: 30,),
                      CustomButton(
                        width: 300,
                        onPressed: () {
                          controller.addToLeaderboard(controller.name, controller.scoreResult.round());
                          controller.startAgain();
                        },
                        text: 'Start Again',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
