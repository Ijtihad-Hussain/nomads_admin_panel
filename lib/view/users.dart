import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class Users extends GetView<UsersController> {
  static const String id = "webusers";

  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) {
                controller.filterUsers(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final data = snapshot.data!;
                final users = data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                final filteredUsers = controller.filteredUsers.isNotEmpty ? controller.filteredUsers : users;

                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return Card(
                      child: ListTile(
                        title: Text(user['name']),
                        subtitle: Text(user['email']),
                        // trailing: Text(user['phone']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

