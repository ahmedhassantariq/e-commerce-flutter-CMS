import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  late FirebaseService firebaseService;

  final TextEditingController _question = TextEditingController();
  final TextEditingController _answer = TextEditingController();


  postQuestion(){
    if(_question.text.isNotEmpty&& _answer.text.isNotEmpty){
      firebaseService.createQuestion(_question.text, _answer.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Frequent Question Created")));
        _question.clear();
        _answer.clear();
        Navigator.pop(context);
      });

    }
  }


  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(controller: _question, hintText: "Question", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _answer, hintText: "Answer", obscureText: false),
          TextButton.icon(onPressed: (){postQuestion();}, icon: const Icon(Icons.post_add), label: const Text("Post Query"),)
        ],
      ),
    );
  }
}
