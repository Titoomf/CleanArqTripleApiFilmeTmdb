import 'package:dartz/dartz.dart';

import '../../domain/entities/movie_category_entity.dart.dart';
import '../../domain/repositories/get_movie_category_repository.dart';
import '../../errors/erros.dart';
import '../datasources/get_movie_categories_datasource.dart.dart';
import '../models/get_movie_category_model.dart';

class GetMovieCategoryRepositoryImpl implements GetMovieCategoriesRepository {
  final GetMovieCategoryDataSource dataSource;

  GetMovieCategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<CategoriesNotFoundException, List<MovieCategoriesEntity>>>
      getCategories() async {
    try {
      final List<GetMovieCategoryModel> categoriesList =
          await dataSource.getMovieCategories();
      return right(categoriesList);
    } on CategoriesNotFoundException {
      return left(
        CategoriesNotFoundException(),
      );
    }
  }
}
