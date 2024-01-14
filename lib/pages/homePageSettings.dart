import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../components/heroImage.dart';
import '../components/textField.dart';
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


  changeHeroImage(String docID,String url) {
    firebaseService.updateHeroImage(docID,url);
  }
  changeFtr1(String docID,String url) {
    firebaseService.updateFtr1(docID,url);
  }
  changeFtr2(String docID,String url) {
    firebaseService.updateFtr2(docID,url);
  }

  changeExcl1(String docID,String url) {
    firebaseService.updateExc1(docID,url);
  }
  changeExcl2(String docID,String url) {
    firebaseService.updateExc2(docID,url);
  }
  changeExcl3(String docID,String url) {
    firebaseService.updateExc3(docID,url);
  }
  changeExcl4(String docID,String url) {
    firebaseService.updateExc4(docID,url);
  }

  updateCustomerDealsText(String docID,String url) {
    firebaseService.updateCustomerDeals(docID,url);
  }
  updateExclusiveText(String docID,String url) {
    firebaseService.updateExcText(docID,_exclusiveTextController.text);
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firebaseService.getHomePostData(),
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
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: ()async{
                                  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                  if(pickedImage?.path!=null) {
                                    File file = File(pickedImage!.path);
                                    Image image = Image.memory(await pickedImage.readAsBytes());
                                    Uint8List img = await pickedImage.readAsBytes();
                                    setState(() {

                                    });
                                    firebaseService.uploadImage(pickedImage.name, img)
                                        .then((value){changeHeroImage(snapshot.data!.docs[0].id, (value));
                                    setState(() {
                                    });});
                                  }
                                },
                                  child: HeroImage(url: snapshot.data!.docs[0].get('heroImageUrl'),)),
                              Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Featured", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {
                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeFtr1(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('featureImage1Url'),
                                      width: featureImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0,),
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {

                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeFtr2(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('featureImage2Url'),
                                      width: featureImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ],),
                              Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Exclusive Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                              GestureDetector(
                                onTap: (){
                                  showExclusiveTextMenu(snapshot.data!.docs[0].id, snapshot.data!.docs[0].get('exclCollectionText'));
                                },
                                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(snapshot.data!.docs[0].get('exclCollectionText'),style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600)))),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {

                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeExcl1(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('exclCollection1Url'),
                                      width: exclusiveImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0,),
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {

                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeExcl2(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('exclCollection2Url'),
                                      width: exclusiveImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0,),
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {

                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeExcl3(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('exclCollection3Url'),
                                      width: exclusiveImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0,),
                                GestureDetector(
                                  onTap: ()async{
                                    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                                    if(pickedImage?.path!=null) {
                                      File file = File(pickedImage!.path);
                                      Image image = Image.memory(await pickedImage.readAsBytes());
                                      Uint8List img = await pickedImage.readAsBytes();
                                      setState(() {

                                      });
                                      firebaseService.uploadImage(pickedImage.name, img)
                                          .then((value){changeExcl4(snapshot.data!.docs[0].id, (value));
                                      setState(() {
                                      });});
                                    }
                                  },
                                  child: Card(
                                    child: Image.network(
                                      snapshot.data!.docs[0].get('exclCollection4Url'),
                                      width: exclusiveImageWidth,
                                      fit: BoxFit.fitWidth,
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ],),
                              Align(alignment: Alignment.center, child: Padding(padding: const EdgeInsets.all(8.0),child: Text("Customer Deals", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: HexColor("#38C1CE"))))),
                              GestureDetector(
                                  onTap: (){
                                    showCustomerDealsTextMenu(snapshot.data!.docs[0].id, snapshot.data!.docs[0].get('customerDealsText'));
                                  },
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text(snapshot.data!.docs[0].get('customerDealsText'), style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600)))),
                            ],
                          );
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



  showExclusiveTextMenu(String docID, String text) {
    _exclusiveTextController.text = text;
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
                TextButton.icon(onPressed: (){updateExclusiveText(docID, _exclusiveTextController.text); Navigator.pop(context);}, icon: const Icon(Icons.update), label: const Text("Update Exclusive Text"),)
              ],
            ),
          );
        });
  }

  showCustomerDealsTextMenu(String docID, String text) {
    _customerDealsTextController.text = text;
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
                TextButton.icon(onPressed: (){updateCustomerDealsText(docID, _customerDealsTextController.text); Navigator.pop(context);}, icon: const Icon(Icons.update), label: const Text("Update Customer Deals Text"),)
              ],
            ),
          );
        });
  }
}
