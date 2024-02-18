
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/spaces_controller.dart';
import '../models/space.dart';

class Spaces extends GetView<SpacesController> {
  static const String id = "webspaces";

  const Spaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<fs.QuerySnapshot>(
              stream: fs.FirebaseFirestore.instance
                  .collection('spaces')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final data = snapshot.data!;
                controller.spaces.value =
                    data.docs.map((doc) => Space.fromSnapshot(doc)).toList();
                final spaces = controller.filteredSpaces.isNotEmpty
                    ? controller.filteredSpaces
                    : controller.spaces;

                return ListView.builder(
                  itemCount: spaces.length,
                  itemBuilder: (context, index) {
                    final space = spaces[index];
                    return Card(
                      child: ListTile(
                        title: Text(space.name),
                        subtitle: Text(space.address),
                        trailing: Text(space.phone),
                        onTap: () async {
                          // Your onTap logic here
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Your onPressed logic here
              },
              child: const Text('Add Space'),
            ),
          ),
        ],
      ),
    );
  }
}

