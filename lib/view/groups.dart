import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

import '../controllers/groups_controller.dart';
import '../models/group.dart';

import 'package:get/get.dart';

class Groups extends StatelessWidget {
  static const String id = "webgroups";
  final GroupsController controller = Get.put(GroupsController());

  Groups({super.key});

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
              stream: fs.FirebaseFirestore.instance.collection('groups').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<fs.QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final data = snapshot.data!;
                controller.groups = data.docs.map((doc) => Group.fromSnapshot(doc)).toList();
                final groups = controller.filteredGroups.isNotEmpty ? controller.filteredGroups : controller.groups;

                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return Card(
                      child: ListTile(
                        title: Text(group.name),
                        subtitle: Text(group.admin),
                        trailing: Text('${group.numberOfMembers}'),
                        onTap: () async {
                          TextEditingController nameController = TextEditingController(text: group.name);
                          TextEditingController adminController = TextEditingController(text: group.admin);

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Group'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Group Name',
                                        ),
                                      ),
                                      TextField(
                                        controller: adminController,
                                        decoration: const InputDecoration(
                                          labelText: 'Admin Name',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Save Changes'),
                                    onPressed: () async {
                                      final collectionReference = fs.FirebaseFirestore.instance.collection('groups');
                                      try {
                                        await collectionReference.doc(group.groupId).update({
                                          'name': nameController.text,
                                          'admin': adminController.text,
                                        });

                                        Navigator.of(context).pop();

                                        if (kDebugMode) {
                                          print('Updated a group');
                                        }
                                      } catch (e) {
                                        if (kDebugMode) {
                                          print('Failed to update group: $e');
                                        }
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String name = '';
                    String admin = '';
                    double numberOfMembers = 0;

                    return AlertDialog(
                      title: const Text('Add Group'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Group Name',
                              ),
                              onChanged: (value) {
                                name = value;
                              },
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Admin Name',
                              ),
                              onChanged: (value) {
                                admin = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Add'),
                          onPressed: () async {
                            // Add group to Firestore
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Add Group'),
            ),
          ),
        ],
      ),
    );
  }
}
