
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  late Stream<QuerySnapshot> postsStream;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(onSearchChanged);
    postsStream = FirebaseFirestore.instance.collection('posts').snapshots();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchChanged() {
    searchQuery.value = searchController.text.toLowerCase();
  }

  Stream<QuerySnapshot> filteredPostsStream() {
    if (searchQuery.isEmpty) {
      return postsStream;
    } else {
      return FirebaseFirestore.instance.collection('posts').where('post', isGreaterThanOrEqualTo: searchQuery.value).snapshots();
    }
  }
}
