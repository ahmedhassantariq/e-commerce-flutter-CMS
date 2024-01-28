import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/pages/productPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../components/heroImage.dart';
import '../components/textField.dart';
import '../model/productModel.dart';
import '../services/database/firebase_service.dart';


class HomePageSettings extends StatefulWidget {
  const HomePageSettings({super.key});

  @override
  State<HomePageSettings> createState() => _HomePageSettingsState();
}

class _HomePageSettingsState extends State<HomePageSettings> {
  final TextEditingController _customerDealsTextController = TextEditingController();
  final TextEditingController _exclusiveTextController = TextEditingController();
  late FirebaseService firebaseService;
  final ImagePicker picker = ImagePicker();
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



  double featureImageWidth = 200;
  double exclusiveImageWidth = 100;

  @override
  void dispose() {
    firebaseService.removeListener(() {updateState();});
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          FutureBuilder(
              future: FirebaseService().getHeroImage(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const LinearProgressIndicator();
                }
                return GestureDetector(
                  onTap: ()async{
                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                    if(pickedImage?.path!=null) {
                      File file = File(pickedImage!.path);
                      Image image = Image.memory(await pickedImage.readAsBytes());
                      Uint8List img = await pickedImage.readAsBytes();
                      setState(() {

                      });
                      firebaseService.uploadImage(pickedImage.name, img)
                          .then((value){firebaseService.updateHeroImage(value);
                      setState(() {
                      });});
                    }
                  },
                  child: Card(
                    child: Image.network(snapshot.data!),
                  ),
                );
              }),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Featured", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          Row(
           children: [
             Expanded(
               child: FutureBuilder(
                   future: FirebaseService().getFeature1Product(),
                   builder: (builder, snapshot){
                     if(snapshot.hasError){
                       return const Center(child: Text("Error"),);
                     }
                     if(snapshot.connectionState==ConnectionState.waiting){
                       return const SizedBox();
                     }
                     return GestureDetector(
                       onTap: (){
                         showFtr1Modal();
                       },
                       child: Card(
                         child: Image.network(snapshot.data!.imageUrl),
                       ),
                     );
                   }),
             ),
             Expanded(
               child: FutureBuilder(
                   future: FirebaseService().getFeature2Product(),
                   builder: (builder, snapshot){
                     if(snapshot.hasError){
                       return const Center(child: Text("Error"),);
                     }
                     if(snapshot.connectionState==ConnectionState.waiting){
                       return const SizedBox();
                     }
                     return GestureDetector(
                       onTap: (){showFtr2Modal();},
                       child: Card(
                         child: Image.network(snapshot.data!.imageUrl),
                       ),
                     );
                   }),
             )
           ],
         ),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Exclusive Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          FutureBuilder(
              future: FirebaseService().getExclusiveCollectionText(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox();
                }
                _exclusiveTextController.text = snapshot.data!;
                return GestureDetector(
                  onTap: (){showExclusiveTextMenu();},
                  child: Card(
                    child: Padding(padding: const EdgeInsets.all(8.0),child: Text(snapshot.data!)),
                  ),
                );
              }),

          
          Row(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: FirebaseService().getExclusive1Product(),
                    builder: (builder, snapshot){
                      if(snapshot.hasError){
                        return const Center(child: Text("Error"),);
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: (){
                          showExc1Modal();
                        },
                        child: Card(
                          child: Image.network(snapshot.data!.imageUrl),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: FutureBuilder(
                    future: FirebaseService().getExclusive2Product(),
                    builder: (builder, snapshot){
                      if(snapshot.hasError){
                        return const Center(child: Text("Error"),);
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: (){showExc2Modal();},
                        child: Card(
                          child: Image.network(snapshot.data!.imageUrl),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: FutureBuilder(
                    future: FirebaseService().getExclusive3Product(),
                    builder: (builder, snapshot){
                      if(snapshot.hasError){
                        return const Center(child: Text("Error"),);
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: (){showExc3Modal();},
                        child: Card(
                          child: Image.network(snapshot.data!.imageUrl),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: FutureBuilder(
                    future: FirebaseService().getExclusive4Product(),
                    builder: (builder, snapshot){
                      if(snapshot.hasError){
                        return const Center(child: Text("Error"),);
                      }
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: (){showExc4Modal();},
                        child: Card(
                          child: Image.network(snapshot.data!.imageUrl),
                        ),
                      );
                    }),
              ),
            ],
          ),
          Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Customer Deals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
          FutureBuilder(
              future: FirebaseService().getCustomerDealsText(),
              builder: (builder, snapshot){
                if(snapshot.hasError){
                  return const Center(child: Text("Error"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox();
                }
                _customerDealsTextController.text = snapshot.data!;
                return GestureDetector(
                  onTap: (){showCustomerDealsTextMenu();},
                  child: Card(
                    child: Padding(padding: const EdgeInsets.all(8.0),child: Text(snapshot.data!)),
                  ),
                );
              })
        ],
      )
    );
  }



  showExclusiveTextMenu() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(controller: _exclusiveTextController, hintText: "Exclusive Collection Text", obscureText: false),
                const SizedBox(height: 8.0),
                TextButton.icon(onPressed: (){firebaseService.updateExcText(_exclusiveTextController.text); Navigator.pop(context);}, icon: const Icon(Icons.update), label: const Text("Update Exclusive Text"),)
              ],
            ),
          );
        });
  }

  showCustomerDealsTextMenu() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(controller: _customerDealsTextController, hintText: "Customer Deals Text", obscureText: false),
                const SizedBox(height: 8.0),
                TextButton.icon(onPressed: (){firebaseService.updateCustomerDeals(_customerDealsTextController.text); Navigator.pop(context);}, icon: const Icon(Icons.update), label: const Text("Update Customer Deals Text"),)
              ],
            ),
          );
        });
  }


  showFtr1Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(snapshot.data![index].productTitle)),
                                    TextButton(
                                        onPressed: (){firebaseService.updateFtr1(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                  ],),);}
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
                }});
        });
  }
  showFtr2Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(snapshot.data![index].productTitle)),
                                      TextButton(
                                          onPressed: (){firebaseService.updateFtr2(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                    ],),);}
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
                }});
        });
  }

  showExc1Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(snapshot.data![index].productTitle)),
                                      TextButton(
                                          onPressed: (){firebaseService.updateExc1(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                    ],),);}
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
                }});
        });
  }
  showExc2Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(snapshot.data![index].productTitle)),
                                      TextButton(
                                          onPressed: (){firebaseService.updateExc2(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                    ],),);}
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
                }});
        });
  }
  showExc3Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(snapshot.data![index].productTitle)),
                                      TextButton(
                                          onPressed: (){firebaseService.updateExc3(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                    ],),);}
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
                }});
        });
  }
  showExc4Modal() {
    showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return  StreamBuilder<List<ProductModel>>(
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
                                return Card(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(snapshot.data![index].productTitle)),
                                      TextButton(
                                          onPressed: (){firebaseService.updateExc4(snapshot.data![index]);
                                          Navigator.pop(context);
                                          updateState();
                                          }, child: const Text("Select"))
                                    ],),);}
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
                }});
        });
  }
}
