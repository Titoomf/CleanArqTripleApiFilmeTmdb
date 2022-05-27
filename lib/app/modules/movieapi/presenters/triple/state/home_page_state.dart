import '../../../domain/entities/movie_category_entity.dart.dart';
import '../../../domain/entities/results_search_entity.dart';

class HomePageState {
  final List<ResultSearchEntity> resultSearchList;
  final List<ResultSearchEntity> filteredCategoryResultSearchList;
  final List<MovieCategoriesEntity> movieCategories;

  HomePageState({
    this.resultSearchList = const [],
    this.filteredCategoryResultSearchList = const [],
    this.movieCategories = const [],
  });

  HomePageState copyWith({
    List<ResultSearchEntity>? resultSearchList,
    List<ResultSearchEntity>? filteredCategoryResultSearchList,
    List<MovieCategoriesEntity>? movieCategories,
  }) {
    return HomePageState(
      resultSearchList: resultSearchList ?? this.resultSearchList,
      filteredCategoryResultSearchList: filteredCategoryResultSearchList ??
          this.filteredCategoryResultSearchList,
      movieCategories: movieCategories ?? this.movieCategories,
    );
  }
}
