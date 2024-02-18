import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:universal_html/html.dart' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/city.dart';

class CitiesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final isLoading = true.obs;
  final hasError = false.obs;
  var cities = <City>[].obs;
  var filteredCities = <City>[].obs;
  html.File? imageFile;

  @override
  void onInit() {
    super.onInit();
    // searchController.addListener();
    fetchCities();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchChanged(String query) {
    query = searchController.text.toLowerCase();
    filteredCities.value = cities.where((city) {
      final name = city.name.toLowerCase();
      return name.contains(query);
    }).toList();
    return null;
  }

  void fetchCities() async {
    try {
      isLoading(true);
      final fs.QuerySnapshot snapshot = await fs.FirebaseFirestore.instance.collection('cities').get();
      cities.value = snapshot.docs.map((doc) => City.fromSnapshot(doc)).toList();
    } catch (e) {
      hasError(true);
      if (kDebugMode) {
        print('Error fetching cities: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  void editCity(BuildContext context, City city) {

  }

  void addCity(BuildContext context) {
    // Implement add functionality here
  }

  void handleImagePick(html.FileList? files) {
    if (files != null) {
      final file = files[0];
      imageFile = file;
    }
  }

  Future<String> uploadImage(html.File imageFile, String fileName) async {
    try {
      final storageReference = firebase_storage.FirebaseStorage.instance.ref(fileName);
      final uploadTask = storageReference.putBlob(imageFile);

      final firebase_storage.TaskSnapshot snapshot = await uploadTask;
      if (snapshot.state == firebase_storage.TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        if (kDebugMode) {
          print('Error from image repo ${snapshot.state}');
        }
        throw Exception('Failed to upload image');
      }
    } on firebase_storage.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return '';
    }
  }
}
