import 'package:flutter/material.dart';
import 'package:tiktok_app/views/login_screen.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignupScreen extends GetView<AuthController> {
  SignupScreen({Key? key}) : super(key: key);

  final _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Tiktok',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GetBuilder(
                        init: AuthController(),
                        builder: (state) {
                          if (controller.profile == null) {
                            return const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  'https://d2v9ipibika81v.cloudfront.net/uploads/sites/210/Profile-Icon.png'),
                            );
                          } else {
                            return CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: FileImage(controller.profile!),
                            );
                          }
                        },
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {
                              controller.picImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 20,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  children: [
                    TextField(
                      controller: _authController.usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        // fillColor: Colors.white,
                        // focusColor: Colors.white,
                        // hoverColor: Colors.white,
                        labelText: "Username",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextField(
                        controller: _authController.emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // fillColor: Colors.white,
                          // focusColor: Colors.white,
                          // hoverColor: Colors.white,
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: TextField(
                        controller: _authController.passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.register(
                            _authController.emailController.text,
                            _authController.passwordController.text,
                            _authController.usernameController.text);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(const LoginScreen());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
