import 'package:dartz/dartz.dart';

import '../../errors/erros.dart';
import '../entities/movie_category_entity.dart.dart';
import '../repositories/get_movie_category_repository.dart';

abstract class GetMovieCategoriesUseCase {
  Future<Either<CategoriesNotFoundException, List<MovieCategoriesEntity>>>
      call();
}

class GetMovieCategoriesImpl implements GetMovieCategoriesUseCase {
  final GetMovieCategoriesRepository getMovieCategoriesRepository;

  GetMovieCategoriesImpl(this.getMovieCategoriesRepository);

  @override
  Future<Either<CategoriesNotFoundException, List<MovieCategoriesEntity>>>
      call() async {
    return getMovieCategoriesRepository.getCategories();
  }
}
