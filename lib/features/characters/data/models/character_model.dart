import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.image,
    super.type,
    super.gender,
    super.originName,
    super.locationName,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final origin = json['origin'];
    final location = json['location'];
    return CharacterModel(
      id: json['id'] as int,
      name: (json['name'] as String?) ?? '',
      status: (json['status'] as String?) ?? '',
      species: (json['species'] as String?) ?? '',
      image: (json['image'] as String?) ?? '',
      type: json['type'] as String?,
      gender: json['gender'] as String?,
      originName: origin is Map<String, dynamic>
          ? origin['name'] as String?
          : null,
      locationName: location is Map<String, dynamic>
          ? location['name'] as String?
          : null,
    );
  }

  static List<CharacterModel> listFromJson(List<dynamic> list) {
    return list
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
