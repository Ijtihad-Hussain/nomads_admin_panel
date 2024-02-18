import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/group.dart';

class GroupsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final fs.FirebaseFirestore _firestore = fs.FirebaseFirestore.instance;
  List<Group> groups = [];
  List<Group> filteredGroups = [];
  html.File? imageFile;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    final filteredGroups = groups.where((group) {
      final name = group.name.toLowerCase();
      return name.contains(query);
    }).toList();
    this.filteredGroups = filteredGroups;
    update();
  }

  Future<int> getCollectionCount(String collectionName) async {
    fs.QuerySnapshot snapshot = await _firestore.collectionGroup(collectionName).get();
    return snapshot.size;
  }

  void handleImagePick(html.FileList? files) {
    if (files != null) {
      final file = files[0];
      imageFile = file;
      update();
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