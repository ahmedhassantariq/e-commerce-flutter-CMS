import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/ManagerOrders.dart';
import 'package:flutter_business_manager/pages/createQuestionPage.dart';
import 'package:provider/provider.dart';
import '../services/database/firebase_service.dart';
import '';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
        title: const Text("Manage Orders"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firebaseService.getOrdersData(),
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
                              child: ManageOrders(
                                  orderID: snapshot.data!.docs[index].get('orderID'),
                                  customerID: snapshot.data!.docs[index].get('customerID'),
                                  orderItems: snapshot.data!.docs[index].get('orderItems'),
                                  orderedOn: snapshot.data!.docs[index].get('orderedOn'),
                                  updateState: updateState));
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
