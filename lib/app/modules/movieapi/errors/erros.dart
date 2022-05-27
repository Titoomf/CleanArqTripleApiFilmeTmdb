abstract class SearchMoviesException implements Exception {}

class InvalidMovieNameError implements SearchMoviesException {}

class CategoriesNotFound implements SearchMoviesException {
  final String? message;

  CategoriesNotFound({
    this.message,
  });
}

class CategoriesNotFoundException implements SearchMoviesException {}

class DataSourceSearchResultError implements SearchMoviesException {
  final String? message;

  DataSourceSearchResultError({
    this.message,
  });
}
