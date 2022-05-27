import 'package:dartz/dartz.dart';

import '../../domain/entities/params/search_movies_params.dart';
import '../../domain/entities/results_search_entity.dart';
import '../../domain/repositories/search_movie_repository.dart';
import '../../errors/erros.dart';
import '../datasources/search_movie_datasource.dart';
import '../models/result_search_movie_model.dart';

class SearchRepositoryImpl implements SearchMovieRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);
  @override
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> search(
      SearchMoviesParams params) async {
    try {
      final List<ResultSearchMovieModel> list =
          await dataSource.getSearchMovie(params);
      return right(list);
    } on DataSourceSearchResultError catch (e) {
      return left(e);
    }
  }
}
