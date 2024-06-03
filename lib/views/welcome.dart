import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_rental/views/register.dart';
import '../components/button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF94D5FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Image.asset(
                "assets/images/room_rental.gif",
                width: 300,
              ),
              const SizedBox(height: 20),
              const Text(
                "Room Rental",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Simplify your rental management.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Button
              CustomButton(
                text: "Get Started",
                backgroundColor: Colors.blue[50],
                onPressed: () {
                  Get.off(() => const RegisterView());
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
