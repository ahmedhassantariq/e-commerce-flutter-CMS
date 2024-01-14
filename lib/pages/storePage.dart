import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/createPostPage.dart';
import 'package:flutter_business_manager/pages/productPage.dart';
import 'package:provider/provider.dart';
import '../model/productModel.dart';
import '../services/database/firebase_service.dart';


class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
        title: const Text("Store Page"),
      actions: [
        IconButton(onPressed: (){showCreateProduct();}, icon: Icon(Icons.add))
      ],),
      body: StreamBuilder<List<ProductModel>>(
          stream: firebaseService.getFeaturedPostData(),
          builder: (context, snapshot) {
            // FirebaseService().createPost();
            if (snapshot.hasData) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {

                          return GestureDetector(
                              onTap: (){},
                              child: ProductPage(productModel: snapshot.data![index], updateState: updateState)
                        );}
                  )
                  )],
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


  showCreateProduct() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return const CreateProductPage();
        });
  }
}
