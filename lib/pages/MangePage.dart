import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/emailsPage.dart';
import 'package:flutter_business_manager/pages/frequentQuestionsPage.dart';
import 'package:flutter_business_manager/pages/homePageSettings.dart';
import 'package:flutter_business_manager/pages/ordersPage.dart';
import 'package:flutter_business_manager/pages/storePage.dart';
import 'package:flutter_business_manager/services/auth/auth_service.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';


class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Green Heaven CMS"),),
      drawer: Drawer(
        child: ListView(
          children: [
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const StorePage()));}, child: const Text("Store")),
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailsPage()));}, child: const Text("Emails")),
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const FrequentQuestionsPage()));}, child: const Text("Frequent Questions")),
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrdersPage()));}, child: const Text("Orders")),
            const SizedBox(height: 8.0),
            TextButton(onPressed: (){AuthService().signOut();}, child: const Text("Sign Out"))

          ],
        ),
      ),
      body: const HomePageSettings(),
    );
  }
}
