import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_rental/views/subviews/analyze.dart';
import 'package:room_rental/views/subviews/booking.dart';
import 'package:room_rental/views/subviews/inventory.dart';
import 'package:room_rental/views/subviews/maintenance.dart';
import 'package:room_rental/views/subviews/payment.dart';
import 'package:room_rental/views/subviews/room.dart';

import '../controller/state.dart';
import 'login.dart';
import 'subviews/map.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final StateController stateController = Get.put(StateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: GetBuilder<StateController>(
          builder: (stateController) => Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome! ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("👋 ${stateController.userName ?? 'User'}",
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.blue[300],
                ),
                onPressed: () => Get.off(() => const LoginView()),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            IncomeWidget(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text("See All",
                        style: TextStyle(color: Colors.blue, fontSize: 16)))
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1, // Ensure no spacing between items
                      children: [
                        PageCard(
                          title: 'Room',
                          page: const RoomView(),
                          iconColor: Colors.purple[300]!,
                        ),
                        PageCard(
                          title: 'Booking',
                          page: const BookingView(),
                          iconColor: Colors.amber[300]!,
                        ),
                        PageCard(
                          title: 'Payment',
                          page: const PaymentView(),
                          iconColor: Colors.green[300]!,
                        ),
                        PageCard(
                          title: 'Maintenance',
                          page: const MaintenanceView(),
                          iconColor: Colors.orange[300]!,
                        ),
                        PageCard(
                          title: 'Inventory',
                          page: const InventoryView(),
                          iconColor: Colors.red[300]!,
                        ),
                        PageCard(
                          title: 'Analyze',
                          page: const AnalyzeView(),
                          iconColor: Colors.blue[300]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeWidget extends StatelessWidget {
  final StateController stateController = Get.find();

  IncomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: <Color>[Colors.blue[200]!, Colors.blue[300]!]),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
                  children: [
                    Text(
                      "\$${stateController.totalCost.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.electric_bolt_outlined,
                        color: Colors.amber,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "1500៛",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.water_drop,
                        color: Colors.blue,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "800៛",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final String title;
  final Widget page;
  final Color iconColor;

  const PageCard({
    Key? key,
    required this.title,
    required this.page,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => page),
      child: Card(
        shadowColor: Colors.black38,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(getIconForTitle(title), size: 35, color: iconColor),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                  fontSize: 13,
                )),
          ],
        ),
      ),
    );
  }

  IconData getIconForTitle(String title) {
    switch (title) {
      case 'Room':
        return Icons.meeting_room;
      case 'Booking':
        return Icons.book_online;
      case 'Payment':
        return Icons.payment;
      case 'Maintenance':
        return Icons.build;
      case 'Inventory':
        return Icons.inventory;
      case 'Analyze':
        return Icons.analytics;
      default:
        return Icons.help_outline;
    }
  }
}
