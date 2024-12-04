import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  final String? name;
  final String? price;
  final String? description;
  final String? picturePath;
  final String? categoryName;
  const AddItemPage({
    super.key,
    this.name,
    this.categoryName,
    this.description,
    this.picturePath,
    this.price,
  });

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController picturePathController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.name ?? '';
    priceController.text = widget.price ?? '';
    descriptionController.text = widget.description ?? '';
    picturePathController.text = widget.picturePath ?? '';
    categoryNameController.text = widget.categoryName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image != null
                    ? Image.file(image ?? File(''), height: 200)
                    : const Text('No image selected.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _selectImage,
                  child: const Text('Select Image'),
                ),
                20.heightBox,
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                // TextFormField(
                //   controller: picturePathController,
                //   decoration: const InputDecoration(labelText: 'Picture Path'),
                // ),
                // const SizedBox(height: 16.0),
                // TextFormField(
                //   controller: categoryNameController,
                //   decoration: const InputDecoration(labelText: 'Category Name'),
                // ),
                // const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    // Call function to submit data
                    if (widget.name.isNotEmptyAndNotNull) {
                      await updateData(
                        name: nameController.text,
                        categoryID: categoryNameController.text,
                        picturePath: picturePathController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                      );
                      debugPrint('Updated Data successfully');
                    } else {
                      // Upload image to Firebase Storage
                      if (image != null) {
                        String imageFileName =
                            '${DateTime.now().millisecondsSinceEpoch}.jpg';
                        Reference storageReference = FirebaseStorage.instance
                            .ref()
                            .child('product_images/$imageFileName');
                        UploadTask uploadTask =
                            storageReference.putFile(image ?? File(''));
                        TaskSnapshot storageTaskSnapshot = await uploadTask;
                        String downloadUrl =
                            await storageTaskSnapshot.ref.getDownloadURL();
                        await submitData(
                          name: nameController.text,
                          categoryID: categoryNameController.text,
                          picturePath: downloadUrl,
                          description: descriptionController.text,
                          price: double.parse(priceController.text),
                        );
                      } else {
                        Get.dialog(
                          AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            title: const Text('Alert'),
                            content: const Text('Please add a product image.'),
                            actions: [
                              MaterialButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Get.back();
                                  Get.focusScope?.unfocus();
                                },
                              )
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      }

                      debugPrint('Item Added successfully');
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ).pOnly(
              left: 30,
              right: 30,
            ),
          ),
        ),
      ),
    );
  }

  final CollectionReference adminDataCollection =
      FirebaseFirestore.instance.collection('AdminData');

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  submitData(
      {String? name,
      double? price,
      String? description,
      String? picturePath,
      String? categoryID}) async {
    await addItem(
      name: name ?? '',
      price: price ?? 0.0,
      description: description ?? '',
      picturePath: picturePath,
      category: categoryID ?? '',
    );
  }

  updateData(
      {String? name,
      double? price,
      String? description,
      String? picturePath,
      String? categoryID}) async {
    await updateItem(
      name: name ?? '',
      price: price ?? 0.0,
      description: description ?? '',
      picturePath: picturePath,
      category: categoryID ?? '',
    );
  }

  Future<void> updateItem({
    required String name,
    required String description,
    required double price,
    required String category,
    String? picturePath,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    final CollectionReference productCollection = mainCollection
        .doc(category)
        .collection(category.toLowerCase() == 'beverages'
            ? 'coldDrinks'
            : category.toLowerCase() == 'featuredproducts'
                ? 'featured'
                : category.toLowerCase() == 'nonvegetarian'
                    ? 'nonveg'
                    : category.toLowerCase() == 'vegetarian'
                        ? 'veg'
                        : '');
    QuerySnapshot querySnapShot =
        await productCollection.where('name', isEqualTo: widget.name).get();

    if (querySnapShot.docs.isNotEmpty) {
      var doc = querySnapShot.docs[0];
      String productId = doc.id;
      Map<String, dynamic> productData = <String, dynamic>{
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "picturePath": picturePath,
      };

      try {
        await productCollection.doc(productId).update(productData);
        debugPrint('Updated Data Successfully');
        Get.back();
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> addItem({
    required String name,
    required String description,
    required double price,
    required String category,
    String? picturePath,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference collectionReference = mainCollection
        .doc(category)
        .collection(category.toLowerCase() == 'beverages'
            ? 'coldDrinks'
            : category.toLowerCase() == 'featuredproducts'
                ? 'featured'
                : category.toLowerCase() == 'nonvegetarian'
                    ? 'nonveg'
                    : category.toLowerCase() == 'vegetarian'
                        ? 'veg'
                        : '');

    String productId = collectionReference.doc().id;

    DocumentReference productDocRef = collectionReference.doc(productId);

    Map<String, dynamic> productData = <String, dynamic>{
      "name": name,
      "description": description,
      "price": price,
      "category": category,
      "picturePath": picturePath,
    };

    try {
      await productDocRef.set(productData);
      Get.back();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
