import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    if (user != null) {
      print("User is signed in!");
      print("User display name: ${user?.displayName}");
    } else {
      print("No user is signed in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name = FirebaseAuth.instance.currentUser!.displayName;
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Hi! ${name ?? 'User'}", style: const TextStyle(fontSize: 17)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Get.off(() => const LoginView());
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Question'),
      ),
    );
  }
}
