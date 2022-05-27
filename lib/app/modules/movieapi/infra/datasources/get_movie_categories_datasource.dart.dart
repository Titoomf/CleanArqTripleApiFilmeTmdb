import '../models/get_movie_category_model.dart';

abstract class GetMovieCategoryDataSource {
  Future<List<GetMovieCategoryModel>> getMovieCategories();
}
