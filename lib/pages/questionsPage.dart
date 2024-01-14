import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:flutter_business_manager/model/productModel.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';
import 'package:provider/provider.dart';


class QuestionsPage extends StatefulWidget {
  final String questionID;
  final String question;
  final String answer;
  final Function() updateState;
  const QuestionsPage({
    required this.questionID,
    required this.updateState,
    required this.question,
    required this.answer,
    super.key
  });

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}


class _QuestionsPageState extends State<QuestionsPage> {

  final TextEditingController _question = TextEditingController();
  final TextEditingController _answer = TextEditingController();


  @override
  void initState() {
    _question.text = widget.question;
    _answer.text = widget.answer;


    super.initState();
  }

  updateQuestion(){
    FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.updateQuestionAnswer(widget.questionID,_question.text,_answer.text).then((value){isExpansion = false;widget.updateState;});
  }
  deleteQuestion(){
    FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.deleteQuestionAnswer(widget.questionID);
    isExpansion = false;
    widget.updateState;
  }


  bool isExpansion = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionPanelList(
          materialGapSize: 8.0,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpansion = isExpanded;
            });
          },
          children:[
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Row(
                  children: [
                    Text(widget.question),
                  ],
                );
              },
              body: ListTile(
                title: Column(
                  children: [
                    CustomTextField(controller: _question, hintText: 'Title', obscureText: false,),
                    const SizedBox(height: 8.0),
                    CustomTextField(controller: _answer, hintText: 'Description', obscureText: false,),
                    const SizedBox(height: 8.0),
                    TextButton(onPressed: (){updateQuestion();}, child: const Text("Update")),
                    IconButton(onPressed: (){deleteQuestion();}, icon: const Icon(Icons.delete))
                  ],
                ),
              ),
              isExpanded: isExpansion,
            )]
      ),
    );
  }
}




