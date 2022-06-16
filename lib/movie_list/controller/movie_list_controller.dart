import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_app/movie_list/movie_list.dart';
import 'package:lazy_app/movie_list/repository/movie_list_repository.dart';

part 'movie_list_state.dart';

final movieListControllerProvider =
    StateNotifierProvider.autoDispose<MovieListController, MovieListState>(
  (ref) => MovieListController(
    repository: ref.read(movieListRepositoryProvider),
  )..fetchMovieList(),
);

class MovieListController extends StateNotifier<MovieListState> {
  MovieListController({
    required MovieListRepository repository,
  })  : _repository = repository,
        super(const MovieListState());
  final MovieListRepository _repository;

  Future<void> fetchMovieList() async {
    try {
      state = state.copyWith(
        status: MovieListStatus.fetchingMovieList,
      );

      final response = await _repository.fetchMovieList(
        page: state.page,
       category: 'popular'

      );
      state = state.copyWith(
        status: MovieListStatus.fetchMovieListSuccess,
        movies: response.results,
        page: state.page + 1,
        isLastPage: state.page == response.pages,
      );
    } catch (e) {
      state = state.copyWith(
        status: MovieListStatus.fetchMovieListError,
        message: e.toString(),
      );
    }
  }
}
