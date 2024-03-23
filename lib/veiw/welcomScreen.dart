import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/controller/question_controller.dart';
import 'package:quiz/veiw/customButton.dart';
import 'package:quiz/veiw/quizScreen.dart';

class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({Key? key}) : super(key: key);
  static const routeName = '/welcome_screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  void _submit(context){
    FocusScope.of(context).unfocus();
    if(!_formkey.currentState!.validate()) return;
    _formkey.currentState!.save();
    Get.offAndToNamed(QuizScreen.routeName);
    Get.find<QuestionController>().startTimer();
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(color: Colors.black87),
        child: Stack(
          children: [
            Padding(padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Text('Let\'s start the Quiz',style: Theme.of(context).textTheme.headline3!.copyWith(color: KPrimaryColor)),
                Text(
                  'Enter your name',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
                const Spacer(
                  flex: 1,
                ),
                Form(
                  key: _formkey,
                  child: GetBuilder<QuestionController>(
                    init: Get.find<QuestionController>(),
                    builder: (controller)=> TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                        )
                      ),
                      validator: (String? val){
                        if(val!.isEmpty)
                          return 'name should not be empty';
                        else
                          return null;
                      },
                      onSaved: (String? val){
                        controller.name = val!.trim().toUpperCase();
                      },
                      onFieldSubmitted: (_) => _submit(context),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: double.infinity,
                    onPressed: ()=> _submit(context),
                    text: 'Let\'s start',
                  ),
                ),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}

