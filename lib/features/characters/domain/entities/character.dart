import 'package:equatable/equatable.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    this.type,
    this.gender,
    this.originName,
    this.locationName,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final String? type;
  final String? gender;
  final String? originName;
  final String? locationName;

  @override
  List<Object?> get props =>
      [id, name, status, species, image, type, gender, originName, locationName];
}
