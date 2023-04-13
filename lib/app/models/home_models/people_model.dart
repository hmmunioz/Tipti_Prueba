import 'package:equatable/equatable.dart';
import 'package:tipti_test/app/models/home_models/movie_model.dart';

class PeopleModel extends Equatable {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final String created;
  final String edited;
  final String url;
  final List<MovieModel>? movieList;
  const PeopleModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
    this.movieList = const [],
  });

  PeopleModel copyWith({
    String? name,
    String? height,
    String? mass,
    String? hairColor,
    String? skinColor,
    String? eyeColor,
    String? birthYear,
    String? gender,
    String? homeworld,
    List<String>? films,
    List<String>? species,
    List<String>? vehicles,
    List<String>? starships,
    String? created,
    String? edited,
    String? url,
    List<MovieModel>? movieList,
  }) {
    return PeopleModel(
      name: name ?? this.name,
      height: height ?? this.height,
      mass: mass ?? this.mass,
      hairColor: hairColor ?? this.hairColor,
      skinColor: skinColor ?? this.skinColor,
      eyeColor: eyeColor ?? this.eyeColor,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      homeworld: homeworld ?? this.homeworld,
      films: films ?? this.films,
      species: species ?? this.species,
      vehicles: vehicles ?? this.vehicles,
      starships: starships ?? this.starships,
      created: created ?? this.created,
      edited: edited ?? this.edited,
      url: url ?? this.url,
      movieList: movieList ?? this.movieList,
    );
  }

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      name: json['name'] ?? "",
      height: json['height'] ?? "",
      mass: json['mass'] ?? "",
      hairColor: json['hairColor'] ?? "",
      skinColor: json['skinColor'] ?? "",
      eyeColor: json['eyeColor'] ?? "",
      birthYear: json['birthYear'] ?? "",
      gender: json['gender'] ?? "",
      homeworld: json['homeworld'] ?? "",
      films: json['films'] != null
          ? List<String>.from(json["films"].map((x) => x))
          : [],
      species: json['species'] != null
          ? List<String>.from(json["species"].map((x) => x))
          : [],
      vehicles: json['vehicles'] != null
          ? List<String>.from(json["vehicles"].map((x) => x))
          : [],
      starships: json['starships'] != null
          ? List<String>.from(json["starships"].map((x) => x))
          : [],
      created: json['created'] ?? "",
      edited: json['edited'] ?? "",
      url: json['url'] ?? "",
      movieList: const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'eyeColor': eyeColor,
      'birthYear': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'starships': starships,
      'created': created,
      'edited': edited,
      'url': url,
      'movieList': movieList,
    };
  }

  @override
  List<Object?> get props => [
        name,
        height,
        mass,
        hairColor,
        skinColor,
        eyeColor,
        birthYear,
        gender,
        homeworld,
        films,
        species,
        vehicles,
        starships,
        created,
        edited,
        url,
        movieList,
      ];
}
