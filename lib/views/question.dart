import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/button.dart';
import '../components/textfield.dart';
import '../controller/state.dart';
import 'home.dart';
import 'login.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  late TextEditingController _roomQuantity;
  late TextEditingController _roomCost;
  late TextEditingController _electricityCost;
  late TextEditingController _waterCost;

  final StateController stateController = Get.put(StateController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user;

  @override
  void initState() {
    super.initState();
    _roomQuantity = TextEditingController();
    _roomCost = TextEditingController();
    _electricityCost = TextEditingController();
    _waterCost = TextEditingController();
    user = auth.currentUser;
    if (user != null) {
      print("User is signed in!");
      print("User display name: ${user?.displayName}");
    } else {
      print("No user is signed in.");
    }
  }

  @override
  void dispose() {
    _roomQuantity.dispose();
    _roomCost.dispose();
    _electricityCost.dispose();
    _waterCost.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_roomQuantity.text.isEmpty ||
        _roomCost.text.isEmpty ||
        _electricityCost.text.isEmpty ||
        _waterCost.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields must be filled",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.off(() => HomeView());
    }
  }

  @override
  Widget build(BuildContext context) {
    String? name = FirebaseAuth.instance.currentUser!.displayName;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text("Hi! ${name ?? 'User'}",
              style: const TextStyle(fontSize: 18)),
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
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // room quantity
                CustomTextField(
                  controller: _roomQuantity,
                  label: 'Room Quantity',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    stateController.roomQuality.value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // room cost per month
                CustomTextField(
                  controller: _roomCost,
                  label: 'Room Cost',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    stateController.roomCost.value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // room cost per month
                CustomTextField(
                  controller: _electricityCost,
                  label: 'Electricity Cost',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    stateController.electricityCost.value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // room cost per month
                CustomTextField(
                  controller: _waterCost,
                  label: 'Water Cost',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    stateController.waterCost.value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // submit button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Submit",
                    backgroundColor: Colors.blue[400],
                    textColor: Colors.white,
                    onPressed: _handleSubmit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
