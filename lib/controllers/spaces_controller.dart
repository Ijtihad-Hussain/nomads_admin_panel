import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import 'package:get/get.dart';

import '../models/space.dart';

class SpacesController extends GetxController {
  var searchController = TextEditingController();
  var spaces = <Space>[].obs;
  var filteredSpaces = <Space>[].obs;
  var imageFile;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    filteredSpaces.value = spaces.where((space) {
      final name = space.name.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  void handleImagePick(html.FileList? files) {
    if (files != null) {
      imageFile = files.first;
    }
  }

  Future<String> uploadImage(html.File imageFile, String fileName) async {
    try {
      final storageReference =
      firebase_storage.FirebaseStorage.instance.ref(fileName);
      final uploadTask = storageReference.putBlob(imageFile);

      final firebase_storage.TaskSnapshot snapshot = await uploadTask;
      if (snapshot.state == firebase_storage.TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print('Error from image repo ${snapshot.state}');
        throw Exception('Failed to upload image');
      }
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
      return '';
    }
  }
}
