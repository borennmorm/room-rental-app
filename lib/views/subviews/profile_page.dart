import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/profile_controller.dart';
import '../../model/profile_model.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController _profileController = Get.put(ProfileController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    _profileController.fetchUserProfile(); // Fetch user profile data
  }

  void _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Implement code to upload image to Firebase Storage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (_profileController.userProfile.value == null) {
                // If userProfile is null, show a loading indicator
                return const Center(child: CircularProgressIndicator());
              } else {
                UserProfile userProfile = _profileController.userProfile.value!;
                _nameController.text = userProfile.displayName;
                _emailController.text = userProfile.email;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : userProfile.photoURL.isNotEmpty
                                    ? NetworkImage(userProfile.photoURL)
                                    : null,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: _uploadImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement functionality to update profile
                          _profileController.updateProfile(
                            name: _nameController.text,
                            email: _emailController.text,
                          );
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
