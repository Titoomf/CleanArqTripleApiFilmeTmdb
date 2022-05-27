import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/params/search_movies_params.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/entities/results_search_entity.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/repositories/search_movie_repository.dart';
import 'package:cleanarqmovie/app/modules/movieapi/domain/usecases/search_movie_text_usecase.dart';
import 'package:cleanarqmovie/app/modules/movieapi/errors/erros.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchMovieRepository {}

void main() {
  late SearchMovieRepository repository;

  late SearchMovieTextUseCase usecase;

  setUpAll(() {
    repository = SearchRepositoryMock();
    usecase = SearchMovieTextImpl(repository);
    registerFallbackValue(SearchMoviesParams());
  });

  test('Should return a list from ResultSearchEntity', () async {
    when(() => repository.search(any())).thenAnswer((_) async {
      return right(<ResultSearchEntity>[]);
    });

    var result = await usecase(SearchMoviesParams(movieTitle: 'batman'));

    expect(result.fold(id, id), isA<List<ResultSearchEntity>>());
  });

  test('Should return a SearchMoviesException', () async {
    when(() => repository.search(SearchMoviesParams()))
        .thenAnswer((_) async => Left(InvalidMovieNameError()));

    var result = await usecase(SearchMoviesParams());

    expect(result.fold(id, id), isA<InvalidMovieNameError>());
  });
}
