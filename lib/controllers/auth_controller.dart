import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_app/views/home_screen.dart';

class AuthController extends GetxController {
  /// register controller
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAllNamed('/home');
      }
    });
    super.onInit();
  }

  /// login controller
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  File? profile;
  void picImage() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage == null) {
      return;
    }
    profile = File(pickImage.path);
    update();
  }

  void register(String email, String password, String username) async {
    try {
      EasyLoading.show(status: 'loading...');
      Map<String, String> data = {'username': username, 'email': email};
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(data);

      /// upload image to firebase storage
      if (profile != null) {
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('users')
            .child(FirebaseAuth.instance.currentUser!.uid);
        final uploadTask = reference.putFile(profile!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageURL = await taskSnapshot.ref.getDownloadURL();
        if (kDebugMode) {
          print('uploaded ${imageURL}');
        }
      }
      Get.snackbar("Account Created ", "Your account created",
          colorText: Colors.white, backgroundColor: Colors.green);
      clearTextField();
      EasyLoading.dismiss();

      Timer(const Duration(seconds: 1), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        "Register Account Error Occurred",
        e.toString(),
      );
    }
  }

  void clearTextField() {
    usernameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    profile = null;
    update();
  }

  /// login user
  void login() async {
    try {
      if (emailLoginController.text.isEmpty ||
          passwordLoginController.text.isEmpty) {
        Get.snackbar("Message", "Please enter all fills",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLoginController.text,
          password: passwordLoginController.text);
      Get.snackbar("Message", "Login Successfully");

      Get.offAll(const HomeScreen());
    } catch (e) {
      Get.snackbar(
        "Error Occurred",
        e.toString(),
      );
    }

    ///
  }
}
