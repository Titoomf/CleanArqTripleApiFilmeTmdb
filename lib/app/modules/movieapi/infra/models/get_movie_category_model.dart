import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../domain/entities/movie_category_entity.dart.dart';

class GetMovieCategoryModel extends MovieCategoriesEntity {
  GetMovieCategoryModel({
    required int id,
    required String category,
  }) : super(id, category);

  Map topMap() {
    return {'id': id, 'category': category};
  }

  factory GetMovieCategoryModel.fromMap(Map map) {
    return GetMovieCategoryModel(
        id: map['id'] ?? 0, category: map['name'] ?? '');
  }

  String toJson() => jsonEncode(topMap());

  factory GetMovieCategoryModel.fromJson(source) =>
      GetMovieCategoryModel.fromMap(jsonDecode(source));
}
