import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_mads_admin_panel/view/posts.dart';
import 'package:for_mads_admin_panel/view/settings.dart';
import 'package:for_mads_admin_panel/view/spaces.dart';
import 'package:for_mads_admin_panel/view/users.dart';
import 'package:for_mads_admin_panel/view/dashboard.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../controllers/home_controller.dart';
import 'cities.dart';
import 'groups.dart';
import 'manageUserQueriesPage.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "webdoctors";
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Center(child: Text('Dashboard')),
      ),
      body: Row(
        children: [
          Obx(
                () => SideBar(
              onSelected: (item) {
                controller.chooseScreen(item.route!);
              },
              items: const [
                AdminMenuItem(
                  title: 'Dashboard',
                  route: DashBoard.id,
                ),
                AdminMenuItem(
                  title: 'Posts',
                  route: Posts.id,
                ),
                AdminMenuItem(
                  title: 'Users',
                  route: Users.id,
                ),
                AdminMenuItem(
                  title: 'Groups',
                  route: Groups.id,
                ),
                AdminMenuItem(
                  title: 'Cities',
                  route: Cities.id,
                ),
                AdminMenuItem(
                  title: 'Spaces',
                  route: Spaces.id,
                ),
                AdminMenuItem(
                  title: 'Queries',
                  route: ManageUserQueriesPage.id,
                ),
                AdminMenuItem(
                  title: 'Settings',
                  route: Settings.id,
                ),
              ],
              selectedRoute: HomeScreen.id,
              footer: IconButton(
                icon: Icon(Icons.logout),
                onPressed: controller.logout,
              ),
            ),
          ),
          Expanded(
            child: Obx(() => controller.selectedScreen.value),
          ),
        ],
      ),
    );
  }
}

