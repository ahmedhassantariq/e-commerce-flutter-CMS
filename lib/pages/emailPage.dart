import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:flutter_business_manager/model/productModel.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';
import 'package:provider/provider.dart';


class EmailPage extends StatefulWidget {
  final String emailID;
  final String userID;
  final String emailSubject;
  final String emailBody;
  final Timestamp uploadedOn;
  final Function() updateState;
  const EmailPage({
    required this.emailID,
    required this.updateState,
    required this.userID,
    required this.emailSubject,
    required this.emailBody,
    required this.uploadedOn,
    super.key
  });

  @override
  State<EmailPage> createState() => _EmailPageState();
}


class _EmailPageState extends State<EmailPage> {

  deleteEmail(){
    FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.deleteEmail(widget.emailID);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subject: ${widget.emailSubject}"),
                    IconButton(onPressed: (){deleteEmail();}, icon: const Icon(Icons.delete_outline))
                  ],
                );
              },
              body: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("UserID: ${widget.userID}"),
                    const SizedBox(height: 8.0),
                    Text("Time: ${widget.uploadedOn.toDate()}"),
                    const SizedBox(height: 8.0),
                    Text("Subject: ${widget.emailSubject}"),
                    const SizedBox(height: 8.0),
                    Text("Message: ${widget.emailBody}"),
                  ],
                ),
              ),
              isExpanded: isExpansion,
            )]
      ),
    );
  }
}




