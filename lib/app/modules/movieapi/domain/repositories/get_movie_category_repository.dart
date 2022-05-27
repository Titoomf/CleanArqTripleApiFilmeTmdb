import 'package:dartz/dartz.dart';

import '../../errors/erros.dart';
import '../entities/movie_category_entity.dart.dart';

// so vai os contrato sem implementar,solid

abstract class GetMovieCategoriesRepository {
  Future<Either<CategoriesNotFoundException, List<MovieCategoriesEntity>>>
      getCategories();
}
