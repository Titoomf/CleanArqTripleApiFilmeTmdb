import 'package:dio/dio.dart';

import '../../../shared/constants_api.dart';
import '../../domain/entities/params/search_movies_params.dart';
import '../../errors/erros.dart';
import '../../infra/datasources/search_movie_datasource.dart';
import '../../infra/models/result_search_movie_model.dart';

class TmdbSearchMoviesTextDataSource implements SearchDataSource {
  final Dio dio;

  TmdbSearchMoviesTextDataSource(this.dio);

  @override
  Future<List<ResultSearchMovieModel>> getSearchMovie(
      SearchMoviesParams params) async {
    try {
      final response = await dio.get(
        '${ConstantsApiUrls.baseUrl}${ConstantsApiUrls.searchMovieBytext}?api_key=${ConstantsApiUrls.apiKey}&query=${params.movieTitle}&page=${params.page}',
      );
      final list = (response.data['results'] as List)
          .map((e) => ResultSearchMovieModel.fromMap(e))
          .toList();
      return list;
    } on DioError catch (e) {
      throw DataSourceSearchResultError(
        message: e.toString(),
      );
    }
  }
}
