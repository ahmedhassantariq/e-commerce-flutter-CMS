import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/createQuestionPage.dart';
import 'package:flutter_business_manager/pages/questionsPage.dart';
import 'package:provider/provider.dart';
import '../services/database/firebase_service.dart';


class FrequentQuestionsPage extends StatefulWidget {
  const FrequentQuestionsPage({super.key});

  @override
  State<FrequentQuestionsPage> createState() => _FrequentQuestionsPageState();
}

class _FrequentQuestionsPageState extends State<FrequentQuestionsPage> {
  late FirebaseService firebaseService;

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.addListener(() {updateState();});
    super.initState();
  }

  updateState(){
    setState(() {
    });
  }

  @override
  void dispose() {
    firebaseService.removeListener(() {updateState();});
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequently Asked Questions Page"),
            actions: [
              IconButton(onPressed: (){showCreateQuestionMenu();}, icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firebaseService.getQuestionData(),
          builder: (context, snapshot) {
            // FirebaseService().createPost();
            if (snapshot.hasData) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: (){},
                              child: QuestionsPage(question : snapshot.data!.docs[index].get("question"), updateState: (){updateState();}, questionID: snapshot.data!.docs[index].id, answer: snapshot.data!.docs[index].get("answer"),));
                        }),
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Oops... A problem has occurred.'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }}),
    );
  }



  showCreateQuestionMenu() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return const CreateQuestionPage();
        });
  }
}
