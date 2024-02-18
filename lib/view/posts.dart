import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/posts_controller.dart';

class Posts extends StatelessWidget {
  static const String id = "posts";

  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      init: PostsController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (_) => controller.onSearchChanged(),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: controller.filteredPostsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = documents[index];
                          Map<String, dynamic> postData = document.data() as Map<String, dynamic>;
                          return Card(
                            child: ListTile(
                              leading: Image.network(postData['posterImage']),
                              title: Text(postData['post']),
                              subtitle: Text(postData['posterName']),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

