import '../../domain/entities/params/search_movies_params.dart';
import '../models/result_search_movie_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchMovieModel>> getSearchMovie(
    SearchMoviesParams params,
  );
}
