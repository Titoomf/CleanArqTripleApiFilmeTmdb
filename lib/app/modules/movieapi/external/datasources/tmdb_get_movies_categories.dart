import 'package:dio/dio.dart';

import '../../../shared/constants_api.dart';
import '../../errors/erros.dart';
import '../../infra/datasources/get_movie_categories_datasource.dart.dart';
import '../../infra/models/get_movie_category_model.dart';

class TmdbGetMovieCategoriesDataSource implements GetMovieCategoryDataSource {
  final Dio dio;

  TmdbGetMovieCategoriesDataSource(this.dio);

  @override
  Future<List<GetMovieCategoryModel>> getMovieCategories() async {
    try {
      final response = await dio.get(
        '${ConstantsApiUrls.baseUrl}${ConstantsApiUrls.getMovieCategories}',
        queryParameters: {
          'api_key': ConstantsApiUrls.apiKey,
        },
      );
      final movieCategoriesList = (response.data['genres'] as List)
          .map((e) => GetMovieCategoryModel.fromMap(e))
          .toList();
      return movieCategoriesList;
    } on DioError catch (e) {
      throw CategoriesNotFound(message: e.toString());
    }
  }
}
