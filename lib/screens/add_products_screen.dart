import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/dress_model.dart';
import '../providers/dress_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController starRatingController = TextEditingController();
  final TextEditingController reviewCountController = TextEditingController();
  final TextEditingController offerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  String? selectedSize;

  List<String> sizes = ['S', 'M', 'L'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;
  changeStatus(value) {
    context.read<DressProvider>().imageSelectFun(value);
  }

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      changeStatus(true);
    }
    print(image!.path.toString());
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    changeStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var provider = Provider.of<DressProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              !provider.getImageIsSelected
                  ? Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 30, top: 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Image',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [5],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: selectImage,
                              child: Container(
                                height: 100.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.cloud_upload,
                                    size: 50.0,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              selectImage();
                              // File picker logic
                            },
                            child: const Text(
                              'Select file',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Image.file(
                            File(image!.path.toString()),
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              _buildContainer(
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  controller: brandController,
                  decoration: const InputDecoration(
                    hintText: 'Brand',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Brand';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  controller: starRatingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Star Rating',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Star rating';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  controller: reviewCountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Review Count',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Review Count';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: offerController,
                  decoration: const InputDecoration(
                    hintText: 'Offer',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Offer';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Description';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedSize,
                  onChanged: (newValue) {
                    setState(() {
                      selectedSize = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Sizes',
                    border: InputBorder.none,
                  ),
                  items: sizes.map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Size';
                    }
                    return null;
                  },
                ),
              ),
              _buildContainer(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: const InputDecoration(
                    hintText: 'Price',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Price';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: SizedBox(
                    height: 50,
                    width: width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        // Save button logic
                        if (formKey.currentState!.validate() && image != null) {
                          // Form is valid, submit the data
                          print("success");
                          Dress dress = Dress(
                              name: nameController.text,
                              brand: brandController.text,
                              starRating:
                                  double.parse(starRatingController.text),
                              reviewCount:
                                  double.parse(reviewCountController.text)
                                      .round(),
                              offer: offerController.text,
                              description: descriptionController.text,
                              sizes: sizes,
                              price: double.parse(priceController.text),
                              imageUrl: image!.path);
                          context.read<DressProvider>().addDress(dress);
                          changeStatus(false);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 18),
      child: Container(
        height: 50,
        width: width * 0.44,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(child: child),
      ),
    );
  }
}

Widget _buildFilePicker(VoidCallback onTap) {
  return Container(
    height: 200,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        const Text(
          'Image',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Center(
            child: Icon(Icons.cloud_upload, size: 50.0),
          ),
        ),
        TextButton(
          onPressed: () {
            // File picker logic
          },
          child: const Text('Select file'),
        ),
      ],
    ),
  );
}
