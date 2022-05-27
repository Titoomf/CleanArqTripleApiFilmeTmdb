import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/params/search_movies_params.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/results_search_entity.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/repositories/search_movie_repository.dart';
import 'package:cleanarqmovie/app/modules/movieapi/errors/erros.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/datasources/search_movie_datasource.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/models/result_search_movie_model.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/repositories/i_search_movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositorDatasourceMock extends Mock implements SearchDataSource {}

void main() {
  late SearchRepositorDatasourceMock datasource;

  late SearchMovieRepository repository;

  setUpAll(() {
    datasource = SearchRepositorDatasourceMock();
    repository = SearchRepositoryImpl(datasource);
    registerFallbackValue(SearchMoviesParams());
  });

  test('Should return a list of ResultSearchEntity', () async {
    when(() => datasource.getSearchMovie(any()))
        .thenAnswer((_) async => <ResultSearchMovieModel>[]);

    final result =
        await repository.search(SearchMoviesParams(movieTitle: 'batman'));

    expect(result.fold(id, id), isA<List<ResultSearchEntity>>());
  });
  test(
      'Should return DataSourceSearchResultNull or DataSourceSearchResultError',
      () async {
    when(() => datasource.getSearchMovie(any()))
        .thenThrow(DataSourceSearchResultError());

    final result =
        await repository.search(SearchMoviesParams(movieTitle: 'batman'));

    expect(result.fold(id, id), isA<DataSourceSearchResultError>());
  });
}
