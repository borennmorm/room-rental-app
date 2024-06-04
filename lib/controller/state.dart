import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StateController extends GetxController {
  FirebaseAuth? _auth;

  FirebaseAuth get auth {
    _auth ??= FirebaseAuth.instance;
    return _auth!;
  }

  Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);

  String? get userName => user.value?.displayName;

  Future<void> signOut() async {
    await auth.signOut();
  }

  // Variables to store input values
  var roomQuality = 0.obs;
  var roomCost = 0.0.obs;
  var electricityCost = 0.0.obs;
  var waterCost = 0.0.obs;

  // Computed property for the total rental cost
  double get totalCost =>
      roomCost.value + electricityCost.value + waterCost.value;

  // Update methods for each variable
  void updateRoomQuality(int value) {
    roomQuality.value = value;
  }

  void updateRoomCost(double value) {
    roomCost.value = value;
  }

  void updateElectricityCost(double value) {
    electricityCost.value = value;
  }

  void updateWaterCost(double value) {
    waterCost.value = value;
  }
}
