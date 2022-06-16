part of 'movie_list_controller.dart';
enum MovieListStatus {
  initial,
  fetchingMovieList,
  fetchMovieListSuccess,
  fetchMovieListError,
  fetchingMoreUsers,
  fetchMoreMoviesError,
  fetchMoreMoviesSuccess,
  refreshingMovies,
  refreshMoviesSuccess,
  refreshMoviesError,
}

enum MovieCategory {
  categoryLatest,
  categoryNowPlaying,
  categoryPopular,
  categoryTopRated,
  categoryUpComing,
}

class MovieListState extends Equatable {
  final MovieListStatus status;
  final String message;
  final List<Movie> movies;
  final int page;
  final bool isLastPage;

  const MovieListState({
    this.status = MovieListStatus.initial,
    this.message = '',
    this.movies = const [],
    this.page = 1,
    this.isLastPage = false,
  });

  MovieListState copyWith({
    MovieListStatus? status,
    String? message,
    List<Movie>? movies,
    int? page,
    bool? isLastPage,
  }) {
    return MovieListState(
      status: status ?? this.status,
      message: message ?? this.message,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => throw [status, message, movies, page, isLastPage];
}
