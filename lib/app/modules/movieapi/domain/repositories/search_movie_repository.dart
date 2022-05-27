import 'package:dartz/dartz.dart';

import '../../errors/erros.dart';
import '../entities/params/search_movies_params.dart';
import '../entities/results_search_entity.dart';

abstract class SearchMovieRepository {
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> search(
    SearchMoviesParams params,
  );
}
