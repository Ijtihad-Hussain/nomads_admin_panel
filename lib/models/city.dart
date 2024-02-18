import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String cityId;
  final String name;
  final String country;
  final String? continent;
  final String? image;
  final double? numberOfClients;
  final double? crimeIndex;
  final double? rent;
  final double? temperature;
  final double? internet;
  final double? qualityOfLife;
  final double? familyScore;
  final double? communityScore;
  final double? costScore;

  City({
    required this.cityId,
    required this.name,
    required this.country,
    this.continent,
    this.image,
    this.numberOfClients,
    this.crimeIndex,
    this.rent,
    this.temperature,
    this.internet,
    this.qualityOfLife,
    this.communityScore,
    this.costScore,
    this.familyScore
  });

  factory City.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return City(
      cityId: doc.id,
      name: data['name'],
      country: data['country'],
      continent: data['continent'],
      qualityOfLife: double.tryParse(data['qualityOfLife']?.toString() ?? '0'),
      familyScore: double.tryParse(data['familyScore']?.toString() ?? '0'),
      communityScore: double.tryParse(data['communityScore']?.toString() ?? '0'),
      costScore: double.tryParse(data['costScore']?.toString() ?? '0'),
      image: data['image'],
      numberOfClients: double.tryParse(data['numberOfClients']?.toString() ?? '1'),
      crimeIndex: double.tryParse(data['crimeIndex']?.toString() ?? '0'),
      rent: double.tryParse(data['rent']?.toString() ?? '0'),
      temperature: double.tryParse(data['temperature']?.toString() ?? '0'),
      internet: double.tryParse(data['internet']?.toString() ?? '0'),
    );
  }
}