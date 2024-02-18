import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_mads_admin_panel/widgets/adminBox.dart';


class DashBoard extends StatelessWidget {
  static const String id = "webdashboard";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DashBoard({super.key});

  Future<int> _getCollectionCount(String collectionName) async {
    QuerySnapshot snapshot = await _firestore.collectionGroup(collectionName).get();
    return snapshot.size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: FutureBuilder<int>(
                future: _getCollectionCount('posts'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int postCount = snapshot.data!;
                    return AdminBox(
                      title: 'Total Posts',
                      number: postCount.toDouble(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: FutureBuilder<int>(
                future: _getCollectionCount('groups'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int groupCount = snapshot.data!;
                    return AdminBox(
                      color: Colors.redAccent,
                      title: 'Groups',
                      number: groupCount.toDouble(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: FutureBuilder<int>(
                future: _getCollectionCount('users'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int userCount = snapshot.data!;
                    return AdminBox(
                      color: Colors.lightGreenAccent,
                      title: 'Users',
                      number: userCount.toDouble(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: FutureBuilder<int>(
                future: _getCollectionCount('cities'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    int cityCount = snapshot.data!;
                    return AdminBox(
                      color: Colors.lightBlueAccent,
                      title: 'Cities',
                      number: cityCount.toDouble(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
