import 'package:get/get.dart';
import 'package:quiz/controller/question_controller.dart';

class MyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionController());
  }

}