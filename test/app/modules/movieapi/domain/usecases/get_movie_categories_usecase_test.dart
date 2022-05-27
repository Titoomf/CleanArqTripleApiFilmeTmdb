import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/movie_category_entity.dart.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/repositories/get_movie_category_repository.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/usecases/get_movie_categories_usecase.dart';
import 'package:cleanarqmovie/app/modules/movieapi/errors/erros.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SelectMovieCategoryRepositoryMock extends Mock
    implements GetMovieCategoriesRepository {}

void main() {
  late GetMovieCategoriesRepository repository;

  late GetMovieCategoriesUseCase usecase;

  setUpAll(() {
    repository = SelectMovieCategoryRepositoryMock();

    usecase = GetMovieCategoriesImpl(repository);
  });

  test('Should return a MovieCategoriesEntity List', () async {
    when(() => repository.getCategories()).thenAnswer(
        (invocation) async => const Right(<MovieCategoriesEntity>[]));

    var results = await usecase();

    expect(results.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });
  test('Should return a CategoriesUnavailable error', () async {
    when(() => repository.getCategories())
        .thenAnswer((_) async => Left(CategoriesNotFoundException()));

    var results = await usecase();

    expect(results.fold(id, id), isA<CategoriesNotFoundException>());
  });
}
