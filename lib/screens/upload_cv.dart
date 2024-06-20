import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';
import '../utils/size_config.dart';
import 'dialogs/dialo_builder.dart';

class UploadCv extends StatefulWidget {
  const UploadCv({super.key});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

class _UploadCvState extends State<UploadCv> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Upload Player Cv',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: SizeConfig.textMultiplier * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Full Name:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: fullNameController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Email:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: emailController,
                          cursorColor: Colors.grey[400],
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Nationality:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: nationalityController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Age:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: ageController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Position:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: positionController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _image == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Image Name: ${_image!.path.split('/').last}',
                                ),
                              ),
                            ),
                          ),
                        ),
                  Center(
                    child: Container(
                      width: SizeConfig.widthMultiplier * 38,
                      height: SizeConfig.heightMultiplier * 4.3,
                      decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Center(
                          child: Text(
                            'Upload picture',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Center(
                    child: Container(
                      width: SizeConfig.widthMultiplier * 70,
                      height: SizeConfig.heightMultiplier * 4.8,
                      decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          submitCv();
                        },
                        child: Center(
                          child: Text(
                            'Submit Cv',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // Displaying the image name in the console
        print('Image selected: ${pickedFile.path}');
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> submitCv() async {
    print("Image: ${_image}");
    if (fullNameController.text.trim() == '' ||
        emailController.text.trim() == '' ||
        nationalityController.text.trim() == '' ||
        ageController.text.trim() == '' ||
        positionController.text.trim() == '' ||
        _image == null) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.only(left: 8, right: 8),
        borderRadius: BorderRadius.circular(10),
        duration: const Duration(seconds: 2),
        messageText: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Please fill all details",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ).show(context);
    } else {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child('players/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');

      try {
        DialogBuilder(context).showLoadingIndicator('Posting..');
        String fileName = _image!.path.split('/').last;
        Reference storageReference = FirebaseStorage.instance.ref().child('players/$fileName');
        UploadTask uploadTask = storageReference.putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('players').add({
            'fullName': fullNameController.text,
            'userId': user.uid,
            'email': emailController.text,
            'nationality': nationalityController.text,
            'age': ageController.text,
            'position': positionController.text,
            'picture': imageUrl,
            'timestamp': FieldValue.serverTimestamp(),
          });
          DialogBuilder(context).hideOpenDialog();
          Navigator.pop(context);
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
            margin: const EdgeInsets.only(left: 8, right: 8),
            borderRadius: BorderRadius.circular(10),
            duration: const Duration(seconds: 5),
            messageText: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Cv uploaded Successfully",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).show(context);
        } else {
          DialogBuilder(context).hideOpenDialog();
          // Handle user not signed in
        }
      } catch (e) {
        DialogBuilder(context).hideOpenDialog();
        print("Error on uploading Cv $e");
      }
    }
  }
}
