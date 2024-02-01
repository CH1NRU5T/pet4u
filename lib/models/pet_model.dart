import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Species {
  dog,
  cat,
  other,
}

class Pet {
  /// The name of the pet
  final String name;

  /// A description of the pet
  final String description;

  /// The image of the pet
  final String urlToImage;

  /// The id of the pet
  String id;

  final num age;

  final String breed;
  final num height;
  final Species species;
  final num weight;

  Pet({
    required this.name,
    required this.description,
    required this.urlToImage,
    required this.age,
    required this.breed,
    required this.height,
    required this.species,
    required this.weight,
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'urlToImage': urlToImage,
      'id': id,
      'age': age,
      'breed': breed,
      'height': height,
      'species': species.toString().split('.').last,
      'weight': weight,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      name: map['name'] as String,
      description: map['description'] as String,
      urlToImage: map['urlToImage'] as String,
      age: map['age'] as num,
      breed: map['breed'] as String,
      height: map['height'] as num,
      species: Species.values.firstWhere(
        (e) => e.toString() == 'Species.${map['species']}',
      ),
      weight: map['weight'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) =>
      Pet.fromMap(json.decode(source) as Map<String, dynamic>);
}
