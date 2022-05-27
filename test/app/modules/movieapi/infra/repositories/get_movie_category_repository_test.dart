import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/movie_category_entity.dart.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/repositories/get_movie_category_repository.dart';
import 'package:cleanarqmovie/app/modules/movieapi/errors/erros.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/datasources/get_movie_categories_datasource.dart.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/models/get_movie_category_model.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/repositories/i_get_movie_category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieCategoryDatasourceMock extends Mock
    implements GetMovieCategoryDataSource {}

void main() {
  late GetMovieCategoryDataSource dataSource;
  late GetMovieCategoriesRepository repository;

  setUpAll(() {
    dataSource = GetMovieCategoryDatasourceMock();
    repository = GetMovieCategoryRepositoryImpl(dataSource);
  });

  test("Should return a list of MovieCategoryEntity", () async {
    when(() => dataSource.getMovieCategories())
        .thenAnswer((_) async => <GetMovieCategoryModel>[]);

    final result = await repository.getCategories();

    expect(result.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });

  test("Should return NotFoundMovieCategory", () async {
    when(() => dataSource.getMovieCategories())
        .thenThrow(CategoriesNotFoundException());

    final result = await repository.getCategories();

    expect(result.fold(id, id), isA<CategoriesNotFoundException>());
  });
}
