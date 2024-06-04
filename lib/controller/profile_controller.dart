import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/profile_model.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userProfileSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (userProfileSnapshot.exists) {
        Map<String, dynamic> userData = userProfileSnapshot.data()!;
        userProfile.value = UserProfile(
          uid: user.uid,
          email: userData['email'] ?? '',
          displayName: userData['displayName'] ?? '',
          photoURL: userData['photoURL'] ?? '',
        );
      }
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    File? image,
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? photoURL;
      if (image != null) {
        // Implement code to upload image to Firebase Storage
        // Example: photoURL = await uploadImageToFirebase(image);
      }
      await _firestore.collection('users').doc(user.uid).update({
        'displayName': name,
        'email': email,
        'photoURL': photoURL, // Update photoURL in Firestore
      });
      // Update the userProfile variable after the data is updated
      userProfile.value = UserProfile(
        uid: user.uid,
        email: email,
        displayName: name,
        photoURL: photoURL ?? userProfile.value!.photoURL,
      );
    }
  }
}
