// passsa um argumentos para rotas nomeadas
class SearchMoviesParams {
  final int page;
  final String movieTitle;

  SearchMoviesParams({
    this.page = 1,
    this.movieTitle = '',
  });
}
