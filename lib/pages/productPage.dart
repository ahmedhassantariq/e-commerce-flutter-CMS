import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/components/textField.dart';
import 'package:flutter_business_manager/model/productModel.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget {
  final ProductModel productModel;
  final Function() updateState;
  const ProductPage({
    required this.updateState,
    required this.productModel,
    super.key
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {
  late FirebaseService firebaseService;
  final TextEditingController _productTitle = TextEditingController();
  final TextEditingController _productFamily = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _productTitle.text = widget.productModel.productTitle;
    _productFamily.text = widget.productModel.productTitle;
    _size.text = widget.productModel.size;
    _price.text = widget.productModel.price.toString();
    _rating.text = widget.productModel.rating.toString();
    _quantity.text = widget.productModel.quantity.toString();
    _discount.text = widget.productModel.discount.toString();
    _imageUrl.text = widget.productModel.imageUrl;

    super.initState();
  }

  updateProduct(){
    firebaseService.updateProduct(
        ProductModel(
            productID: widget.productModel.productID,
            productTitle: _productTitle.text,
            family: _productFamily.text,
            size: _size.text,
            rating: int.parse(_rating.text) ,
            quantity: int.parse(_quantity.text),
            price: int.parse(_price.text),
            discount: int.parse(_discount.text),
            imageUrl: _imageUrl.text
        )).then((value){isExpansion = false;widget.updateState;});


  }
  deleteProduct(){
    firebaseService.deleteProduct(widget.productModel.productID);
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
                Text(widget.productModel.productTitle),
              ],
            );
          },
          body: ListTile(
            title: Column(
              children: [
                Image.network(widget.productModel.imageUrl),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _productTitle, hintText: 'Title', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _productFamily, hintText: 'Description', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _size, hintText: 'Category', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _price, hintText: 'Price', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _discount, hintText: 'Discount', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _quantity, hintText: 'Quantity', obscureText: false,),
                const SizedBox(height: 8.0),
                CustomTextField(controller: _rating, hintText: 'Rating', obscureText: false,),
                const SizedBox(height: 8.0),
                TextButton(onPressed: (){updateProduct();}, child: const Text("Update Product")),
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
                    widget.productModel.imageUrl = value;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Updated")));
                    setState(() {
                    });});
                  }
                }, child: Text("Change Image")),
                IconButton(onPressed: (){deleteProduct();}, icon: const Icon(Icons.delete))
              ],
            ),
          ),
          isExpanded: isExpansion,
      )]
    ),
    );
  }
}




