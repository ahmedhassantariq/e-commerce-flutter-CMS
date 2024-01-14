import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:flutter_business_manager/model/productModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/database/firebase_service.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  late FirebaseService firebaseService;
  final TextEditingController _productTitle = TextEditingController();
  final TextEditingController _family = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();
  final ImagePicker picker = ImagePicker();

  postProduct(){
    if(
    _productTitle.text.isNotEmpty&&
    _family.text.isNotEmpty&&
    _size.text.isNotEmpty&&
    _price.text.isNotEmpty&&
    _rating.text.isNotEmpty&&
    _quantity.text.isNotEmpty&&
    _discount.text.isNotEmpty&&
    _imageUrl.text.isNotEmpty
    ){
      firebaseService.createProduct(
        ProductModel(
          productID: "",
          productTitle: _productTitle.text,
          family: _family.text,
          size: _size.text,
          rating: int.parse(_rating.text),
          quantity: int.parse(_quantity.text),
          price: int.parse(_discount.text),
          discount: int.parse(_discount.text),
          imageUrl: _imageUrl.text,
      )
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Created")));
        Navigator.pop(context);
      });
      }

  }


  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(controller: _productTitle, hintText: "Title", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _family, hintText: "Family", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _size, hintText: "Size", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _price, hintText: "Price", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _discount, hintText: "Discount", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _quantity, hintText: "Quantity", obscureText: false),
          const SizedBox(height: 8.0),
          CustomTextField(controller: _rating, hintText: "Rating", obscureText: false),
          const SizedBox(height: 8.0),
          TextButton(onPressed: () async{
            final pickedImage = await picker.pickImage(source: ImageSource.gallery);
            if(pickedImage?.path!=null) {
              File file = File(pickedImage!.path);
              Image image = Image.memory(await pickedImage.readAsBytes());
            Uint8List img = await pickedImage.readAsBytes();
            setState(() {

            });
            firebaseService.uploadImage(pickedImage.name, img)
                .then((value){ _imageUrl.text = (value);
            setState(() {
            });});
          }
          }, child: Text("Upload Image")),
          TextButton.icon(onPressed: (){postProduct();}, icon: const Icon(Icons.post_add), label: const Text("Post Product"),)
        ],
      ),
    );
  }
}
