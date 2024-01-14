import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/createQuestionPage.dart';
import 'package:flutter_business_manager/pages/emailPage.dart';
import 'package:flutter_business_manager/pages/questionsPage.dart';
import 'package:provider/provider.dart';
import '../services/database/firebase_service.dart';


class EmailsPage extends StatefulWidget {
  const EmailsPage({super.key});

  @override
  State<EmailsPage> createState() => _EmailsPageState();
}

class _EmailsPageState extends State<EmailsPage> {
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
        title: const Text("Contact Us : Emails")
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firebaseService.getEmails(),
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
                              child: EmailPage(
                                emailID: snapshot.data!.docs[index].id,
                                updateState: (){updateState();},
                                userID: snapshot.data!.docs[index].get("userID"),
                                emailSubject: snapshot.data!.docs[index].get("emailSubject"),
                                emailBody: snapshot.data!.docs[index].get("emailBody"),
                                uploadedOn: snapshot.data!.docs[index].get("uploadedOn"),
                                ));
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
}