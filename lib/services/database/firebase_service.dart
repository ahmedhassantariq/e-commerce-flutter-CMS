import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/model/productModel.dart';


class FirebaseService with ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProduct(ProductModel productModel)async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection("business").doc("products").collection(
        "featuredProducts").doc(productModel.productID).update({
      "UploadedBy": userID,
      "family": productModel.family,
      "price": productModel.price,
      "imageUrl": productModel.imageUrl,
      "productTitle": productModel.productTitle,
      "discount": productModel.discount,
      "size": productModel.size,
      "rating": productModel.rating,
      "quantity": productModel.quantity,
    });
    notifyListeners();
  }

  Future<void> deleteProduct(String productID) async {
      String userID = FirebaseAuth.instance.currentUser!.uid;
      await _firestore.collection("business").doc("products").collection(
          "featuredProducts")
          .doc(productID).delete();
      print(productID);
      notifyListeners();
  }




  Future<void> updateQuestionAnswer(String questionID,String question, String answer)async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection("business").doc("queries").collection(
        "frequentQuestions")
        .doc(questionID).update({
      "question": question,
      "answer": answer,

    });
    notifyListeners();
  }

  Future<void> deleteQuestionAnswer(String questionID) async {
    await _firestore.collection("business").doc("queries").collection(
        "frequentQuestions")
        .doc(questionID).delete();
    notifyListeners();
  }

  Future<void> deleteOrder(String orderID) async {
    await _firestore.collection("business").doc("orders").collection(
        "customerOrder")
        .doc(orderID).delete();
    notifyListeners();
  }

  Future<void> deleteEmail(String emailID) async {
    await _firestore.collection("business").doc("queries").collection(
        "emails")
        .doc(emailID).delete();
    notifyListeners();
  }

  Future<void> createQuestion(String question, String answer) async {
    String questionID = _firestore
        .collection("business")
        .doc("queries")
        .collection("frequentQuestions")
        .doc()
        .id;
    String userID = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection("business").doc("queries").collection(
        "frequentQuestions")
        .doc(questionID).set({
      "UploadedBy": userID,
      "UploadedOn": Timestamp.now(),
      "question": question,
      "answer": answer,
    });
    notifyListeners();
  }

  Stream<List<ProductModel>> getFeaturedPostData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = _firestore.collection('business').doc("products").collection("featuredProducts").snapshots();
    Stream<List<ProductModel>> model = stream.map((event) => event.docs.map((e) =>
        ProductModel.fromMap(e)).toList());
    return model;
  }

  Future<void> createProduct(ProductModel productModel) async {
    String productID = _firestore
        .collection("business")
        .doc("products")
        .collection("featuredProducts")
        .doc()
        .id;
    String userID = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection("business").doc("products").collection(
        "featuredProducts")
        .doc(productID).set({
      "UploadedBy": userID,
      "UploadedOn": Timestamp.now(),
      "family": productModel.family,
      "price": productModel.price,
      "imageUrl": productModel.imageUrl,
      "productTitle": productModel.productTitle,
      "discount": productModel.discount,
      "size": productModel.size,
      "rating": productModel.rating,
      "quantity": productModel.quantity,
      "productID": productID,
    });
  }


  Future<String>uploadImage(String pickedImageName, Uint8List img) async {
    final storageReference = FirebaseStorage.instance.ref(
        "images/${pickedImageName}");
    final TaskSnapshot task = await storageReference.putData(img);
    print(task.totalBytes);
    print(task.bytesTransferred);

    return await task.ref.getDownloadURL();
  }

  Future<void> updateHeroImage(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"heroImageUrl": url});
    notifyListeners();
  }
  Future<void> updateFtr1(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"featureImage1Url": url});
    notifyListeners();
  }
  Future<void> updateFtr2(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"featureImage2Url": url});
    notifyListeners();
  }
  Future<void> updateExc1(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"exclCollection1Url": url});
    notifyListeners();
  }
  Future<void> updateExc2(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"exclCollection2Url": url});
    notifyListeners();
  }
  Future<void> updateExc3(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"exclCollection3Url": url});
    notifyListeners();
  }
  Future<void> updateExc4(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"exclCollection4Url": url});
    notifyListeners();
  }

  Future<void> updateExcText(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"exclCollectionText": url});
    notifyListeners();
  }

  Future<void> updateCustomerDeals(String docID,String url)async {
    await _firestore.collection("business").doc("products").collection("allProducts").doc(docID).update({"customerDealsText": url});
    notifyListeners();
  }





  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userUID) async {
    DocumentSnapshot<Map<String, dynamic>> userCredentials = await _firestore
        .collection('reddit').doc('users').collection('user_credentials').doc(
        userUID).get();
    return userCredentials;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHomePostData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('products').collection('allProducts')
        .get().asStream();
    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEmails() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('queries').collection('emails')
        .get().asStream();
    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuestionData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('queries').collection('frequentQuestions')
        .get().asStream();
    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('orders').collection('customerOrder')
        .get().asStream();
    return data;
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> getCartData() {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    Stream<QuerySnapshot<Map<String, dynamic>>> data = _firestore.collection(
        'business').doc('users').collection(userID).doc('cart').collection(
        'cartData')
        .get().asStream();
    return data;
  }


}