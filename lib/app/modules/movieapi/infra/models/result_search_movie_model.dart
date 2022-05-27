import 'dart:convert';

import '../../domain/entities/results_search_entity.dart';

class ResultSearchMovieModel extends ResultSearchEntity {
  ResultSearchMovieModel({
    required String movieImage,
    required String movieTitle,
    required List movieCategory,
    required String movieAccent,
    required double movieRating,
  }) : super(
          movieImage,
          movieTitle,
          movieCategory,
          movieAccent,
          movieRating,
        );

  Map<String, dynamic> toMap() {
    return {
      'backdrop_path': movieImage,
      'title': movieTitle,
      'genre_ids': movieCategory,
      'original_language': movieAccent,
      'vote_average': movieRating,
    };
  }

  factory ResultSearchMovieModel.fromMap(Map map) {
    return ResultSearchMovieModel(
      movieTitle: map['title'] ?? '',
      movieCategory: map['genre_ids'] ?? [],
      movieAccent: map['original_language'] ?? '',
      movieRating: double.parse(map['vote_average'].toString()),
      movieImage: map['poster_path'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ResultSearchMovieModel.fromJson(String source) =>
      ResultSearchMovieModel.fromMap(json.decode(source));
}
