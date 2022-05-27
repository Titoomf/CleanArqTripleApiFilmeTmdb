import 'package:cleanarqmovie/app/modules/movieapi/errors/erros.dart';
import 'package:cleanarqmovie/app/modules/movieapi/external/datasources/tmdb_get_movies_categories.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/datasources/get_movie_categories_datasource.dart.dart';
import 'package:cleanarqmovie/app/modules/movieapi/infra/models/get_movie_category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/categories_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  // TODO: Varivais que tenho certeza que vao ser inicializada
  late Dio dio;
  late GetMovieCategoryDataSource dataSource;
  final request = RequestOptions(path: "");

// TODO:inicializando o late da variaveis de cima
  setUpAll(() {
    dio = DioMock();
    dataSource = TmdbGetMovieCategoriesDataSource(dio);
  });

  test('Should return a list of GetMovieCategoryModel ', () {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: request,
        statusCode: 200,
        data: tmdbCategoriesResponse,
      ),
    );

    final results = dataSource.getMovieCategories();

    expect(results, isA<List<GetMovieCategoryModel>>());
  });
  test('Should return a  CategoriesNotFound error', () {
    when(() => dio.get(any())).thenAnswer(
      (invocation) async => Response(
        requestOptions: request,
        statusCode: 401,
        data: null,
      ),
    );

    final results = dataSource.getMovieCategories();

    expect(results, throwsA(isA<CategoriesNotFoundException>()));
  });
}
