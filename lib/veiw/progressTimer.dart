import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/controller/question_controller.dart';

class ProgressTimer extends StatelessWidget {
  ProgressTimer({Key? key}) : super(key: key);
  final controller = Get.find<QuestionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>SizedBox(
          height: 50,
            width: 50,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1-(controller.sec.value/15),
                color: KPrimaryColor,
                backgroundColor: Colors.grey,
                strokeWidth: 8,
              ),
              Center(
                child: Text(
                  '${controller.sec.value}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: KPrimaryColor)
                ),
              )
            ],
          ),
        )
    );
  }
}
