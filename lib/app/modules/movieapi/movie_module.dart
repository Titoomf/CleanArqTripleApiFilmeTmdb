import 'package:cleanarqmovie/app/modules/movieapi/presenters/triple/store/home_page_store.dart';
import 'package:cleanarqmovie/app/modules/movieapi/presenters/views/pages/home_page_search_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_movie_categories_usecase.dart';
import 'domain/usecases/search_movie_text_usecase.dart';
import 'external/datasources/tmdb_get_movies_categories.dart';
import 'external/datasources/tmdb_search_movies_text_datasource.dart';
import 'infra/repositories/i_get_movie_category_repository.dart';
import 'infra/repositories/i_search_movie_repository.dart';

class HomePageModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => GetMovieCategoriesImpl(i())),
        Bind.factory((i) => GetMovieCategoryRepositoryImpl(i())),
        Bind.factory((i) => TmdbGetMovieCategoriesDataSource(i())),
        Bind.factory((i) => SearchMovieTextImpl(i())),
        Bind.factory((i) => SearchRepositoryImpl(i())),
        Bind.factory((i) => TmdbSearchMoviesTextDataSource(i())),
        Bind((i) => HomePageStore(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const HomePage(),
        )
      ];
}
