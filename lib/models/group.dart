import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Group {
  final String groupId;
  final String name;
  final String admin;
  final String? image;
  final double? numberOfMembers;

  Group({
    required this.groupId,
    required this.name,
    required this.admin,
    this.image,
    this.numberOfMembers,
  });

  factory Group.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Group(
      groupId: doc.id,
      name: data['name'],
      admin: data['admin'],
      image: data['image'],
      numberOfMembers: double.tryParse(data['numberOfMembers']?.toString() ?? '1'),
    );
  }
}