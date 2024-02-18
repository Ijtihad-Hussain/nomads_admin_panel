
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var filteredUsers = <Map<String, dynamic>>[].obs;
  var searchController = TextEditingController();

  void filterUsers(String query) async {
    final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersRef
        .where('name', isGreaterThanOrEqualTo: query)
        .where('email', isGreaterThanOrEqualTo: query)
        .where('phone', isGreaterThanOrEqualTo: query)
        .get();

    filteredUsers.value =
        querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
