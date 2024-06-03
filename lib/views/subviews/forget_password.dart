import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_rental/views/login.dart';

import '../../components/button.dart';
import '../../components/textfield.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email sent successfully'),
        ),
      );
      Get.off(() => const LoginView()); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email not sent'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Enter your email address ',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Reset Password",
                backgroundColor: Colors.blue[400],
                textColor: Colors.white,
                onPressed: () {
                  sendPasswordResetLink(_emailController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
