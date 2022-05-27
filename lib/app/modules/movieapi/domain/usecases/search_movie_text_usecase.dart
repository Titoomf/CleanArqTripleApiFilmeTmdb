import 'package:dartz/dartz.dart';

import '../../errors/erros.dart';
import '../entities/params/search_movies_params.dart';
import '../entities/results_search_entity.dart';
import '../repositories/search_movie_repository.dart';

abstract class SearchMovieTextUseCase {
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call(
    SearchMoviesParams params,
  );
}

class SearchMovieTextImpl implements SearchMovieTextUseCase {
  final SearchMovieRepository searchMovieRepository;

  SearchMovieTextImpl(
    this.searchMovieRepository,
  );

  @override
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call(
      SearchMoviesParams params) async {
    if (params.movieTitle.isEmpty) {
      return left(
        InvalidMovieNameError(),
      );
    }

    return searchMovieRepository.search(params);
  }
}
