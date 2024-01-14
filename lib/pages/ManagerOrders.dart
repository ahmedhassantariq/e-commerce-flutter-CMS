import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';
import 'package:provider/provider.dart';


class ManageOrders extends StatefulWidget {
  final String orderID;
  final String customerID;
  final List orderItems;
  final Timestamp orderedOn;
  final Function() updateState;
  const ManageOrders({
    required this.orderID,
    required this.customerID,
    required this.orderItems,
    required this.orderedOn,
    required this.updateState,
    super.key
  });

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}


class _ManageOrdersState extends State<ManageOrders> {


  @override
  void initState() {

    super.initState();
  }

  deleteOrder(){
    FirebaseService firebaseService = Provider.of<FirebaseService>(context, listen: false);
    firebaseService.deleteOrder(widget.orderID);
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
                    Text("OrderID: ${widget.orderID}"),
                  ],
                );
              },
              body: ListTile(
                title: Column(
                  children: [
                    Text("CustomerID: ${widget.customerID}"),
                    const SizedBox(height: 8.0),
                    for(int i=0;i<widget.orderItems.length;i++)
                      Text("ItemID | Qty: ${widget.orderItems[i]}"),
                    IconButton(onPressed: (){deleteOrder();}, icon: const Icon(Icons.delete))
                  ],
                ),
              ),
              isExpanded: isExpansion,
            )]
      ),
    );
  }
}




