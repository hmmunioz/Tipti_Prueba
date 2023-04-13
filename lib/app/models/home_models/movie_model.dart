import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final String title;
  final String episodeId;
  final String openingCrawl;
  final String director;
  final String producer;
  final String personName;
  final String releaseDate;

  const MovieModel({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.personName,
    required this.releaseDate,
  });

  MovieModel copyWith({
    String? title,
    String? episodeId,
    String? openingCrawl,
    String? director,
    String? producer,
    String? personName,
    String? releaseDate,
  }) {
    return MovieModel(
      title: title ?? this.title,
      episodeId: episodeId ?? this.episodeId,
      openingCrawl: openingCrawl ?? this.openingCrawl,
      director: director ?? this.director,
      producer: producer ?? this.producer,
      personName: personName ?? this.personName,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? "",
      episodeId: json['episodeId'] ?? "",
      openingCrawl: json['openingCrawl'] ?? "",
      director: json['director'] ?? "",
      producer: json['producer'] ?? "",
      personName: '',
      releaseDate: json['release_date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'episodeId': episodeId,
      'openingCrawl': openingCrawl,
      'director': director,
      'producer': producer,
      'personName': personName,
      'releaseDate': releaseDate,
    };
  }

  @override
  List<Object?> get props => [
        title,
        episodeId,
        openingCrawl,
        director,
        producer,
        personName,
        releaseDate,
      ];
}
