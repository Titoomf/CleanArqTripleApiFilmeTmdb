import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie_category_entity.dart.dart';
import '../../../domain/entities/params/search_movies_params.dart';
import '../../../domain/entities/results_search_entity.dart';
import '../../../domain/usecases/get_movie_categories_usecase.dart';
import '../../../domain/usecases/search_movie_text_usecase.dart';
import '../../../errors/erros.dart';
import '../state/home_page_state.dart';

class HomePageStore extends StreamStore<SearchMoviesException, HomePageState> {
  final GetMovieCategoriesUseCase getMovieCategoriesUseCase;
  final SearchMovieTextUseCase searchMoviesByTextUsecase;

  HomePageStore(this.getMovieCategoriesUseCase, this.searchMoviesByTextUsecase)
      : super(HomePageState());

  int _getCurrentPage() {
    final int lengthPage = state.resultSearchList.length;

    // TODO: Divide, retornando um resultado inteiro (~/)
    return lengthPage ~/ 20;
  }

  Future<void> getMoviesText(String movieTitle) async {
    List<ResultSearchEntity> currentMoviesList = [];

    setLoading(true);
// TODO:CopyWith elegante que garante a cópia do objeto trocando apenas os itens solicitados e reaproveitando o restante.
    if (movieTitle.isEmpty) {
      update(
        state.copyWith(
          filteredCategoryResultSearchList: currentMoviesList,
        ),
      );
    }
    final result = await searchMoviesByTextUsecase(
        SearchMoviesParams(movieTitle: movieTitle, page: 1));

    result.fold(
      setError,
      (r) {
        update(
          state.copyWith(
            filteredCategoryResultSearchList: currentMoviesList,
            resultSearchList: r,
          ),
        );
      },
    );

    setLoading(false);
  }

  Future<void> getNextPage(String movieTitle) async {
    // List<ResultSearchEntity> currentMoviesList = [];

    setLoading(true);
// TODO:CopyWith elegante que garante a cópia do objeto trocando apenas os itens solicitados e reaproveitando o restante.

    final page = _getCurrentPage();
    final result = await searchMoviesByTextUsecase(
      SearchMoviesParams(movieTitle: movieTitle, page: page + 1),
    );

    result.fold(
      setError,
      (r) {
        update(
          state.copyWith(
            resultSearchList: state.resultSearchList + r,
          ),
        );
      },
    );

    setLoading(false);
  }

  Future<void> getMovieCategories() async {
    setLoading(true);

    final results = await getMovieCategoriesUseCase();

    results.fold(setError, ((movieCategory) {
      update(
        state.copyWith(
          movieCategories: [MovieCategoriesEntity(-1, "All"), ...movieCategory],
        ),
      );
    }));

    setLoading(false);
  }

  Future<void> filterMoviesCategory(int categoryId) async {
    setLoading(true);

    if (categoryId == -1) {
      update(
        state.copyWith(
          filteredCategoryResultSearchList: [],
        ),
      );

      setLoading(false);
      return;
    }

    List<ResultSearchEntity> result = state.resultSearchList
        .where((element) => element.movieCategory.contains(categoryId))
        .toList();

    update(
      state.copyWith(filteredCategoryResultSearchList: result),
    );
    setLoading(false);
  }
}
