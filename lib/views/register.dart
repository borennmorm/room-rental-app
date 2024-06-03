import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_rental/views/login.dart';

import '../components/button.dart';
import '../components/textfield.dart';
import '../controller/error_handler.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _fullNameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    try {
      // Check if any of the fields are empty
      if (_fullNameController.text.trim().isEmpty ||
          _emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        // Show a SnackBar indicating that all fields are required
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('All fields are required.'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));
        return;
      }

      // Attempt to create a new user with Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Set the displayName for the user
      await userCredential.user!
          .updateDisplayName(_fullNameController.text.trim());

      // If successful, save user details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
      });

      // Show a SnackBar indicating successful registration
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Registration successful.'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));

      // Navigate back to login view
      Navigator.pop(context);
    } catch (e) {
      // Show a SnackBar indicating error during registration
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Error registering. Please check your details.'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // full name
            CustomTextField(
              label: "Full Name",
              keyboardType: TextInputType.name,
              controller: _fullNameController,
            ),
            const SizedBox(
              height: 15,
            ),
            // email address
            CustomTextField(
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            // password
            CustomTextField(
              label: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 15,
            ),
            // register button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Register",
                backgroundColor: Colors.blue[400],
                textColor: Colors.white,
                onPressed: _register,
              ),
            ),
            const Spacer(),
            // already have an account?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const LoginView());
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
