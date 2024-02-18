import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/UserQueriesController.dart';

class ManageUserQueriesPage extends StatelessWidget {
  static const String id = "UserQueries";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserQueriesController>(
        init: UserQueriesController(),
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.queries.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Text(
                  controller.queries[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    controller.toggleExpandedStatus(index);
                  },
                  child: Text(
                    controller.expandedStatus[index] ? 'Collapse' : 'Expand',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Status: ${controller.openStatus[index] ? 'Open' : 'Closed'}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      controller.toggleOpenStatus(index);
                    },
                  ),
                ],
                onExpansionChanged: (value) {
                  controller.toggleExpandedStatus(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}

