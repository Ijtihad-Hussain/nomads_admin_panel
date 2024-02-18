
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../view/cities.dart';
import '../view/dashboard.dart';
import '../view/groups.dart';
import '../view/manageUserQueriesPage.dart';
import '../view/posts.dart';
import '../view/settings.dart';
import '../view/spaces.dart';
import '../view/users.dart';

class HomeController extends GetxController {
  Rx<Widget> selectedScreen = DashBoard().obs;

  void chooseScreen(String route) {
    switch (route) {
      case DashBoard.id:
        selectedScreen.value = DashBoard();
        break;
      case Posts.id:
        selectedScreen.value = const Posts();
        break;
      case Users.id:
        selectedScreen.value = const Users();
        break;
      case Groups.id:
        selectedScreen.value = Groups();
        break;
      case Cities.id:
        selectedScreen.value = const Cities();
        break;
      case Spaces.id:
        selectedScreen.value = Spaces();
        break;
      case ManageUserQueriesPage.id:
        selectedScreen.value = ManageUserQueriesPage();
        break;
      case Settings.id:
        selectedScreen.value = const Settings();
        break;
      default:
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

}