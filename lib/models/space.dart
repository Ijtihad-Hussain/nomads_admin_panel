
import 'package:cloud_firestore/cloud_firestore.dart';

class Space {
  final String spaceId;
  final String name;
  final String address;
  final String phone;
  final String? image;
  final double? internet;
  final DateTime startTime;
  final DateTime endTime;

  Space({
    required this.spaceId,
    required this.name,
    required this.address,
    required this.phone,
    this.image,
    this.internet,
    required this.startTime,
    required this.endTime,
  });

  factory Space.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Space(
      spaceId: doc.id,
      name: data['name'],
      image: data['image'],
      address: data['address'],
      phone: data['phone'],
      internet: double.tryParse(data['internet']?.toString() ?? '0'),
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
    );
  }
}